
PRAGMA foreign_keys = ON;

-- 1. Fund dimension table
CREATE TABLE IF NOT EXISTS dim_fund (
    amfi_code TEXT PRIMARY KEY,
    fund_house TEXT,
    scheme_name TEXT,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date TEXT,
    benchmark TEXT,
    expense_ratio_pct REAL,
    exit_load_pct REAL,
    min_sip_amount REAL,
    min_lumpsum_amount REAL,
    fund_manager TEXT,
    risk_category TEXT,
    sebi_category_code TEXT
);

-- 2. Date dimension table
CREATE TABLE IF NOT EXISTS dim_date (
    date_id INTEGER PRIMARY KEY,
    date TEXT UNIQUE NOT NULL,
    year INTEGER,
    month INTEGER,
    quarter INTEGER,
    is_weekday INTEGER
);

-- 3. NAV fact table
CREATE TABLE IF NOT EXISTS fact_nav (
    amfi_code TEXT NOT NULL,
    nav_date TEXT NOT NULL,
    nav REAL NOT NULL,
    daily_return REAL,
    PRIMARY KEY (amfi_code, nav_date),
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (nav_date) REFERENCES dim_date(date)
);

-- 4. Investor transactions fact table
CREATE TABLE IF NOT EXISTS fact_transactions (
    tx_id INTEGER PRIMARY KEY AUTOINCREMENT,
    investor_id TEXT,
    amfi_code TEXT NOT NULL,
    transaction_date TEXT NOT NULL,
    amount_inr REAL NOT NULL,
    transaction_type TEXT,
    state TEXT,
    city TEXT,
    city_tier TEXT,
    age_group TEXT,
    gender TEXT,
    annual_income_lakh REAL,
    payment_mode TEXT,
    kyc_status TEXT,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (transaction_date) REFERENCES dim_date(date)
);

-- 5. Fund performance fact table
CREATE TABLE IF NOT EXISTS fact_performance (
    amfi_code TEXT PRIMARY KEY,
    return_1yr_pct REAL,
    return_3yr_pct REAL,
    return_5yr_pct REAL,
    benchmark_3yr_pct REAL,
    alpha REAL,
    beta REAL,
    sharpe_ratio REAL,
    sortino_ratio REAL,
    std_dev_ann_pct REAL,
    max_drawdown_pct REAL,
    aum_crore REAL,
    expense_ratio_pct REAL,
    morningstar_rating REAL,
    risk_grade TEXT,
    negative_sharpe_flag INTEGER,
    expense_ratio_flag INTEGER,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- 6. Portfolio holdings fact table
CREATE TABLE IF NOT EXISTS fact_portfolio (
    amfi_code TEXT NOT NULL,
    stock_symbol TEXT NOT NULL,
    stock_name TEXT,
    sector TEXT,
    weight_pct REAL,
    market_value_cr REAL,
    current_price_inr REAL,
    portfolio_date TEXT NOT NULL,
    PRIMARY KEY (amfi_code, stock_symbol, portfolio_date),
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (portfolio_date) REFERENCES dim_date(date)
);

-- 7. Fund house AUM fact table
CREATE TABLE IF NOT EXISTS fact_aum (
    fund_house TEXT NOT NULL,
    date TEXT NOT NULL,
    aum_lakh_crore REAL,
    aum_crore REAL,
    num_schemes INTEGER,
    PRIMARY KEY (fund_house, date),
    FOREIGN KEY (date) REFERENCES dim_date(date)
);

-- 8. Industry SIP fact table
CREATE TABLE IF NOT EXISTS fact_sip_industry (
    month TEXT PRIMARY KEY,
    sip_inflow_crore REAL,
    active_sip_accounts_crore REAL,
    new_sip_accounts_lakh REAL,
    sip_aum_lakh_crore REAL,
    yoy_growth_pct REAL
);

-- Indexes for frequently queried columns
CREATE INDEX IF NOT EXISTS idx_nav_date
ON fact_nav(nav_date);

CREATE INDEX IF NOT EXISTS idx_transactions_date
ON fact_transactions(transaction_date);

CREATE INDEX IF NOT EXISTS idx_transactions_state
ON fact_transactions(state);

CREATE INDEX IF NOT EXISTS idx_transactions_type
ON fact_transactions(transaction_type);


-- 9. Category-wise industry inflows
CREATE TABLE IF NOT EXISTS fact_category_inflows (
    month TEXT NOT NULL,
    category TEXT NOT NULL,
    net_inflow_crore REAL,
    PRIMARY KEY (month, category)
);

-- 10. Industry folio count
CREATE TABLE IF NOT EXISTS fact_industry_folios (
    month TEXT PRIMARY KEY,
    total_folios_crore REAL,
    equity_folios_crore REAL,
    debt_folios_crore REAL,
    hybrid_folios_crore REAL,
    others_folios_crore REAL
);

-- 11. Benchmark indices
CREATE TABLE IF NOT EXISTS fact_benchmark_indices (
    benchmark_date TEXT NOT NULL,
    index_name TEXT NOT NULL,
    close_value REAL,
    PRIMARY KEY (benchmark_date, index_name),
    FOREIGN KEY (benchmark_date) REFERENCES dim_date(date)
);
