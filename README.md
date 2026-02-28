# Insights from Failed Orders (SQL Analysis)

## 📌 Project Objective

This project analyzes failed ride orders to determine whether failures are primarily driven by:

- Supply-side issues (driver assignment & offer distribution)
- Customer behavior (cancellations & ETA impact)

The goal is to diagnose operational inefficiencies in the ride-matching system.

---

## 📂 Dataset Overview

Two tables were used:

### 1️⃣ data_orders (10,716 rows)
Key columns:
- order_status_key
- is_driver_assigned_key
- m_order_eta
- cancellations_time_in_seconds
- order_datetime

### 2️⃣ data_offers (334,363 rows)
- order_gk
- offer_id

Each order may receive multiple offers.

---

## 🛠 Data Preparation

- Aggregated offer counts per order
- Joined orders with offer counts
- Created analysis view: `v_orders_base`
- Converted key columns into readable labels:
  - order_status
  - driver_assignment

---

## 📊 Key Findings

### 1️⃣ Driver Assignment Problem

- 73.7% of orders did NOT receive a driver assignment.
- Only 26.3% of orders were successfully assigned.

### 2️⃣ System Cancellations = Supply Failure

- 99.9% of system cancellations occurred when no driver was assigned.
- Indicates supply-side matching failure.

### 3️⃣ Client Cancellations Also Linked to No Assignment

- 61.6% of client cancellations occurred without driver assignment.

### 4️⃣ Offer Distribution Insight

- 29% of orders received zero offers.
- Assignment rate for zero-offer orders = 15.3%.
- Assignment improves with 1–2 offers (37.4%).
- Assignment declines when offers exceed 3+, indicating diminishing returns or driver rejection behavior.

### 5️⃣ Time-Based Imbalance

Assignment collapses during:
- 2–3 AM
- 9–11 PM

System cancellations exceed 40% during 2–3 AM.

Mid-morning (10–12 PM) shows highest assignment rate (up to 57.5%).

This suggests supply-demand imbalance during late-night and evening peak hours.

---

## ⚠️ ETA Analysis Limitation

ETA is only available for assigned orders.
 Dataset contains only failed rides.
 Therefore, ETA impact on cancellation cannot be reliably evaluated.

---

## 🧠 Business Recommendations

1. Increase driver incentives during late-night and late-evening hours.
2. Improve dispatch strategy for zero-offer orders.
3. Optimize driver acceptance logic when offers are high but assignment remains low.
4. Track time-to-first-offer as a core operational KPI.

---

## 🛠 Tools Used

- PostgreSQL (pgAdmin)
- SQL (CTEs, Window Functions, Aggregations)
- GitHub (Project Structuring)

---

Project Status: Completed Core Analysis
