import pandas as pd
from pathlib import Path

# Project directory
BASE_DIR = Path(__file__).resolve().parent.parent

# Raw dataset directory
DATA_DIR = BASE_DIR / "data" / "raw"

# All 10 datasets
datasets = [
    "01_fund_master.csv",
    "02_nav_history.csv",
    "03_aum_by_fund_house.csv",
    "04_monthly_sip_inflows.csv",
    "05_category_inflows.csv",
    "06_industry_folio_count.csv",
    "07_scheme_performance.csv",
    "08_investor_transactions.csv",
    "09_portfolio_holdings.csv",
    "10_benchmark_indices.csv"
]

# Store loaded datasets
dataframes = {}

print("=" * 70)
print("BLUESTOCK MUTUAL FUND ANALYTICS - DATA INGESTION")
print("=" * 70)

for filename in datasets:

    file_path = DATA_DIR / filename

    print(f"\n\nDataset: {filename}")
    print("-" * 70)

    try:
        df = pd.read_csv(file_path)

        dataframes[filename] = df

        # Dataset dimensions
        print("Shape:", df.shape)

        # Column names
        print("\nColumns:")
        print(df.columns.tolist())

        # Data types
        print("\nData Types:")
        print(df.dtypes)

        # First five records
        print("\nFirst 5 Rows:")
        print(df.head())

        # Missing values
        print("\nMissing Values:")
        print(df.isnull().sum())

        # Duplicate records
        print("\nDuplicate Rows:", df.duplicated().sum())

    except FileNotFoundError:
        print(f"ERROR: {filename} was not found!")

    except Exception as e:
        print(f"ERROR while loading {filename}: {e}")

print("\n" + "=" * 70)
print("DATA INGESTION COMPLETED")
print("Successfully loaded:", len(dataframes), "out of", len(datasets))
print("=" * 70)
