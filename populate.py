import psycopg
from psycopg import sql

from config import BRANCH_DATABASES


WAREHOUSE = {
    "host": "localhost",
    "port": 5432,
    "username": "postgres",
    "password": "postgres",
    "database": "warehouse",
}


SCHEMA = "inventory"
TABLE = "product_inventory"


def build_connection_string(config: dict, database: str) -> str:
    return (
        f"host={config['host']} "
        f"port={config['port']} "
        f"user={config['username']} "
        f"password={config['password']} "
        f"dbname={database}"
    )


def get_columns(conn):
    query = """
        SELECT column_name
        FROM information_schema.columns
        WHERE table_schema = %s
          AND table_name = %s
        ORDER BY ordinal_position
    """

    with conn.cursor() as cur:
        cur.execute(query, (SCHEMA, TABLE))

        return [row[0] for row in cur.fetchall()]


def copy_branch(branch_name: str, branch_config: dict):

    source_conn_string = build_connection_string(
        branch_config,
        branch_name,
    )

    warehouse_conn_string = build_connection_string(
        WAREHOUSE,
        WAREHOUSE["database"],
    )

    print(f"\n[{branch_name}] Starting...")

    with (
        psycopg.connect(source_conn_string) as source_conn,
        psycopg.connect(warehouse_conn_string) as warehouse_conn,
    ):

        columns = get_columns(source_conn)

        if not columns:
            raise RuntimeError(
                f"{branch_name}: "
                f"{SCHEMA}.{TABLE} does not exist"
            )

        column_list = sql.SQL(", ").join(
            sql.Identifier(column)
            for column in columns
        )

        copy_out = sql.SQL("""
            COPY (
                SELECT {columns}
                FROM {schema}.{table}
            )
            TO STDOUT
            WITH (FORMAT CSV)
        """).format(
            columns=column_list,
            schema=sql.Identifier(SCHEMA),
            table=sql.Identifier(TABLE),
        )

        copy_in = sql.SQL("""
            COPY {schema}.{table} ({columns})
            FROM STDIN
            WITH (FORMAT CSV)
        """).format(
            schema=sql.Identifier(SCHEMA),
            table=sql.Identifier(TABLE),
            columns=column_list,
        )

        with (
            source_conn.cursor() as source_cur,
            warehouse_conn.cursor() as warehouse_cur,
        ):

            with source_cur.copy(copy_out) as source_copy:
                with warehouse_cur.copy(copy_in) as warehouse_copy:

                    while data := source_copy.read():
                        warehouse_copy.write(data)

            warehouse_conn.commit()

    print(f"[{branch_name}] Done.")


def initial_load():

    for branch_name, branch_config in BRANCH_DATABASES.items():

        try:
            copy_branch(
                branch_name,
                branch_config,
            )

        except Exception as exc:
            print(
                f"[ERROR] {branch_name}: {exc}"
            )
            raise


if __name__ == "__main__":
    initial_load()
