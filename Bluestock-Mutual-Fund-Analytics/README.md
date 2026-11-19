# 📊 Bluestock Mutual Fund Analytics Capstone

## Project Overview

The **Bluestock Mutual Fund Analytics Capstone** is an end-to-end data analytics project focused on analyzing the Indian mutual fund industry.

The project uses mutual fund scheme information, historical NAV data, investor transactions, AUM, SIP inflows, portfolio holdings, and benchmark indices to explore industry trends, investor behavior, fund performance, and investment patterns.

The objective is to transform raw financial datasets into meaningful insights using Python, SQL, data visualization, and business intelligence tools.

## 🎯 Project Objectives

- Collect and organize mutual fund industry datasets.
- Clean and preprocess financial and investor transaction data.
- Design a relational SQLite database for structured analysis.
- Perform SQL-based analysis to identify important trends.
- Conduct exploratory data analysis (EDA).
- Evaluate mutual fund performance and risk.
- Develop interactive dashboards for business insights.
- Apply advanced analytics to understand investor behavior and fund characteristics.

## 🛠️ Tech Stack

| Category | Technologies |
|---|---|
| Programming | Python |
| Data Analysis | Pandas, NumPy |
| Visualization | Matplotlib, Seaborn, Plotly |
| Database | SQLite |
| Query Language | SQL |
| Development Environment | PyCharm, Jupyter Notebook |
| API | MFAPI |
| Business Intelligence | Power BI / Tableau |
| Version Control | Git, GitHub |

## 📁 Project Structure

```text
Bluestock-Mutual-Fund-Analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── dashboard/
│
├── notebooks/
│
├── reports/
│   └── sql_query_results/
│
├── scripts/
│   ├── data_ingestion.py
│   ├── clean_nav.py
│   ├── clean_transactions.py
│   ├── clean_performance.py
│   ├── load_database.py
│   └── run_sql_queries.py
│
├── sql/
│   ├── schema.sql
│   └── queries.sql
│
├── bluestock_mf.db
├── requirements.txt
└── README.md
```

## 📂 Datasets

The project contains 10 source datasets covering different aspects of the mutual fund industry.

| No. | Dataset | Records |
|---|---|---:|
| 1 | Fund Master | 40 |
| 2 | NAV History | 46,000 |
| 3 | AUM by Fund House | 90 |
| 4 | Monthly SIP Inflows | 48 |
| 5 | Category Inflows | 144 |
| 6 | Industry Folio Count | 21 |
| 7 | Scheme Performance | 40 |
| 8 | Investor Transactions | 32,778 |
| 9 | Portfolio Holdings | 322 |
| 10 | Benchmark Indices | 8,050 |
| | **Total** | **87,533** |

The datasets are stored in `data/raw/`, while cleaned datasets are stored in `data/processed/`.

## 🧹 Data Cleaning

The following datasets have undergone dedicated cleaning and validation:

- **NAV History:** Date standardization, duplicate checks, missing-value handling, and NAV validation.
- **Investor Transactions:** Date and amount validation, transaction type standardization, KYC validation, and duplicate checks.
- **Scheme Performance:** Numeric conversion, missing-value checks, and expense ratio and Sharpe ratio validation flags.

The processed datasets are:

- `clean_nav.csv`
- `clean_transactions.csv`
- `clean_performance.csv`

The remaining source datasets are currently loaded directly from the raw data files.

## 🗄️ Database Design

A SQLite database named `bluestock_mf.db` has been created to support structured analysis.

The database contains 11 tables:

**Dimension tables**
- `dim_fund`
- `dim_date`

**Fact tables**
- `fact_nav`
- `fact_transactions`
- `fact_performance`
- `fact_portfolio`
- `fact_aum`
- `fact_sip_industry`
- `fact_category_inflows`
- `fact_industry_folios`
- `fact_benchmark_indices`

The database uses primary keys, foreign keys, and indexes to organize and connect the datasets.

## 📈 SQL Analysis

Ten SQL queries have been developed and executed successfully.

The analysis includes:

1. Top five mutual funds by AUM.
2. Average monthly NAV by scheme.
3. Year-over-year SIP inflow growth.
4. Investor transactions by state.
5. Funds with expense ratios below 1%.
6. Category-wise net inflows.
7. Investor transactions by age group.
8. Monthly benchmark index trends.
9. Portfolio sector allocation.
10. Fund performance and risk comparison.

Query outputs are saved in:

`reports/sql_query_results/`

## ⚙️ Installation and Setup

### 1. Clone the repository

```bash
git clone https://github.com/Parul077/Bluestock-Data-Analyst-Assignments.git
```

### 2. Navigate to the project folder

```bash
cd Bluestock-Data-Analyst-Assignments/Bluestock-Mutual-Fund-Analytics
```

### 3. Create a virtual environment

```bash
python -m venv venv
```

Activate it on Windows:

```bash
venv\Scripts\activate
```

### 4. Install dependencies

```bash
pip install -r requirements.txt
```

### 5. Run the data ingestion script

```bash
python scripts/data_ingestion.py
```

### 6. Clean the datasets

```bash
python scripts/clean_nav.py
python scripts/clean_transactions.py
python scripts/clean_performance.py
```

### 7. Load the SQLite database

```bash
python scripts/load_database.py
```

### 8. Execute SQL queries

```bash
python scripts/run_sql_queries.py
```

## 📌 Project Progress

| Day | Tasks | Status |
|---|---|---|
| Day 1 | Project setup, dataset ingestion and inspection | Completed |
| Day 2 | Data cleaning, SQLite database, schema, SQL queries and data dictionary | Completed |
| Day 3 | Exploratory Data Analysis (EDA) | Upcoming |
| Day 4 | Mutual fund performance metrics and scorecard | Upcoming |
| Day 5 | Interactive dashboard development | Upcoming |
| Day 6 | Advanced analytics | Upcoming |
| Day 7 | Final report, presentation and GitHub documentation | Upcoming |

## 📊 Expected Final Deliverables

- Cleaned and structured datasets.
- SQLite database and SQL scripts.
- Exploratory Data Analysis report and visualizations.
- Mutual fund performance scorecard.
- Interactive Power BI / Tableau dashboard.
- Advanced analytics outputs.
- Final project report and presentation.

## 👩‍💻 Author

**Parul Singh**

Data Analytics | Python | SQL | Data Visualization | Power BI

GitHub: [Parul077](https://github.com/Parul077)

---

*This project is being developed as part of the Bluestock Data Analyst Internship Capstone.*
