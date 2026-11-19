# Bluestock Mutual Fund Analytics
## Day 3 – Exploratory Data Analysis (EDA) Report

**Project:** Bluestock Mutual Fund Analytics Capstone  
**Analysis Phase:** Day 3 – Exploratory Data Analysis  
**Tools:** Python, Pandas, NumPy, Matplotlib, Seaborn, Plotly  
**Database:** SQLite  
**Author:** Parul Singh

---

## 1. Project Overview

The Bluestock Mutual Fund Analytics project focuses on analyzing datasets related to the Indian mutual fund industry.

The project uses information about mutual fund schemes, historical Net Asset Values (NAV), Assets Under Management (AUM), Systematic Investment Plan (SIP) inflows, investor transactions, portfolio holdings, and benchmark indices.

The objective of this EDA phase is to explore the available datasets, identify trends and patterns, understand investor behavior, examine mutual fund performance, and generate meaningful business insights through data visualization.

## 2. EDA Objectives

The key objectives of this analysis are:

- Understand the distribution of mutual fund schemes across categories.
- Analyze historical NAV trends across mutual fund schemes.
- Examine AUM distribution and changes across fund houses.
- Identify monthly SIP inflow patterns.
- Analyze category-wise mutual fund inflows.
- Understand investor demographics and transaction behavior.
- Explore geographical patterns in investor transactions.
- Analyze the growth of mutual fund folios.
- Examine relationships between selected fund returns.
- Understand portfolio sector allocation.
- Explore the relationship between fund risk and returns.
- Generate data-driven findings to support further analysis.

## 3. Dataset Overview

The analysis uses 10 source datasets containing a total of 87,533 records.

| No. | Dataset | Records | Purpose |
|---|---|---:|---|
| 1 | Fund Master | 40 | Scheme and fund information |
| 2 | NAV History | 46,000 | Historical NAV observations |
| 3 | AUM by Fund House | 90 | Fund house AUM information |
| 4 | Monthly SIP Inflows | 48 | Monthly SIP investment trends |
| 5 | Category Inflows | 144 | Category-wise net inflows |
| 6 | Industry Folio Count | 21 | Mutual fund folio growth |
| 7 | Scheme Performance | 40 | Fund returns and risk metrics |
| 8 | Investor Transactions | 32,778 | Investor transaction information |
| 9 | Portfolio Holdings | 322 | Fund portfolio and sector allocation |
| 10 | Benchmark Indices | 8,050 | Historical benchmark index values |
| | **Total** | **87,533** | |

### 3.1 Data Preparation

The following preparation steps were performed before analysis:

- Loaded all 10 datasets using Pandas.
- Converted relevant date columns into datetime format.
- Sorted time-series datasets chronologically.
- Used the cleaned NAV, transaction, and scheme performance datasets.
- Loaded the remaining datasets from their raw CSV files.
- Created a dedicated directory for exporting EDA visualizations.

## 4. Analysis Methodology

The analysis was performed using Python-based exploratory data analysis techniques.

### 4.1 Descriptive Analysis

Descriptive analysis was used to understand the structure and distribution of the datasets, including:

- Number of mutual fund schemes by category.
- Investor distribution by age group.
- Transaction type distribution.
- Geographic distribution of transactions.

### 4.2 Time-Series Analysis

Time-series visualizations were used to examine changes over time in:

- Daily NAV values.
- AUM by fund house.
- Monthly SIP inflows.
- Industry folio counts.
- Category-wise net inflows.

### 4.3 Comparative Analysis

Comparative analysis was performed to understand:

- NAV movements across selected schemes.
- SIP investment amounts across investor age groups.
- Sector allocation across fund portfolios.
- Risk and return relationships between mutual funds.

### 4.4 Correlation Analysis

A correlation matrix was created using daily percentage returns for 10 selected mutual fund schemes.

Pearson correlation was used to examine the strength and direction of linear relationships between selected fund returns.

## 5. Exploratory Data Visualizations

A total of 15 visualizations were generated and exported as PNG files.

All visualizations are stored in:

`reports/eda_charts/`

| No. | Visualization | Analysis Purpose |
|---|---|---|
| 1 | Fund Category Distribution | Understand the number of schemes across categories |
| 2 | NAV Trends Across All Schemes | Examine historical NAV movements |
| 3 | Selected Funds NAV Comparison | Compare NAV trends of five selected schemes |
| 4 | AUM Growth by Fund House | Compare year-wise AUM observations across fund houses |
| 5 | Monthly SIP Inflow Trend | Identify changes and peaks in monthly SIP inflows |
| 6 | Category Inflow Heatmap | Compare monthly net inflows across categories |
| 7 | Investor Age Distribution | Understand investor representation by age group |
| 8 | SIP Amount by Age Group | Compare SIP transaction amounts across age groups |
| 9 | State-wise SIP Investment | Identify states with higher recorded SIP transaction amounts |
| 10 | City Tier Distribution | Compare transactions across city tiers |
| 11 | Folio Count Growth | Examine changes in total mutual fund folios |
| 12 | NAV Return Correlation | Explore relationships between selected fund returns |
| 13 | Portfolio Sector Allocation | Examine average sector allocation across funds |
| 14 | Transaction Type Distribution | Understand the distribution of transaction types |
| 15 | Fund Risk vs Return Comparison | Explore the relationship between risk and three-year returns |

## 6. Key EDA Findings

The following findings were generated programmatically from the available datasets.

### Finding 1: Fund Category Distribution

Equity is the most represented category in the fund master dataset, with 34 schemes.

**Observation:** Equity schemes account for a substantial share of the schemes included in the dataset.

