-- Churn Cohort Analysis: Users grouped by signup month and active across months

WITH user_signup AS (
    SELECT
        user_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM users
),
user_activity AS (
    SELECT
        s.user_id,
        DATE_TRUNC('month', login_time) AS activity_month
    FROM sessions s
    JOIN users u ON s.user_id = u.user_id
),
cohorts AS (
    SELECT
        us.cohort_month,
        ua.activity_month,
        COUNT(DISTINCT ua.user_id) AS active_users
    FROM user_signup us
    JOIN user_activity ua ON us.user_id = ua.user_id
    GROUP BY us.cohort_month, ua.activity_month
    ORDER BY cohort_month, activity_month
)
SELECT * FROM cohorts;
-- Detect users logging in from more than 3 distinct IPs (potential account sharing)

SELECT
    user_id,
    COUNT(DISTINCT ip_address) AS distinct_ips,
    COUNT(DISTINCT device_type) AS distinct_devices
FROM sessions
GROUP BY user_id
HAVING COUNT(DISTINCT ip_address) > 3 OR COUNT(DISTINCT device_type) > 3;

-- Identify users with sudden spikes in refund requests using window functions

WITH refund_counts AS (
    SELECT
        user_id,
        DATE_TRUNC('month', transaction_date) AS txn_month,
        COUNT(*) FILTER (WHERE refund_requested) AS refunds
    FROM transactions
    GROUP BY user_id, txn_month
),
refund_flags AS (
    SELECT
        user_id,
        txn_month,
        refunds,
        LAG(refunds, 1) OVER (PARTITION BY user_id ORDER BY txn_month) AS prev_month_refunds
    FROM refund_counts
)
SELECT *
FROM refund_flags
WHERE refunds >= 3 AND (prev_month_refunds IS NULL OR refunds > 2 * prev_month_refunds);

-- Monthly revenue KPIs: total, refund %, and average ticket size

SELECT
    DATE_TRUNC('month', transaction_date) AS revenue_month,
    COUNT(*) AS total_txns,
    SUM(amount) AS gross_revenue,
    SUM(CASE WHEN refund_requested THEN amount ELSE 0 END) AS refunded_amount,
    ROUND(AVG(amount), 2) AS avg_ticket_size,
    ROUND(
        SUM(CASE WHEN refund_requested THEN amount ELSE 0 END) / NULLIF(SUM(amount), 0) * 100,
        2
    ) AS refund_pct
FROM transactions
GROUP BY revenue_month
ORDER BY revenue_month;
