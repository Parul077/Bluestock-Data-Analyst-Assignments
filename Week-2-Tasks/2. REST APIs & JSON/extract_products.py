
import requests
import pandas as pd

# 1. API endpoint
url = "https://dummyjson.com/products"

# 2. Call the API and request all 194 products
params = {
    "limit": 194,
    "skip": 0
}

response = requests.get(url, params=params, timeout=30)

# 3. Check whether the API request was successful
response.raise_for_status()

# 4. Convert JSON response into Python dictionary
data = response.json()

# 5. Extract product records
products = data["products"]

print("API Status:", response.status_code)
print("Total available products:", data["total"])
print("Products extracted:", len(products))

# 6. Convert JSON records into a DataFrame
df = pd.json_normalize(products)

# 7. Flatten the tags array
df["tags"] = df["tags"].apply(
    lambda x: "; ".join(x) if isinstance(x, list) else ""
)

# 8. Select useful columns for analysis
columns = [
    "id",
    "title",
    "category",
    "brand",
    "price",
    "discountPercentage",
    "rating",
    "stock",
    "availabilityStatus",
    "minimumOrderQuantity",
    "weight",
    "dimensions.width",
    "dimensions.height",
    "dimensions.depth",
    "tags"
]

df = df[columns]

# 9. Rename columns for a clean dataset
df.columns = [
    "id",
    "title",
    "category",
    "brand",
    "price",
    "discount_percentage",
    "rating",
    "stock",
    "availability_status",
    "minimum_order_quantity",
    "weight",
    "width",
    "height",
    "depth",
    "tags"
]

# 10. Export DataFrame to CSV
output_file = "dummyjson_products.csv"

df.to_csv(output_file, index=False, encoding="utf-8")

# 11. Validate exported data
print("\nCSV EXPORT SUCCESSFUL")
print("File:", output_file)
print("Rows:", df.shape[0])
print("Columns:", df.shape[1])
print("Duplicate IDs:", df["id"].duplicated().sum())
print("Missing values:\n", df.isnull().sum())

print("\nFirst five records:")
print(df.head())
