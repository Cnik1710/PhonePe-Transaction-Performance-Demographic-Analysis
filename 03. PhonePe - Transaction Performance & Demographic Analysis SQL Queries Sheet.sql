SHOW TABLES;

SELECT * FROM phonepe_db.district_demographics;
SELECT * FROM phonepe_db.district_transactions;
SELECT * FROM phonepe_db.state_devicedata;
SELECT * FROM phonepe_db.state_transactions;
SELECT * FROM phonepe_db.state_transactionsplit;

DESC phonepe_db.district_demographics;
DESC phonepe_db.district_transactions;
DESC phonepe_db.state_devicedata;
DESC phonepe_db.state_transactions;
DESC phonepe_db.state_transactionsplit;




# 1. How actively are users engaging with the PhonePe app over time?
SELECT year, quarter, SUM(registered_users) AS total_users, SUM(app_opens) AS total_app_opens,
	ROUND(SUM(app_opens) * 1.0 / NULLIF(SUM(registered_users), 0), 2) AS app_opens_per_user
FROM state_transactions
GROUP BY year, quarter
ORDER BY year, quarter;

# 2. Which states generate higher value per transaction?
SELECT state, ROUND(SUM(transaction_amount) / NULLIF(SUM(transaction_number_count), 0), 2) AS avg_transaction_value
FROM state_transactions
GROUP BY state
ORDER BY avg_transaction_value DESC;

# 3. Which transaction categories are growing the fastest?
WITH quarterly_txns AS (
    SELECT state, transaction_type, year, quarter, SUM(transaction_number_count) AS total_txns
    FROM state_transactionsplit
    GROUP BY state, transaction_type, year, quarter
), growth_calc AS (
    SELECT state, transaction_type, year, quarter, total_txns,
        LAG(total_txns) OVER (PARTITION BY state, transaction_type ORDER BY year, quarter) AS last_q_txns
    FROM quarterly_txns
)
SELECT transaction_type,
    ROUND(AVG((total_txns - last_q_txns) * 100.0 / NULLIF(last_q_txns, 0)),2) AS avg_qoq_growth_pct
FROM growth_calc
WHERE last_q_txns IS NOT NULL
GROUP BY transaction_type
ORDER BY avg_qoq_growth_pct DESC;

# 4. Are transactions increasing because of more users or higher usage per user?
SELECT year, quarter, SUM(transaction_number_count) AS total_transactions, SUM(registered_users) AS total_users,
    ROUND(SUM(transaction_number_count) * 1.0 / NULLIF(SUM(registered_users), 0), 2) AS txn_per_user
FROM state_transactions
GROUP BY year, quarter
ORDER BY year, quarter;

# 5. How diversified is the transaction mix across states?
WITH txn_mix AS (
    SELECT state, transaction_type, AVG(transaction_share) AS avg_share
    FROM state_transactionsplit
    GROUP BY state, transaction_type
), max_share AS (
    SELECT state, MAX(avg_share) AS max_txn_share
    FROM txn_mix
    GROUP BY state)
SELECT state, ROUND(1 - max_txn_share, 2) AS diversification_index
FROM max_share
ORDER BY diversification_index DESC;

# 6. How seasonal is digital payment behavior across states?
WITH q_stats AS (
    SELECT state, quarter,
        AVG(transactions_per_user) AS avg_txn
    FROM state_transactions
    GROUP BY state, quarter
)
SELECT state,
    ROUND(MAX(avg_txn) - MIN(avg_txn), 2) AS seasonality_gap
FROM q_stats
GROUP BY state
ORDER BY seasonality_gap DESC;

# 7. Which states had the highest total transactions?
SELECT state, SUM( transaction_number_count) AS total_transactions
FROM state_transactions
GROUP BY state
ORDER BY total_transactions DESC;

# 8. Which states contribute most to national transaction volume?
SELECT state, SUM(transaction_amount) AS total_transaction_amount
FROM state_transactions
GROUP BY state
ORDER BY SUM(transaction_amount)  DESC;

# 9. Which state recorded the highest transaction volume in each quarter over time?
WITH ranked_states AS (
    SELECT state, year, quarter, SUM(transaction_number_count) AS total_transactions,
        ROW_NUMBER() OVER (PARTITION BY year, quarter ORDER BY SUM(transaction_number_count) DESC) AS rn
    FROM state_transactions
    GROUP BY state, year, quarter
)
SELECT state, year, quarter, total_transactions
FROM ranked_states
WHERE rn = 1
ORDER BY year, quarter;

