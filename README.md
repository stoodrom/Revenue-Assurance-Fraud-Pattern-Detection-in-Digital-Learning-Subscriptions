# Revenue-Assurance-Fraud-Pattern-Detection-in-Digital-Learning-Subscriptions
This project analyzes user behavior and transactional data in an ed-tech environment to detect potential revenue leakage through fraud or misuse. It demonstrates advanced SQL querying, exploratory data analysis (EDA), machine learning, and dashboarding
# Advanced SQL + EDA Churn Analysis Project 🚀

This project highlights advanced **SQL**, **EDA**, and **Data Science** skills by analyzing a fictional e-commerce or subscription-based platform to detect churn, revenue loss, and behavioral anomalies.

##  Objectives
- Detect user churn trends using cohort analysis
- Identify fraudulent behavior via device/IP analysis
- Understand refund-driven revenue loss
- Predict future churn using machine learning models

---

##  Tech Stack
- SQL (PostgreSQL / BigQuery compatible)
- Python (pandas, seaborn, scikit-learn)
- Jupyter Notebook
- Optional: Power BI / Tableau for dashboarding

---

##  Folder Structure

##  SQL Highlights

### 1. `churn_cohorts.sql`
Tracks monthly active users per signup cohort using `DATE_TRUNC()` and grouping.

### 2. `device_abuse_detection.sql`
Flags users logging in from >3 IPs or devices — possible fraud/sharing.

### 3. `refund_anomaly.sql`
Uses window functions (`LAG()`) to detect sudden spikes in refund behavior.

### 4. `revenue_summary.sql`
Calculates refund %, gross revenue, and average ticket size by month.

---

##  Notebook Summary

The notebook performs:
- EDA on user activity, revenue, refunds
- Feature engineering for churn modeling
- Logistic Regression + ROC-AUC + Confusion Matrix
