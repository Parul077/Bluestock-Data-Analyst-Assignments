
import pandas as pd
from pathlib import Path

print("SCHEME PERFORMANCE DATA CLEANING STARTED")

BASE_DIR = Path(__file__).resolve().parent.parent

input_file = BASE_DIR / "data" / "raw" / "07_scheme_performance.csv"
output_file = BASE_DIR / "data" / "processed" / "clean_performance.csv"

df = pd.read_csv(input_file)

print("-" * 50)
print("Original shape:", df.shape)

# Convert return and performance columns to numeric
numeric_columns = [
    "return_1yr_pct",
    "return_3yr_pct",
    "return_5yr_pct",
    "benchmark_3yr_pct",
    "alpha",
    "beta",
    "sharpe_ratio",
    "sortino_ratio",
    "std_dev_ann_pct",
    "max_drawdown_pct",
    "aum_crore",
    "expense_ratio_pct"
]

for col in numeric_columns:
    df[col] = pd.to_numeric(df[col], errors="coerce")

# Remove duplicate records
duplicates = df.duplicated().sum()
df = df.drop_duplicates()

# Remove rows without essential identifiers
df = df.dropna(subset=["amfi_code", "scheme_name"])

# Flag negative Sharpe ratios
negative_sharpe = (df["sharpe_ratio"] < 0).sum()
df["negative_sharpe_flag"] = df["sharpe_ratio"] < 0

# Check expense ratio range (0.1%–2.5%)
invalid_expense = (
    (df["expense_ratio_pct"] < 0.1) |
    (df["expense_ratio_pct"] > 2.5)
).sum()

df["expense_ratio_flag"] = (
    (df["expense_ratio_pct"] < 0.1) |
    (df["expense_ratio_pct"] > 2.5)
)

# Check missing numeric values
missing_numeric = df[numeric_columns].isna().sum().sum()

# Save cleaned dataset
df.to_csv(output_file, index=False)

print("\nCLEANING SUMMARY")
print("-" * 50)
print("Duplicate rows removed:", duplicates)
print("Negative Sharpe ratios flagged:", negative_sharpe)
print("Expense ratios outside 0.1%-2.5%:", invalid_expense)
print("Missing numeric values:", missing_numeric)
print("Final shape:", df.shape)

print("\nRemaining missing values:")
print(df.isnull().sum())

print("\nCleaned file saved at:", output_file)
print("\nSCHEME PERFORMANCE DATA CLEANING COMPLETED")