# 10. Which states show the highest quarter-on-quarter growth?
WITH qoq AS (
    SELECT state, year, quarter, SUM(transaction_amount) AS total_amount,
        LAG(SUM(transaction_amount)) OVER (PARTITION BY state ORDER BY year, quarter) AS prev_quarter_amount
    FROM state_transactions
    GROUP BY state, year, quarter
),
growth AS (
    SELECT state, year, quarter,
        ROUND((total_amount - prev_quarter_amount) * 100.0/ prev_quarter_amount, 2) AS qoq_growth_pct
    FROM qoq
    WHERE prev_quarter_amount IS NOT NULL
)
SELECT state, year, quarter, qoq_growth_pct
FROM growth
ORDER BY qoq_growth_pct DESC;

# 11. Which states generate higher transaction value per user?
SELECT state, ROUND(AVG(transaction_amount_per_user), 2) AS avg_value_per_user
FROM state_transactions
GROUP BY state
ORDER BY avg_value_per_user DESC;


# 12. Are transaction volumes concentrated in a few states or districts? 
SELECT state, SUM(transaction_number_count) AS total_transactions, 
	ROUND(SUM(transaction_number_count) * 100.0 /SUM(SUM(transaction_number_count)) OVER (), 2) AS national_share_pct
FROM state_transactions
GROUP BY state
ORDER BY national_share_pct DESC;

# 13. Which states show consistent quarter-on-quarter positive growth across most periods?
SELECT state, COUNT(*) AS total_quarters,
    SUM(CASE WHEN qoq_transaction_growth > 0 THEN 1 ELSE 0 END) AS positive_growth_quarters,
    ROUND(SUM(CASE WHEN qoq_transaction_growth > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS positive_growth_pct
FROM state_transactions
GROUP BY state
HAVING positive_growth_pct >= 70
ORDER BY positive_growth_pct DESC;

# 14. Which states are emerging markets with low volume but high growth?
SELECT state, transaction_number_count, qoq_transaction_growth
FROM district_transactions
WHERE transaction_number_count < 500000
  AND qoq_transaction_growth > 50
ORDER BY qoq_transaction_growth DESC;

# 15. Which states show early signs of saturation?
SELECT state, AVG(transactions_per_user) AS txn_per_user, AVG(qoq_transaction_growth) AS avg_qoq_growth
FROM state_transactions
GROUP BY state
HAVING txn_per_user > 5 AND avg_qoq_growth < 5
ORDER BY txn_per_user DESC;

# 16. Are there sudden spikes or drops in any state or district?
SELECT state, year, quarter, qoq_transaction_growth
FROM state_transactions
WHERE ABS(qoq_transaction_growth) > 0.5
ORDER BY qoq_transaction_growth DESC;

# 17. What differences emerge when district and state transaction data are summed at different levels?
SELECT s.state,
    SUM(d.transaction_number_count) AS district_total,
    SUM(s.transaction_number_count) AS state_total,
    SUM(d.transaction_number_count) - SUM(s.transaction_number_count) AS difference
FROM state_transactions s
JOIN district_transactions d
  ON s.state = d.state AND s.year = d.year AND s.quarter = d.quarter
GROUP BY s.state
HAVING difference <> 0;

# 18. Which device brands dominate user adoption in each state?
WITH brand_totals AS (
    SELECT state, brand, SUM(registered_users) AS total_registered_users
    FROM state_devicedata
    GROUP BY state, brand
), ranked_brands AS (
    SELECT state, brand, total_registered_users,
        RANK() OVER (PARTITION BY state ORDER BY total_registered_users DESC) AS rnk
    FROM brand_totals)
SELECT
    state, brand, total_registered_users
FROM ranked_brands
WHERE rnk = 1
ORDER BY total_registered_users DESC;

# 19. Does device brand dominance influence transaction behavior or value?
SELECT
    d.brand,
    AVG(t.transactions_per_user) AS avg_txn_per_user,
    AVG(t.transaction_amount_per_user) AS avg_value_per_user
FROM state_devicedata d
JOIN state_transactions t
  ON d.state = t.state
 AND d.year = t.year
 AND d.quarter = t.quarter
WHERE d.top_brand_flag = 1
GROUP BY d.brand
ORDER BY avg_value_per_user DESC;

# 20. Where are users registered but not actively transacting?
-- Part-1) **Blank
SELECT d.state, d.year, d.quarter, d.registered_users, t.transactions_per_user, t.transaction_amount_per_user
FROM state_devicedata d
JOIN state_transactions t
  ON d.state = t.state AND d.year = t.year AND d.quarter = t.quarter
WHERE d.registered_users > 0 AND t.transactions_per_user = 0
ORDER BY d.registered_users DESC;

-- Part-2)
WITH device_users AS (
    SELECT state, year, quarter, MAX(registered_users) AS registered_users
    FROM state_devicedata
    GROUP BY state, year, quarter
),
ranked_usage AS (
    SELECT d.state, d.year, d.quarter, d.registered_users, t.transactions_per_user,
        NTILE(10) OVER (ORDER BY t.transactions_per_user) AS usage_decile
    FROM device_users d
    JOIN state_transactions t
      ON d.state = t.state AND d.year = t.year AND d.quarter = t.quarter
)
SELECT *
FROM ranked_usage
WHERE usage_decile = 1
ORDER BY transactions_per_user;

