# Bluestock Mutual Fund Analytics Capstone
## Data Dictionary

**Project:** Mutual Fund Analytics Platform  
**Organization:** Bluestock Fintech Pvt. Ltd.  
**Domain:** Mutual Fund / FinTech  
**Database:** `bluestock_mf.db`  
**Total Source Datasets:** 10  
**Total Source Records:** 87,533  

---

## 1. Project Overview

This data dictionary documents the 10 datasets used in the Bluestock Mutual Fund Analytics Capstone.

The datasets cover mutual fund information, NAV history, Assets Under Management (AUM), SIP inflows, category-wise investments, investor transactions, portfolio holdings, fund performance, and benchmark indices.

The data is stored in CSV files and loaded into an SQLite database for analytical queries and dashboard development.

## 2. Dataset Summary

| No. | Dataset | Source File | Rows | Columns |
|---|---|---|---:|---:|
| 1 | Fund Master | 01_fund_master.csv | 40 | 15 |
| 2 | NAV History | 02_nav_history.csv | 46,000 | 3 |
| 3 | AUM by Fund House | 03_aum_by_fund_house.csv | 90 | 5 |
| 4 | Monthly SIP Inflows | 04_monthly_sip_inflows.csv | 48 | 6 |
| 5 | Category Inflows | 05_category_inflows.csv | 144 | 3 |
| 6 | Industry Folio Count | 06_industry_folio_count.csv | 21 | 6 |
| 7 | Scheme Performance | 07_scheme_performance.csv | 40 | 19 |
| 8 | Investor Transactions | 08_investor_transactions.csv | 32,778 | 13 |
| 9 | Portfolio Holdings | 09_portfolio_holdings.csv | 322 | 8 |
| 10 | Benchmark Indices | 10_benchmark_indices.csv | 8,050 | 3 |
| | **Total** | **10 CSV files** | **87,533** | **81** |

---

## 3. Detailed Dataset Descriptions

### 3.1 Fund Master

**Source:** `01_fund_master.csv`  
**Records:** 40  
**Columns:** 15  
**Database Table:** `dim_fund`

Contains master information about mutual fund schemes, including fund houses, categories, investment plans, expense ratios, and risk classifications.

| Column | Data Type | Description |
|---|---|---|
| amfi_code | TEXT | Unique AMFI scheme identifier; primary key |
| fund_house | TEXT | Name of the Asset Management Company |
| scheme_name | TEXT | Full mutual fund scheme name |
| category | TEXT | Broad mutual fund category |
| sub_category | TEXT | Specific scheme subcategory |
| plan | TEXT | Investment plan type |
| launch_date | DATE | Scheme launch date |
| benchmark | TEXT | Benchmark index associated with the scheme |
| expense_ratio_pct | FLOAT | Annual expense ratio percentage |
| exit_load_pct | FLOAT | Exit load percentage |
| min_sip_amount | FLOAT | Minimum SIP investment amount |
| min_lumpsum_amount | FLOAT | Minimum lump-sum investment amount |
| fund_manager | TEXT | Name of the fund manager |
| risk_category | TEXT | Scheme risk classification |
| sebi_category_code | TEXT | SEBI category identifier |

### 3.2 NAV History

**Source:** `02_nav_history.csv`  
**Records:** 46,000  
**Columns:** 3  
**Database Table:** `fact_nav`

Contains historical Net Asset Value (NAV) observations for mutual fund schemes.

| Column | Data Type | Description |
|---|---|---|
| amfi_code | TEXT | AMFI scheme identifier; foreign key |
| date | DATE | NAV observation date |
| nav | FLOAT | Net Asset Value per unit |

**Derived database column:**

| Column | Data Type | Description |
|---|---|---|
| daily_return | FLOAT | Percentage daily NAV change calculated during database loading |

### 3.3 AUM by Fund House

**Source:** `03_aum_by_fund_house.csv`  
**Records:** 90  
**Columns:** 5  
**Database Table:** `fact_aum`

Contains Assets Under Management information for different fund houses over time.

| Column | Data Type | Description |
|---|---|---|
| date | DATE | Reporting date |
| fund_house | TEXT | Name of the fund house |
| aum_lakh_crore | FLOAT | AUM measured in lakh crore |
| aum_crore | FLOAT | AUM measured in crore |
| num_schemes | INTEGER | Number of schemes managed by the fund house |

### 3.4 Monthly SIP Inflows

