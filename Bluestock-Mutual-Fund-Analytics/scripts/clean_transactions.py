
import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

RAW_DIR = BASE_DIR / "data" / "raw"
PROCESSED_DIR = BASE_DIR / "data" / "processed"

PROCESSED_DIR.mkdir(parents=True, exist_ok=True)

# Load dataset
df = pd.read_csv(RAW_DIR / "08_investor_transactions.csv")

print("TRANSACTION DATA CLEANING STARTED")
print("-" * 50)

print("Original shape:", df.shape)

# 1. Standardise transaction types
df["transaction_type"] = (
    df["transaction_type"]
    .astype("string")
    .str.strip()
    .str.title()
)

# 2. Convert transaction date
df["transaction_date"] = pd.to_datetime(
    df["transaction_date"],
    errors="coerce"
)

# 3. Convert amount to numeric
df["amount_inr"] = pd.to_numeric(
    df["amount_inr"],
    errors="coerce"
)

# 4. Standardise KYC status
df["kyc_status"] = (
    df["kyc_status"]
    .astype("string")
    .str.strip()
    .str.title()
)

# 5. Validate transaction types
valid_types = ["Sip", "Lumpsum", "Redemption"]

invalid_types = ~df["transaction_type"].isin(valid_types)
invalid_type_count = invalid_types.sum()

# 6. Validate KYC statuses
valid_kyc = ["Verified", "Pending"]

invalid_kyc = ~df["kyc_status"].isin(valid_kyc)
invalid_kyc_count = invalid_kyc.sum()

# 7. Validate transaction amounts
invalid_amount = (
    df["amount_inr"].isna() |
    (df["amount_inr"] <= 0)
)

invalid_amount_count = invalid_amount.sum()

# 8. Check invalid dates
invalid_dates = df["transaction_date"].isna()
invalid_date_count = invalid_dates.sum()

# 9. Remove exact duplicate rows
duplicate_count = df.duplicated().sum()
df = df.drop_duplicates()

# 10. Remove invalid records
df = df[
    df["transaction_type"].isin(valid_types) &
    df["kyc_status"].isin(valid_kyc) &
    df["amount_inr"].notna() &
    (df["amount_inr"] > 0) &
    df["transaction_date"].notna()
].copy()

# 11. Sort records
df = df.sort_values(
    by=["investor_id", "transaction_date"]
).reset_index(drop=True)

# 12. Save cleaned dataset
output_file = PROCESSED_DIR / "clean_transactions.csv"

df.to_csv(output_file, index=False)

# Summary
print("\nCLEANING SUMMARY")
print("-" * 50)

print("Duplicate rows found:", duplicate_count)
print("Invalid transaction types:", invalid_type_count)
print("Invalid KYC statuses:", invalid_kyc_count)
print("Invalid amounts:", invalid_amount_count)
print("Invalid dates:", invalid_date_count)

print("Final shape:", df.shape)

print("\nRemaining missing values:")
print(df.isnull().sum())

print("\nCleaned file saved at:", output_file)

print("\nTRANSACTION DATA CLEANING COMPLETED")
