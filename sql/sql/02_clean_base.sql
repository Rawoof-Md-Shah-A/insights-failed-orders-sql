-- Create base analysis view

CREATE OR REPLACE VIEW v_orders_base AS
WITH offer_counts AS (
  SELECT order_gk, COUNT(*) AS offer_cnt
  FROM data_offers
  GROUP BY order_gk
)
SELECT
  o.*,
  COALESCE(oc.offer_cnt, 0) AS offer_cnt,
  CASE o.order_status_key
    WHEN 4 THEN 'Cancelled by Client'
    WHEN 9 THEN 'Cancelled by System'
    ELSE 'Other'
  END AS order_status,
  CASE o.is_driver_assigned_key
    WHEN 1 THEN 'Driver Assigned'
    WHEN 0 THEN 'No Driver Assigned'
    ELSE 'Unknown'
  END AS driver_assignment
FROM data_orders o
LEFT JOIN offer_counts oc
  ON o.order_gk = oc.order_gk;