### Finding 2: AUM by Fund House

SBI Mutual Fund has the highest latest recorded AUM in the dataset, at approximately ₹12,50,000 crore.

**Observation:** The latest available AUM observations show differences in fund house asset sizes.

### Finding 3: Monthly SIP Inflows

December 2025 recorded the highest monthly SIP inflow, at approximately ₹31,002 crore.

**Observation:** This represents the highest SIP inflow observation in the supplied dataset.

### Finding 4: Investor Age Distribution

The 26–35 age group is the most frequently represented investor age group in the transaction dataset.

**Observation:** Investors in this age group account for the largest representation by transaction records.

### Finding 5: State-wise SIP Transactions

Madhya Pradesh recorded the highest total SIP transaction amount in the supplied transaction dataset.

**Observation:** The state-wise transaction analysis identifies differences in recorded SIP activity across locations.

### Finding 6: Mutual Fund Folio Growth

Total mutual fund folios increased from approximately 13.26 crore to 26.12 crore over the available observation period.

**Observation:** The dataset shows an increase in the recorded mutual fund folio base.

### Finding 7: Portfolio Sector Allocation

Banking has the highest average sector allocation across the analyzed fund portfolios, at approximately 21.74%.

**Observation:** Banking represents a significant sector allocation in the portfolio holdings included in the dataset.

### Finding 8: Three-Year Fund Returns

SBI Small Cap Fund recorded the highest three-year return in the performance dataset, at approximately 23.39%.

**Observation:** The performance dataset shows differences in historical three-year returns across schemes.

### Finding 9: Sharpe Ratio

ICICI Pru Liquid Fund recorded the highest Sharpe ratio in the performance dataset, at approximately 7.68.

**Observation:** The fund has the highest reported Sharpe ratio among the analyzed schemes.

### Finding 10: NAV Return Correlation

The strongest positive pairwise correlation among the 10 selected schemes was approximately 0.046.

**Observation:** This indicates very weak positive linear co-movement between the corresponding daily returns over the analyzed period.

## 7. Business Insights

The EDA findings provide several useful observations for further analysis.

### 7.1 Investor Participation

The 26–35 age group is the most represented in the transaction dataset. This provides an opportunity to explore age-based investment patterns and differences in transaction behavior.

### 7.2 SIP Investment Trends

The highest recorded SIP inflow occurred in December 2025. Monthly SIP trends can help identify changes in investment activity and periods of relatively high or low inflows.

### 7.3 Geographic Investment Patterns

Madhya Pradesh recorded the highest total SIP transaction amount in the supplied data. Further analysis of state-wise transaction counts, average ticket sizes, and city tiers could help explain geographical differences.

### 7.4 Portfolio Sector Exposure

Banking has the highest average sector allocation across the analyzed fund portfolios. This highlights the importance of examining sector concentration when evaluating portfolio diversification.

### 7.5 Fund Risk and Return

The risk-versus-return visualization provides a way to compare schemes based on their historical three-year returns and annualized standard deviation.

The comparison can support further performance analysis, but it should not be interpreted as a recommendation to invest in a particular fund.

### 7.6 Fund Return Correlation

The highest positive correlation among the selected funds is only 0.046. This suggests very weak linear co-movement in the selected daily return series.

Correlation analysis can help explore diversification, but it does not independently establish whether a portfolio is adequately diversified.

## 8. Limitations of the Analysis

The following limitations should be considered when interpreting the findings:

1. **Dataset Coverage:** The analysis is based on the 10 datasets supplied for the capstone and may not represent the entire Indian mutual fund industry.

2. **Data Period:** Findings depend on the dates covered by each individual dataset. Not all datasets necessarily cover identical periods.

3. **Sample Representation:** Investor transaction records may not represent the complete population of mutual fund investors.

4. **Historical Performance:** Historical returns and risk measures do not guarantee future performance.

5. **Correlation Limitations:** Correlation measures linear relationships and does not establish causation.

6. **AUM Comparison:** The fund house comparison uses the latest available observation for each year rather than summing repeated AUM snapshots.

7. **Portfolio Allocation:** Average sector allocation across funds may differ from the allocation of the combined industry portfolio.

8. **Missing Values:** Missing observations and unavailable historical comparisons should not automatically be interpreted as zero.

9. **Descriptive Analysis:** EDA identifies patterns and relationships but does not establish the causes behind observed changes.

## 9. Conclusion

The Day 3 Exploratory Data Analysis phase provided an overview of the mutual fund datasets through descriptive, comparative, time-series, and correlation analysis.

A total of 15 visualizations were created to explore fund categories, NAV trends, AUM, SIP inflows, investor demographics, geographical distribution, folio growth, portfolio allocation, and fund performance.

The analysis generated 10 key findings, highlighting patterns in scheme distribution, fund house AUM, SIP inflows, investor representation, geographical activity, sector allocation, historical returns, and fund risk metrics.

These findings provide a foundation for the next phase of the project, which will focus on mutual fund performance metrics and scorecard development.

## 10. Deliverables

The following Day 3 deliverables have been generated:

| Deliverable | File / Location | Status |
|---|---|---|
| EDA Notebook | `notebooks/EDA_Analysis.ipynb` | Completed |
| EDA Visualizations | `reports/eda_charts/` | 15 charts generated |
| EDA Findings | `reports/EDA_Findings.txt` | Generated |
| EDA Report | `reports/EDA_Report.md` | Documented |

---

**Day 3 Status: Exploratory Data Analysis completed.**

*Bluestock Mutual Fund Analytics Capstone – Day 3*
