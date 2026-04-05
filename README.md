# PhonePe - Transaction Performance & Demographic Analysis
## 🎯 Objective
### **Project Purpose:**
To analyze India’s Digital Payments Growth & User Adoption Trends (2018 Q1 – 2021 Q2)  using PhonePe transaction and demographic data.
### **Key KPIs:**
   * Total Transaction Value: 35.63T
   * Total Transaction Count: 21bn 
   * Average Transaction Value: 1.74K
   * Total Registered Users: 2bn
   * Top 10 States by Registered Users
   * Top 10 Device Brands
### **Deliverables:**
   * Interactive Power BI Dashboards
   * Transaction Trend Analysis
   * Demographic & Device-Level Insights
   * State-wise Adoption Breakdown
---

## 📘 Project Overview 
### **Context Highlights:**
   * Strong quarterly growth in digital transactions
   * Rapid adoption of Peer-to-Peer & Merchant Payments
   * Increasing smartphone penetration driving adoption
   * Expansion across 36 States & UTs and 723 Districts
   * This project evaluates:
     * Growth trajectory of transaction value
     * Category contribution share
     * Geographic concentration
     * Device ecosystem dominance
---

## 🗂️ Data Overview & Schema     
### **Data Source:**  
   * Source: PhonePe Pulse Public Dataset
   * Data Type: Structured Transactional & Demographic Data
   * Time Period: 2018 Q1 – 2021 Q2
### **Data Structure & Metrics:**
   * Key Index Types:
     * Year, Quarter
     * State & UT, District
     * Transaction Type
     * Device Brand
     * Population Bucket
   * Categories (Transaction Types):
     * Peer-to-peer payments, Merchant payments, Recharge & bill payments, Financial Services
     * Others
   * Calculated Metrics:
     * Total Transaction Value (SUM)
     * Total Transaction Count (SUM)
     * Average Transaction Value
     * Total Registered Users
     * Top 10 Ranking (States & Device Brands)
---

## 💻 Tech Stack    
### **Tools:**
   * **Excel**
      * Data storage & preprocessing
   * **Python**
      * Pandas, NumPy, Matplotlib
      * Jupyter Notebook
      * Data cleaning, EDA & visual analysis
   * **Power Query**
      * ETL transformations
   * **Power BI**  
      * Dashboard & Visualization
      * Data Modeling & Relationship Building
      * DAX – KPI Calculations Columns & Measures
      * Slicers & Dynamic Filtering
   * **PowerPoint**
      * Presentation and final dashboard snapshots
---

## 📈 Methodology & Analysis  
### **Preparation, Process & Analytical Approach:** 
   * **Data Preparation & Cleaning:**
       * Standardized naming conventions
       * Structured Year-Quarter format
       * Removed inconsistencies
   * **Data Modeling & Integration:**
       * Built relational model between transaction & demographic tables
       * Time-based relationship for quarterly trend analysis
   * **Feature Engineering:**
       * Created Average Transaction Value = Total Value ÷ Total Count
       * Built Top 10 dynamic ranking measures
       * Enabled slicer-based interactivity
   * **Visualization Design:**
       * KPI Cards for executive summary
       * Area Chart for Total Transaction Growth
       * Donut Chart for Transaction Type Distribution
       * Bar Charts for Top 10 States & Device Brands
       * Consistent purple corporate theme
   * **Validation & Formatting:**
       * Ensured sorting and KPI consistency
---

## ❓ Problem Statements
India has witnessed exponential growth in digital payments over the last few years.
This project analyzed over multiple quarters of PhonePe data to answer key business questions — such as whether transaction growth is driven by increasing users or increasing usage per user, which states dominate digital adoption, and how transaction mix varies across regions.
The analysis combines SQL-based exploration with Power BI dashboards to deliver actionable insights.

### Key Questions:
   * How has Total Transaction Value grown from 2018 to 2021?
   * Is user growth consistently increasing quarter-over-quarter?
   * Are transactions increasing due to more users or higher usage per user?
   * Are there sudden spikes or seasonal patterns in transaction behavior?
   * Which transaction type contributes the highest share?
   * Which transaction categories are growing the fastest?
   * How diversified is the transaction mix across states?
   * Which states contribute most to national transaction volume?
   * Which states show the highest quarter-on-quarter growth?
   * Which states generate higher transaction value per user?
   * Are transaction volumes concentrated in a few states or districts?
   * Which states are emerging markets (low volume, high growth)?
   * Which device brands dominate user adoption?
   * Does device brand dominance influence transaction value or behavior?
   * How does population density impact digital payment adoption?