**Source:** `04_monthly_sip_inflows.csv`  
**Records:** 48  
**Columns:** 6  
**Database Table:** `fact_sip_industry`

Contains monthly industry-level Systematic Investment Plan (SIP) statistics.

| Column | Data Type | Description |
|---|---|---|
| month | DATE | Reporting month |
| sip_inflow_crore | FLOAT | Monthly SIP inflow in crore |
| active_sip_accounts_crore | FLOAT | Number of active SIP accounts in crore |
| new_sip_accounts_lakh | FLOAT | Number of new SIP accounts in lakh |
| sip_aum_lakh_crore | FLOAT | SIP-related AUM in lakh crore |
| yoy_growth_pct | FLOAT | Year-over-year SIP inflow growth percentage |

**Data quality note:** The first 12 months contain missing YoY growth values because a previous-year comparison is unavailable in the dataset.

### 3.5 Category Inflows

**Source:** `05_category_inflows.csv`  
**Records:** 144  
**Columns:** 3  
**Database Table:** `fact_category_inflows`

Contains monthly net investment inflows across mutual fund categories.

| Column | Data Type | Description |
|---|---|---|
| month | DATE | Reporting month |
| category | TEXT | Mutual fund category |
| net_inflow_crore | FLOAT | Net investment inflow in crore |

### 3.6 Industry Folio Count

**Source:** `06_industry_folio_count.csv`  
**Records:** 21  
**Columns:** 6  
**Database Table:** `fact_industry_folios`

Contains industry-level investor folio statistics across mutual fund categories.

| Column | Data Type | Description |
|---|---|---|
| month | DATE | Reporting month |
| total_folios_crore | FLOAT | Total mutual fund folios in crore |
| equity_folios_crore | FLOAT | Equity folios in crore |
| debt_folios_crore | FLOAT | Debt folios in crore |
| hybrid_folios_crore | FLOAT | Hybrid folios in crore |
| others_folios_crore | FLOAT | Other category folios in crore |

### 3.7 Scheme Performance

**Source:** `07_scheme_performance.csv`  
**Records:** 40  
**Columns:** 19  
**Database Table:** `fact_performance`

Contains historical performance and risk-related metrics for mutual fund schemes.

| Column | Data Type | Description |
|---|---|---|
| amfi_code | TEXT | AMFI scheme identifier; primary key |
| scheme_name | TEXT | Mutual fund scheme name |
| fund_house | TEXT | Fund house name |
| category | TEXT | Mutual fund category |
| plan | TEXT | Investment plan |
| return_1yr_pct | FLOAT | One-year return percentage |
| return_3yr_pct | FLOAT | Three-year return percentage |
| return_5yr_pct | FLOAT | Five-year return percentage |
| benchmark_3yr_pct | FLOAT | Three-year benchmark return percentage |
| alpha | FLOAT | Fund alpha |
| beta | FLOAT | Fund beta |
| sharpe_ratio | FLOAT | Risk-adjusted return indicator |
| sortino_ratio | FLOAT | Downside-risk-adjusted return indicator |
| std_dev_ann_pct | FLOAT | Annualized standard deviation percentage |
| max_drawdown_pct | FLOAT | Maximum drawdown percentage |
| aum_crore | FLOAT | Scheme AUM in crore |
| expense_ratio_pct | FLOAT | Scheme expense ratio percentage |
| morningstar_rating | INTEGER | Morningstar scheme rating |
| risk_grade | TEXT | Scheme risk grade |

**Additional database validation columns:**

| Column | Data Type | Description |
|---|---|---|
| negative_sharpe_flag | INTEGER | Indicates whether Sharpe ratio is negative |
| expense_ratio_flag | INTEGER | Indicates whether expense ratio is outside the 0.1%–2.5% validation range |

### 3.8 Investor Transactions

**Source:** `08_investor_transactions.csv`  
**Records:** 32,778  
**Columns:** 13  
**Database Table:** `fact_transactions`

Contains investor-level mutual fund transaction information, including investment amounts, transaction types, geographic information, and KYC status.

| Column | Data Type | Description |
|---|---|---|
| investor_id | TEXT | Unique investor identifier |
| transaction_date | DATE | Transaction date |
| amfi_code | TEXT | AMFI scheme identifier; foreign key |
| transaction_type | TEXT | SIP, Lumpsum, or Redemption |
| amount_inr | FLOAT | Transaction amount in Indian rupees |
| state | TEXT | Investor state |
| city | TEXT | Investor city |
| city_tier | TEXT | City classification |
| age_group | TEXT | Investor age group |
| gender | TEXT | Investor gender |
| annual_income_lakh | FLOAT | Annual investor income in lakh |
| payment_mode | TEXT | Transaction payment method |
| kyc_status | TEXT | Investor KYC verification status |

