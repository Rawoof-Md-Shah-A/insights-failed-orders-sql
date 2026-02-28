-- ==========================================
-- KPI 1: Order Status Distribution
-- ==========================================

SELECT
  order_status,
  COUNT(*) AS total_orders,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_of_total
FROM v_orders_base
GROUP BY order_status
ORDER BY total_orders DESC;


-- ==========================================
-- KPI 2: Driver Assignment Distribution
-- ==========================================

SELECT
  driver_assignment,
  COUNT(*) AS total_orders,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_of_total
FROM v_orders_base
GROUP BY driver_assignment
ORDER BY total_orders DESC;


-- ==========================================
-- KPI 3: Status vs Driver Assignment
-- ==========================================

SELECT
  order_status,
  driver_assignment,
  COUNT(*) AS total_orders,
  ROUND(
    100.0 * COUNT(*) /
    SUM(COUNT(*)) OVER (PARTITION BY order_status),
    2
  ) AS pct_within_status
FROM v_orders_base
GROUP BY order_status, driver_assignment
ORDER BY order_status, total_orders DESC;


-- ==========================================
-- KPI 4: Offer Distribution & Assignment Rate
-- ==========================================

SELECT
  CASE
    WHEN offer_cnt = 0 THEN '0 offers'
    WHEN offer_cnt BETWEEN 1 AND 2 THEN '1-2 offers'
    WHEN offer_cnt BETWEEN 3 AND 5 THEN '3-5 offers'
    ELSE '6+ offers'
  END AS offer_bucket,
  COUNT(*) AS total_orders,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_of_orders,
  ROUND(
    AVG(CASE WHEN is_driver_assigned_key = 1 THEN 1.0 ELSE 0 END)::numeric,
    3
  ) AS assigned_rate
FROM v_orders_base
GROUP BY offer_bucket
ORDER BY total_orders DESC;


-- ==========================================
-- KPI 5: Hourly Supply-Demand Pattern
-- ==========================================

SELECT
  EXTRACT(HOUR FROM order_datetime::time) AS order_hour,
  COUNT(*) AS total_orders,
  ROUND(
    AVG(CASE WHEN is_driver_assigned_key = 1 THEN 1.0 ELSE 0 END)::numeric,
    3
  ) AS assigned_rate,
  ROUND(AVG(offer_cnt)::numeric, 2) AS avg_offers,
  ROUND(
    AVG(CASE WHEN order_status_key = 9 THEN 1.0 ELSE 0 END)::numeric,
    3
  ) AS system_cancel_rate
FROM v_orders_base
GROUP BY order_hour
ORDER BY order_hour;