---

## 💡 Key Insights      
### **Top Findings:** 
   * Strong & Consistent Transaction Growth. Digital transaction value increased steadily from 2018 Q1 to 2021 Q2, indicating sustained adoption momentum. 
   * Peer-to-Peer Payments Dominate the Ecosystem. Peer-to-peer transactions contribute the largest share of total transaction value, followed by merchant payments.
   * Transaction Volume is Geographically Concentrated. A small group of high-population states contributes the majority of national transaction volume.
   * Growth is Driven by Both User Expansion & Usage Intensity. Transaction growth is not only due to rising registered users but also increasing transaction frequency per user.
   * Device Ecosystem Influences Adoption. A few smartphone brands dominate user registration, suggesting device accessibility plays a critical role in digital payment penetration.
   * Emerging High-Growth States Identified. Certain states show lower absolute volume but strong quarter-on-quarter growth, indicating future expansion markets.
### **Supporting Metrics:**
   * Total Transaction Value: 35.63T
   * Total Transaction Count: 21bn
   * Average Transaction Value: 1.74K
   * Total Registered Users: 2bn
   * Peer-to-Peer Share: ~44.62% 
   * Merchant Payment Share: ~33.89% 
   * Highest Registered Users: Maharashtra – (~0.32bn)
   * Highest Device Adoption:  Xiaomi –  (~0.62bn Users)
---

## 📍 Conclusion
### **Summary:** 
   * The digital payments ecosystem shows:
     * Strong and consistent quarterly growth
     * High concentration of users in top-performing states
     * Device ecosystem significantly influencing adoption
     * Dominance of Peer-to-Peer & Merchant Payments
     * The data reflects a scalable and expanding digital economy.
---

## 🖥️ Dashboard Overview
### Transaction Performance
![image alt]([https://github.com/Cnik1710/Academy-for-Business-Careers-Data-Entrepreneurship-ABCDE-Placement-Analysis/blob/e1014362014fc2e85f4311d5cc15bdbfe0198f0a/04.%20Academy%20for%20Business%20Careers%2C%20Data%20%26%20Entrepreneurship%20(ABCDE)%20-%20Placement%20Analysis%20Dashboard.png](https://github.com/Cnik1710/PhonePe-Transaction-Performance-Demographic-Analysis/blob/bbfb8350ba0aafcc2c23d78ffecfea91d9224aa0/05.%20PhonePe%20-%20Transaction%20Performance%20%26%20Demographic%20Analysis%20(1)%20Dashboard.png))

### Demographic Analysis
![image alt]([https://github.com/Cnik1710/Academy-for-Business-Careers-Data-Entrepreneurship-ABCDE-Placement-Analysis/blob/e1014362014fc2e85f4311d5cc15bdbfe0198f0a/04.%20Academy%20for%20Business%20Careers%2C%20Data%20%26%20Entrepreneurship%20(ABCDE)%20-%20Placement%20Analysis%20Dashboard.png](https://github.com/Cnik1710/PhonePe-Transaction-Performance-Demographic-Analysis/blob/bbfb8350ba0aafcc2c23d78ffecfea91d9224aa0/06.%20PhonePe%20-%20Transaction%20Performance%20%26%20Demographic%20Analysis%20(2)%20Dashboard.png))

---

## ✅ Business Impact & Use Cases 
  * Identify high-growth states for market expansion
    * Detect emerging states with strong quarter-on-quarter growth
    * Prioritize regions with increasing transaction value per user
  
  * Optimize marketing campaigns by dominant device segments
    * Align promotional strategies with high-adoption smartphone brands
    * Improve ROI through data-backed customer segmentation
  
  * Track category-wise transaction performance trends
    * Monitor growth of peer-to-peer vs merchant payments
    * Identify shifts in transaction mix over time
  
  * Support fintech investment decisions using state-level performance data
    * Identify high-value markets contributing most to national volume
    * Detect underpenetrated but fast-growing regions
  
  * Enable data-driven regional targeting
    * Understand geographic concentration of transaction activity
    * Guide localized product and partnership strategies
---
 
## 🙏 Acknowledgements & Contact 
### Project Analyst: Anik Chakraborty	
   📧 Email: anikc1710@gmail.com  
### Special Thanks To: 
   * Coding Ninjas – for project framework and guidance  
   



