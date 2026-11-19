
-- ============================================================
-- BLUESTOCK MUTUAL FUND ANALYTICS CAPSTONE
-- DAY 2: SQL ANALYTICAL QUERIES
-- Database: bluestock_mf.db
-- ============================================================


-- QUERY 1: Top 5 mutual funds by AUM
-- Purpose: Identify the five funds with the highest Assets Under Management.

SELECT
    f.amfi_code,
    f.scheme_name,
    f.fund_house,
    f.category,
    p.aum_crore
FROM dim_fund f
JOIN fact_performance p
    ON f.amfi_code = p.amfi_code
ORDER BY p.aum_crore DESC
LIMIT 5;


-- QUERY 2: Average NAV per month
-- Purpose: Calculate the average monthly NAV for each mutual fund.

SELECT
    amfi_code,
    strftime('%Y-%m', nav_date) AS year_month,
    ROUND(AVG(nav), 4) AS average_monthly_nav
FROM fact_nav
GROUP BY
    amfi_code,
    strftime('%Y-%m', nav_date)
ORDER BY
    amfi_code,
    year_month;


-- QUERY 3: SIP inflow year-over-year growth
-- Purpose: Analyse monthly SIP inflows and their reported YoY growth.


-- QUERY 3: SIP inflow year-over-year growth
-- Calculate YoY growth using the same month in the previous year.

SELECT
    current.month,
    ROUND(current.sip_inflow_crore, 2) AS current_sip_inflow_crore,
    ROUND(previous.sip_inflow_crore, 2) AS previous_year_inflow_crore,

    ROUND(
        (
            (current.sip_inflow_crore - previous.sip_inflow_crore)
            * 100.0
        ) / NULLIF(previous.sip_inflow_crore, 0),
        2
    ) AS calculated_yoy_growth_pct,

    ROUND(current.yoy_growth_pct, 2) AS source_reported_yoy_growth_pct

FROM fact_sip_industry AS current

LEFT JOIN fact_sip_industry AS previous
    ON previous.month = strftime(
        '%Y-%m',
        current.month || '-01',
        '-12 months'
    )

ORDER BY current.month;



-- QUERY 4: Transactions by state
-- Purpose: Understand investor transaction activity across Indian states.

SELECT
    state,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT investor_id) AS unique_investors,
    ROUND(SUM(amount_inr), 2) AS total_transaction_amount
FROM fact_transactions
GROUP BY state
ORDER BY total_transaction_amount DESC;


-- QUERY 5: Mutual funds with expense ratio below 1%
-- Purpose: Identify funds with relatively lower expense ratios.

SELECT
    f.amfi_code,
    f.scheme_name,
    f.fund_house,
    f.category,
    p.expense_ratio_pct
FROM dim_fund f
JOIN fact_performance p
    ON f.amfi_code = p.amfi_code
WHERE p.expense_ratio_pct < 1
ORDER BY p.expense_ratio_pct ASC;


-- QUERY 6: Category-wise net inflows
-- Purpose: Identify mutual fund categories attracting the highest inflows.

SELECT
    category,
    ROUND(SUM(net_inflow_crore), 2) AS total_net_inflow_crore
FROM fact_category_inflows
GROUP BY category
ORDER BY total_net_inflow_crore DESC;


-- QUERY 7: Investor transactions by age group
-- Purpose: Analyse investor participation and transaction amounts by age.

SELECT
    age_group,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT investor_id) AS unique_investors,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(SUM(amount_inr), 2) AS total_transaction_amount
FROM fact_transactions
GROUP BY age_group
ORDER BY total_transaction_amount DESC;


-- QUERY 8: Monthly benchmark index trends
-- Purpose: Analyse monthly closing values of benchmark indices.

SELECT
    index_name,
    strftime('%Y-%m', benchmark_date) AS year_month,
    ROUND(AVG(close_value), 2) AS average_closing_value,
    ROUND(MIN(close_value), 2) AS minimum_closing_value,
    ROUND(MAX(close_value), 2) AS maximum_closing_value
FROM fact_benchmark_indices
GROUP BY
    index_name,
    strftime('%Y-%m', benchmark_date)
ORDER BY
    index_name,
    year_month;


-- QUERY 9: Portfolio sector allocation
-- Purpose: Analyse sector-wise portfolio allocation for each fund.

SELECT
    f.scheme_name,
    p.sector,
    ROUND(SUM(p.weight_pct), 2) AS total_sector_weight_pct,
    ROUND(SUM(p.market_value_cr), 2) AS total_market_value_cr
FROM fact_portfolio p
JOIN dim_fund f
    ON p.amfi_code = f.amfi_code
GROUP BY
    f.scheme_name,
    p.sector
ORDER BY
    f.scheme_name,
    total_sector_weight_pct DESC;


-- QUERY 10: Fund performance and risk comparison
-- Purpose: Compare returns, risk-adjusted performance and risk indicators.

SELECT
    f.scheme_name,
    f.fund_house,
    f.category,
    p.return_1yr_pct,
    p.return_3yr_pct,
    p.return_5yr_pct,
    p.sharpe_ratio,
    p.sortino_ratio,
    p.alpha,
    p.beta,
    p.std_dev_ann_pct,
    p.max_drawdown_pct,
    p.expense_ratio_pct,
    p.risk_grade
FROM dim_fund f
JOIN fact_performance p
    ON f.amfi_code = p.amfi_code
ORDER BY p.sharpe_ratio DESC;
