-- Table creation script

CREATE TABLE data_orders (
  order_datetime TEXT,
  origin_longitude DOUBLE PRECISION,
  origin_latitude DOUBLE PRECISION,
  m_order_eta DOUBLE PRECISION,
  order_gk BIGINT PRIMARY KEY,
  order_status_key INT,
  is_driver_assigned_key INT,
  cancellations_time_in_seconds DOUBLE PRECISION
);

CREATE TABLE data_offers (
  order_gk BIGINT,
  offer_id BIGINT
);
