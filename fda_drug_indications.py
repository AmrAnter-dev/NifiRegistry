import requests
import time
import re
from typing import Optional

from sqlalchemy import create_engine, text


FDA_URL = "https://api.fda.gov/drug/label.json"

engine = create_engine(
    "postgresql+psycopg2://postgres:password@localhost:5432/pharmacy"
)


def normalize_product_name(name: str) -> str:
    """
    Convert Egyptian pharmaceutical product name
    to a simpler brand-name candidate for FDA search.
    """

    if not name:
        return ""

    name = name.upper().strip()

    # Remove common strength/package information
    name = re.sub(
        r"\b\d+(?:\.\d+)?\s*(MG|MCG|G|GM|ML|%|IU|MIU)\b",
        " ",
        name,
    )

    # Remove common package/form information
    name = re.sub(
        r"\b\d+\s*(TAB|TABS|TABLET|TABLETS|CAP|CAPS|CAPSULE|"
        r"CAPSULES|AMP|AMPS|AMPOULE|AMPOULES|VIAL|VIALS|"
        r"ML|SACHET|SACHETS|BOTTLE|BOTTLES)\b",
        " ",
        name,
    )

    # Remove standalone numbers
    name = re.sub(r"\b\d+\b", " ", name)

    # Remove punctuation
    name = re.sub(r"[^A-Z0-9\s]", " ", name)

    # Normalize spaces
    name = re.sub(r"\s+", " ", name).strip()

    return name

def search_fda_brand(
    brand_name: str,
    limit: int = 10,
) -> list[dict]:

    if not brand_name:
        return []

    params = {
        "search": f'openfda.brand_name:"{brand_name}"',
        "limit": limit,
    }

    response = requests.get(
        FDA_URL,
        params=params,
        timeout=15,
    )

    # openFDA returns 404 when no matching records exist
    if response.status_code == 404:
        return []

    response.raise_for_status()

    return response.json().get("results", [])

def extract_uses(results: list[dict]) -> list[str]:

    uses = []

    for result in results:

        indications = result.get(
            "indications_and_usage",
            []
        )

        if isinstance(indications, str):
            indications = [indications]

        for indication in indications:

            if indication and indication not in uses:
                uses.append(indication)

    return uses
  def get_fda_uses(product_name: str) -> Optional[dict]:

    brand_name = normalize_product_name(product_name)

    if not brand_name:
        return None

    results = search_fda_brand(brand_name)

    if not results:
        return None

    uses = extract_uses(results)

    if not uses:
        return None

    return {
        "brand_name": brand_name,
        "uses": uses,
        "raw_results": results,
    }

def get_products_without_uses():

    query = text("""
        SELECT
            item_code,
            name
        FROM product
        WHERE uses IS NULL
           OR cardinality(uses) = 0
        ORDER BY item_code
    """)

    with engine.connect() as conn:
        return conn.execute(query).fetchall()

  def update_product_uses(
    item_code: int,
    uses: list[str],
):

    query = text("""
        UPDATE product
        SET
            uses = :uses,
            uses_source = 'openFDA',
            uses_updated_at = NOW()
        WHERE item_code = :item_code
    """)

    with engine.begin() as conn:

        conn.execute(
            query,
            {
                "item_code": item_code,
                "uses": uses,
            }
        )

  def process_products():

    products = get_products_without_uses()

    print(f"Products to process: {len(products)}")

    matched = 0
    not_found = 0

    for index, product in enumerate(products, start=1):

        item_code = product.item_code
        product_name = product.name

        print(
            f"[{index}/{len(products)}] "
            f"{item_code} - {product_name}"
        )

        try:

            result = get_fda_uses(product_name)

            if result is None:

                not_found += 1

                print("  -> FDA match not found")

                continue

            uses = result["uses"]

            update_product_uses(
                item_code=item_code,
                uses=uses,
            )

            matched += 1

            print(
                f"  -> matched ({len(uses)} uses)"
            )

        except requests.RequestException as exc:

            print(
                f"  -> FDA request failed: {exc}"
            )

        except Exception as exc:

            print(
                f"  -> ERROR: {exc}"
            )

        # Don't hammer the API
        time.sleep(0.2)

    print("\nFinished")
    print(f"Matched: {matched}")
    print(f"Not found: {not_found}")
