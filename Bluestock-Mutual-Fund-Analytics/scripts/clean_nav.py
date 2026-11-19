
import pandas as pd
from pathlib import Path

# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent
RAW_DIR = BASE_DIR / "data" / "raw"
PROCESSED_DIR = BASE_DIR / "data" / "processed"

PROCESSED_DIR.mkdir(parents=True, exist_ok=True)

# Load original NAV dataset
input_file = RAW_DIR / "02_nav_history.csv"
df = pd.read_csv(input_file)

print("NAV DATA CLEANING STARTED")
print("-" * 50)

print("Original shape:", df.shape)

# 1. Convert date column to datetime
df["date"] = pd.to_datetime(df["date"], errors="coerce")

# 2. Convert NAV to numeric
df["nav"] = pd.to_numeric(df["nav"], errors="coerce")

# 3. Remove rows with invalid dates or missing identifiers
df = df.dropna(subset=["amfi_code", "date"])

# 4. Sort by fund code and date
df = df.sort_values(
    by=["amfi_code", "date"]
).reset_index(drop=True)

# 5. Remove duplicate fund-date records
duplicates = df.duplicated(
    subset=["amfi_code", "date"]
).sum()

df = df.drop_duplicates(
    subset=["amfi_code", "date"],
    keep="last"
)

# 6. Handle missing NAV values
missing_nav = df["nav"].isna().sum()

if missing_nav > 0:
    df["nav"] = df.groupby("amfi_code")["nav"].ffill()

# 7. Remove records where NAV is still missing
df = df.dropna(subset=["nav"])

# 8. Validate NAV values are positive
invalid_nav = (df["nav"] <= 0).sum()

df = df[df["nav"] > 0].copy()

# 9. Save cleaned dataset
output_file = PROCESSED_DIR / "clean_nav.csv"
df.to_csv(output_file, index=False)

# 10. Display cleaning summary
print("\nCLEANING SUMMARY")
print("-" * 50)

print("Original rows:", 46000)
print("Duplicate records removed:", duplicates)
print("Missing NAV values initially:", missing_nav)
print("Invalid NAV records removed:", invalid_nav)
print("Final shape:", df.shape)
print("Remaining missing values:")
print(df.isnull().sum())

print("\nCleaned file saved at:", output_file)
print("\nNAV DATA CLEANING COMPLETED")
