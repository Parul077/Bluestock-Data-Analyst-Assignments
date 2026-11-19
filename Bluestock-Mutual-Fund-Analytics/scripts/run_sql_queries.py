
import sqlite3
import pandas as pd
from pathlib import Path

print("=" * 65)
print("BLUESTOCK MUTUAL FUND ANALYTICS")
print("SQL QUERY EXECUTION AND VALIDATION")
print("=" * 65)

# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent
DB_FILE = BASE_DIR / "bluestock_mf.db"
SQL_FILE = BASE_DIR / "sql" / "queries.sql"
OUTPUT_DIR = BASE_DIR / "reports" / "sql_query_results"

# Check required files
if not DB_FILE.exists():
    raise FileNotFoundError(f"Database not found: {DB_FILE}")

if not SQL_FILE.exists():
    raise FileNotFoundError(f"SQL file not found: {SQL_FILE}")

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Read SQL queries
sql_text = SQL_FILE.read_text(encoding="utf-8")

# Split individual SQL statements
queries = [
    statement.strip()
    for statement in sql_text.split(";")
    if statement.strip()
]

print(f"\nTotal SQL statements found: {len(queries)}")

if len(queries) != 10:
    raise ValueError(
        f"Expected 10 queries, but found {len(queries)}. "
        "Please check queries.sql."
    )

# Connect to SQLite database
conn = sqlite3.connect(DB_FILE)

successful_queries = 0
failed_queries = 0

try:
    for index, query in enumerate(queries, start=1):

        print("\n" + "=" * 65)
        print(f"QUERY {index}")
        print("=" * 65)

        try:
            # Execute query and collect results
            result = pd.read_sql_query(query, conn)

            # Save complete results
            output_file = OUTPUT_DIR / f"query_{index:02d}_results.csv"
            result.to_csv(output_file, index=False)

            # Display preview
            print("Status: SUCCESS")
            print("Rows returned:", len(result))
            print("Columns:", list(result.columns))

            if result.empty:
                print("WARNING: Query returned no records.")
            else:
                print("\nResult preview:")
                print(result.head(10).to_string(index=False))

            print("\nSaved:", output_file)

            successful_queries += 1

        except Exception as error:
            print("Status: FAILED")
            print("Error:", error)
            failed_queries += 1

finally:
    conn.close()

# Final summary
print("\n" + "=" * 65)
print("SQL EXECUTION SUMMARY")
print("=" * 65)

print("Total queries:", len(queries))
print("Successful queries:", successful_queries)
print("Failed queries:", failed_queries)

print("\nResult files saved in:")
print(OUTPUT_DIR)

if successful_queries == 10 and failed_queries == 0:
    print("\nALL 10 QUERIES EXECUTED SUCCESSFULLY!")
else:
    print("\nSome queries need attention. Check the errors above.")

print("\nSQL QUERY EXECUTION COMPLETED")
