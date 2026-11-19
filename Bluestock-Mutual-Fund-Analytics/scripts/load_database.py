
import sqlite3
import pandas as pd
from pathlib import Path

print("=" * 60)
print("BLUESTOCK MUTUAL FUND DATABASE LOADING")
print("=" * 60)

# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent
RAW_DIR = BASE_DIR / "data" / "raw"
PROCESSED_DIR = BASE_DIR / "data" / "processed"
SQL_FILE = BASE_DIR / "sql" / "schema.sql"
DB_FILE = BASE_DIR / "bluestock_mf.db"


def read_csv(path):
    """Read a CSV while preserving AMFI codes as text."""
    return pd.read_csv(path, dtype={"amfi_code": "string"})


def standardize_code(df):
    """Standardize AMFI codes for matching across tables."""
    if "amfi_code" in df.columns:
        df["amfi_code"] = df["amfi_code"].astype("string").str.strip()
    return df


def standardize_date(df, column):
    """Convert a date column to YYYY-MM-DD text."""
    df[column] = pd.to_datetime(
        df[column], errors="coerce"
    ).dt.strftime("%Y-%m-%d")
    return df


# Check required files
required_files = [
    SQL_FILE,
    RAW_DIR / "01_fund_master.csv",
    RAW_DIR / "03_aum_by_fund_house.csv",
    RAW_DIR / "04_monthly_sip_inflows.csv",
    RAW_DIR / "05_category_inflows.csv",
    RAW_DIR / "06_industry_folio_count.csv",
    PROCESSED_DIR / "clean_nav.csv",
    PROCESSED_DIR / "clean_transactions.csv",
    PROCESSED_DIR / "clean_performance.csv",
    RAW_DIR / "09_portfolio_holdings.csv",
    RAW_DIR / "10_benchmark_indices.csv"
]

missing_files = [str(p) for p in required_files if not p.exists()]

if missing_files:
    raise FileNotFoundError(
        "Missing required files:\n" + "\n".join(missing_files)
    )

# Load source datasets
fund = standardize_code(read_csv(RAW_DIR / "01_fund_master.csv"))
nav = standardize_code(read_csv(PROCESSED_DIR / "clean_nav.csv"))
transactions = standardize_code(
    read_csv(PROCESSED_DIR / "clean_transactions.csv")
)
performance = standardize_code(
    read_csv(PROCESSED_DIR / "clean_performance.csv")
)

aum = read_csv(RAW_DIR / "03_aum_by_fund_house.csv")
sip = read_csv(RAW_DIR / "04_monthly_sip_inflows.csv")
category = read_csv(RAW_DIR / "05_category_inflows.csv")
folios = read_csv(RAW_DIR / "06_industry_folio_count.csv")
portfolio = standardize_code(
    read_csv(RAW_DIR / "09_portfolio_holdings.csv")
)
benchmark = read_csv(RAW_DIR / "10_benchmark_indices.csv")

# Normalize transaction labels
type_map = {
    "sip": "SIP",
    "lumpsum": "Lumpsum",
    "redemption": "Redemption"
}
transactions["transaction_type"] = (
    transactions["transaction_type"]
    .astype("string")
    .str.strip()
    .str.lower()
    .map(type_map)
)

# Standardize dates
nav = standardize_date(nav, "date")
transactions = standardize_date(transactions, "transaction_date")
portfolio = standardize_date(portfolio, "portfolio_date")
aum = standardize_date(aum, "date")
benchmark = standardize_date(benchmark, "date")

# Calculate daily NAV returns
nav = nav.sort_values(["amfi_code", "date"])
nav["daily_return"] = (
    nav.groupby("amfi_code")["nav"].pct_change()
)

# Prepare date dimension from all daily date sources
all_dates = pd.concat([
    nav["date"],
    transactions["transaction_date"],
    portfolio["portfolio_date"],
    aum["date"],
    benchmark["date"]
], ignore_index=True)

all_dates = pd.to_datetime(all_dates, errors="coerce").dropna()
unique_dates = sorted(all_dates.dt.normalize().unique())

date_dim = pd.DataFrame({"date": unique_dates})
date_dim["date"] = pd.to_datetime(date_dim["date"]).dt.strftime("%Y-%m-%d")
date_dim["year"] = pd.to_datetime(date_dim["date"]).dt.year
date_dim["month"] = pd.to_datetime(date_dim["date"]).dt.month
date_dim["quarter"] = pd.to_datetime(date_dim["date"]).dt.quarter
date_dim["is_weekday"] = (
    pd.to_datetime(date_dim["date"]).dt.weekday < 5
).astype(int)
date_dim.insert(0, "date_id", range(1, len(date_dim) + 1))