**Additional database column:**

| Column | Data Type | Description |
|---|---|---|
| tx_id | INTEGER | Auto-generated transaction primary key |

### 3.9 Portfolio Holdings

**Source:** `09_portfolio_holdings.csv`  
**Records:** 322  
**Columns:** 8  
**Database Table:** `fact_portfolio`

Contains stock-level portfolio holdings information for mutual fund schemes.

| Column | Data Type | Description |
|---|---|---|
| amfi_code | TEXT | AMFI scheme identifier; foreign key |
| stock_symbol | TEXT | Stock ticker symbol |
| stock_name | TEXT | Company or stock name |
| sector | TEXT | Industry sector |
| weight_pct | FLOAT | Portfolio allocation weight percentage |
| market_value_cr | FLOAT | Market value in crore |
| current_price_inr | FLOAT | Current stock price in INR |
| portfolio_date | DATE | Portfolio reporting date |

### 3.10 Benchmark Indices

**Source:** `10_benchmark_indices.csv`  
**Records:** 8,050  
**Columns:** 3  
**Database Table:** `fact_benchmark_indices`

Contains historical closing values for benchmark market indices used for fund performance comparisons.

| Column | Data Type | Description |
|---|---|---|
| date | DATE | Benchmark observation date |
| index_name | TEXT | Benchmark index name |
| close_value | FLOAT | Closing index value |

---

## 4. Database Schema and Relationships

The project uses SQLite to store structured mutual fund data.

The database contains 11 tables:

| Table | Type | Primary Key |
|---|---|---|
| dim_fund | Dimension | amfi_code |
| dim_date | Dimension | date_id |
| fact_nav | Fact | amfi_code + nav_date |
| fact_transactions | Fact | tx_id |
| fact_performance | Fact | amfi_code |
| fact_portfolio | Fact | amfi_code + stock_symbol + portfolio_date |
| fact_aum | Fact | fund_house + date |
| fact_sip_industry | Fact | month |
| fact_category_inflows | Fact | month + category |
| fact_industry_folios | Fact | month |
| fact_benchmark_indices | Fact | benchmark_date + index_name |

### Key relationships

- `dim_fund.amfi_code` connects to NAV, transactions, performance, and portfolio tables.
- `dim_date.date` connects to NAV, transactions, portfolio, AUM, and benchmark tables.
- The fact tables store analytical measurements and transaction information.

---

## 5. Data Cleaning and Validation Summary

The following cleaning and validation operations were performed:

| Dataset | Cleaning / Validation |
|---|---|
| NAV History | Date parsing, sorting, duplicate checks, missing NAV handling, positive NAV validation |
| Investor Transactions | Transaction type standardization, amount validation, KYC status checks, date validation |
| Scheme Performance | Numeric return validation, negative Sharpe flagging, expense ratio range validation |

### Cleaning results

| Dataset | Original Rows | Final Rows |
|---|---:|---:|
| NAV History | 46,000 | 46,000 |
| Investor Transactions | 32,778 | 32,778 |
| Scheme Performance | 40 | 40 |

No duplicate records or invalid values were detected by the checks performed on these three cleaned datasets.

---

## 6. Data Sources

The capstone project uses the following source categories:

- AMFI India public mutual fund information.
- Provided mutual fund scheme and investor datasets.
- Historical NAV and benchmark index datasets.
- Public mutual fund industry statistics.

The supplied CSV files are stored in `data/raw/`, while cleaned versions of the three processed datasets are stored in `data/processed/`.

---

## 7. Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data processing and automation |
| Pandas | Data cleaning and manipulation |
| NumPy | Numerical operations |
| SQLite | Relational database |
| SQL | Analytical queries |
| SQLAlchemy | Database integration |
| PyCharm | Development environment |
| Git and GitHub | Version control and project submission |

---

## 8. Conclusion

This data dictionary provides documentation for the 10 source datasets and their corresponding database tables.

It supports data understanding, database management, SQL analysis, exploratory data analysis, performance analytics, and dashboard development.

**Project:** Bluestock Mutual Fund Analytics Capstone  
**Deliverable:** `data_dictionary.md`  
**Database:** `bluestock_mf.db`