# 21. How deep is digital payment penetration across states?
WITH state_population AS (
    SELECT state, SUM(population) AS total_population
    FROM district_demographics
    GROUP BY state
),
state_users AS (
    SELECT state, year, quarter, MAX(registered_users) AS registered_users
    FROM state_devicedata
    GROUP BY state, year, quarter
)
SELECT
    u.state, u.year, u.quarter, u.registered_users, p.total_population,
    ROUND(u.registered_users * 100.0 / NULLIF(p.total_population, 0), 2) AS penetration_pct
FROM state_users u
JOIN state_population p
  ON u.state = p.state
ORDER BY penetration_pct DESC;

# 22. How does population density impact digital payment adoption?
WITH state_density AS (
    SELECT state, AVG(density) AS avg_population_density
    FROM district_demographics
    GROUP BY state
)
SELECT
    sd.state,
    ROUND(sd.avg_population_density, 2) AS avg_density,
    ROUND(AVG(st.transactions_per_user), 2) AS avg_txn_per_user,
    ROUND(AVG(st.transaction_amount_per_user), 2) AS avg_value_per_user
FROM state_density sd
JOIN state_transactions st
  ON sd.state = st.state
GROUP BY sd.state
ORDER BY avg_density DESC;

# 23. Do high-density districts behave differently from low-density districts?
WITH district_density AS (
    SELECT
        state,
        CASE
            WHEN density < 300 THEN 'Low Density'
            WHEN density BETWEEN 300 AND 1000 THEN 'Medium Density'
            ELSE 'High Density'
        END AS density_category
    FROM district_demographics
),
state_density_mix AS (
    SELECT
        state,
        density_category,
        COUNT(*) AS district_count
    FROM district_density
    GROUP BY state, density_category
)
SELECT
    sdm.density_category,
    ROUND(AVG(st.transactions_per_user), 2) AS avg_txn_per_user,
    ROUND(AVG(st.transaction_amount_per_user), 2) AS avg_value_per_user,
    ROUND(AVG(st.app_opens_per_user), 2) AS avg_app_opens
FROM state_density_mix sdm
JOIN state_transactions st
  ON sdm.state = st.state
GROUP BY sdm.density_category
ORDER BY avg_txn_per_user DESC;

# 24. Which high population density states have below-average quarter-on-quarter transaction growth?
WITH state_density AS (
    SELECT state, AVG(density) AS avg_population_density
    FROM district_demographics
    GROUP BY state
),
state_growth AS (
    SELECT state, AVG(qoq_transaction_growth) AS avg_qoq_growth
    FROM district_transactions
    GROUP BY state
),
overall_growth AS (
    SELECT AVG(avg_qoq_growth) AS overall_avg_growth
    FROM state_growth
)
SELECT d.state, d.avg_population_density, g.avg_qoq_growth
FROM state_density d
JOIN state_growth g
    ON d.state = g.state
CROSS JOIN overall_growth o
WHERE d.avg_population_density > 1000
  AND g.avg_qoq_growth < o.overall_avg_growth
ORDER BY g.avg_qoq_growth;