# Prepare monthly datasets
for df in [sip, category, folios]:
    df["month"] = pd.to_datetime(
        df["month"], errors="coerce"
    ).dt.strftime("%Y-%m")

# Open database and enable foreign keys
with sqlite3.connect(DB_FILE) as conn:
    conn.execute("PRAGMA foreign_keys = ON")

    # Create all tables and indexes
    schema = SQL_FILE.read_text(encoding="utf-8")
    conn.executescript(schema)

    # Clear old data in dependency order to allow safe reruns
    tables_to_clear = [
        "fact_nav",
        "fact_transactions",
        "fact_performance",
        "fact_portfolio",
        "fact_aum",
        "fact_sip_industry",
        "fact_category_inflows",
        "fact_industry_folios",
        "fact_benchmark_indices",
        "dim_date",
        "dim_fund"
    ]

    for table in tables_to_clear:
        conn.execute(f"DELETE FROM {table}")

    # 1. Load fund dimension
    fund.to_sql("dim_fund", conn, if_exists="append", index=False)

    # 2. Load date dimension
    date_dim.to_sql("dim_date", conn, if_exists="append", index=False)

    # 3. Load NAV fact
    nav_output = nav[
        ["amfi_code", "date", "nav", "daily_return"]
    ].rename(columns={"date": "nav_date"})
    nav_output.to_sql("fact_nav", conn, if_exists="append", index=False)

    # 4. Load transactions fact
    transaction_columns = [
        "investor_id", "amfi_code", "transaction_date",
        "amount_inr", "transaction_type", "state", "city",
        "city_tier", "age_group", "gender",
        "annual_income_lakh", "payment_mode", "kyc_status"
    ]
    transactions[transaction_columns].to_sql(
        "fact_transactions", conn, if_exists="append", index=False
    )

    # 5. Load performance fact
    performance_columns = [
        "amfi_code", "return_1yr_pct", "return_3yr_pct",
        "return_5yr_pct", "benchmark_3yr_pct", "alpha", "beta",
        "sharpe_ratio", "sortino_ratio", "std_dev_ann_pct",
        "max_drawdown_pct", "aum_crore", "expense_ratio_pct",
        "morningstar_rating", "risk_grade",
        "negative_sharpe_flag", "expense_ratio_flag"
    ]
    performance[performance_columns].to_sql(
        "fact_performance", conn, if_exists="append", index=False
    )

    # 6. Load portfolio holdings
    portfolio_columns = [
        "amfi_code", "stock_symbol", "stock_name", "sector",
        "weight_pct", "market_value_cr", "current_price_inr",
        "portfolio_date"
    ]
    portfolio[portfolio_columns].to_sql(
        "fact_portfolio", conn, if_exists="append", index=False
    )

    # 7. Load fund house AUM
    aum.to_sql("fact_aum", conn, if_exists="append", index=False)

    # 8. Load SIP industry data
    sip.to_sql("fact_sip_industry", conn, if_exists="append", index=False)

    # 9. Load category inflows
    category.to_sql(
        "fact_category_inflows", conn, if_exists="append", index=False
    )

    # 10. Load industry folio counts
    folios.to_sql(
        "fact_industry_folios", conn, if_exists="append", index=False
    )

    # 11. Load benchmark indices
    benchmark_output = benchmark.rename(
        columns={
            "date": "benchmark_date",
            "close_value": "close_value"
        }
    )
    benchmark_output.to_sql(
        "fact_benchmark_indices", conn, if_exists="append", index=False
    )

    # Verify record counts
    print("\nDATABASE TABLE SUMMARY")
    print("-" * 60)

    tables = [
        "dim_fund",
        "dim_date",
        "fact_nav",
        "fact_transactions",
        "fact_performance",
        "fact_portfolio",
        "fact_aum",
        "fact_sip_industry",
        "fact_category_inflows",
        "fact_industry_folios",
        "fact_benchmark_indices"
    ]

    for table in tables:
        count = conn.execute(
            f"SELECT COUNT(*) FROM {table}"
        ).fetchone()[0]
        print(f"{table:<30} {count:>10,} rows")

    # Check foreign key integrity
    fk_errors = conn.execute("PRAGMA foreign_key_check").fetchall()

    print("\nFOREIGN KEY CHECK:")
    if fk_errors:
        print("Foreign key errors found:")
        for error in fk_errors:
            print(error)
    else:
        print("No foreign key errors.")

print("\nDatabase saved at:")
print(DB_FILE)
print("\nDATABASE LOADING COMPLETED")
