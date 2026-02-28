-- ==========================================
-- KPI 1: Order Status Distribution
-- ==========================================

SELECT
  order_status,
  COUNT(*) AS total_orders,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct
FROM v_orders_base
GROUP BY order_status
ORDER BY total_orders DESC;


-- ==========================================
-- KPI 2: Driver Assignment Distribution
-- ==========================================

SELECT
  driver_assignment,
  COUNT(*) AS total_orders,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct
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
