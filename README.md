# Insights from Failed Orders (SQL Project)

## Objective
Analyze failed ride orders to determine whether failures are caused by supply-side issues (no driver assignment, low offers) or customer behavior (cancellations, ETA).

## Dataset
- data_orders (10,716 rows)
- data_offers (334,363 rows)

## Approach
1. Joined orders with offer counts
2. Created a base analysis view
3. Calculated key performance indicators
4. Performed deep-dive analysis (hourly trends, ETA impact, offer distribution)

## Key Metrics
- Order status distribution
- Driver assignment rate
- Offers per order
- Cancellation timing
- Hourly failure patterns

## Tools Used
- SQL (PostgreSQL)
- GitHub
- (Power BI / Excel for visualization – to be added)

---

# Insights from Failed Orders (SQL Analysis)

## 📌 Objective
Analyze failed ride orders to determine whether failures are primarily caused by supply-side issues (driver assignment & offers) or customer behavior (cancellations & ETA).

---

## 📂 Dataset Overview

**Tables Used**
- `data_orders` (10,716 rows)
- `data_offers` (334,363 rows)

Key Columns:
- `order_status_key`
- `is_driver_assigned_key`
- `m_order_eta`
- `cancellations_time_in_seconds`
- `offer_id`

---

## 🛠 Data Preparation

- Joined `data_orders` with aggregated offer counts.
- Created a base analysis view (`v_orders_base`).
- Converted status and assignment keys into readable labels.

---

## 📊 Key Performance Indicators (KPIs)

### 1️⃣ Order Status Distribution

| Status | Total Orders | % |
|--------|--------------|---|
| Cancelled by Client | 7307 | 68.19% |
| Cancelled by System | 3409 | 31.81% |

---

### 2️⃣ Driver Assignment Rate

| Driver Assignment | Total Orders | % |
|-------------------|--------------|---|
| No Driver Assigned | 7907 | 73.74% |
| Driver Assigned | 2809 | 26.26% |

---

### 3️⃣ Status vs Driver Assignment

- 99.9% of system cancellations occurred when no driver was assigned.
- 61.6% of client cancellations also occurred without driver assignment.

---

## 🔎 Initial Insights

- Only 26% of orders received a driver assignment.
- Nearly all system cancellations were due to failure to assign a driver.
- Even customer cancellations are strongly correlated with lack of assignment.
- Supply-side matching appears to be the dominant failure driver.

---

## 📈 Next Steps

- Analyze offer distribution impact.
- Investigate hourly failure patterns.
- Study ETA impact on cancellation timing.
- Identify supply-demand imbalance patterns.

---

Project in progress.
