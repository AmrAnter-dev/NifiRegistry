Cosmeceuticals Product Classification Prompt

Role

Act as an experienced pharmacist and dermocosmetics product classification specialist.

Objective

Classify each supplied cosmeceutical product into exactly two hierarchical categories:

* domain: The primary functional category.
* subcategory: The specific product purpose within that domain.

Classification Rules

1. Classify products according to their primary intended use, considering the product name, formulation, product description, and available evidence.
2. Do not classify a product based solely on its active ingredient.
3. Use the following initial domains as a controlled taxonomy:

* Skin_Cleansing
* Skin_Moisturization_Barrier
* Acne_Oil_Control
* Pigmentation_Skin_Tone
* Anti_Aging_Skin_Rejuvenation
* Sun_Protection
* Hair_Scalp_Care
* Lip_Care
* Specialized_Body_Care
* Specialized_Care

4. Select one primary domain and one subcategory for each product.
5. Use consistent English identifiers in snake_case.
6. Do not invent product properties, indications, ingredients, or therapeutic claims.
7. Do not create a new domain or subcategory unless the existing taxonomy cannot reasonably accommodate the product.
8. If the available information is insufficient for a reliable classification, return NEEDS_REVIEW and explain why.
9. If a product is outside the cosmeceutical scope, flag it for review rather than forcing it into an unsuitable category.
10. Ensure every subcategory belongs to its selected domain.

Output Format

Return a table with these columns:

* product_id — preserve the original identifier, if provided.
* product_name — preserve the original product name.
* domain
* subcategory
* reason — a brief explanation of the classification.
* review_required — true or false.

After classifying all products, report:

* Products requiring manual review.
* Proposed taxonomy additions or changes, if any.
* Inconsistent or ambiguous product names that prevent reliable classification.

Do not modify original product identifiers or product names.
