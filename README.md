# Retail Store Data Pipeline & Analysis

An end-to-end **retail store data pipeline** built with Python, Pandas, and SQL Server.  
Cleans, transforms, and loads retail data from CSV files to SQL Server and provides actionable business insights.

---

## 📋 Project Overview

This project implements a complete **ETL pipeline** and analysis workflow:

1. Load 9 CSV files containing retail data
2. Clean and transform data (handle missing values, duplicates, types)
3. Calculate derived fields (total_price, order totals, customer full names)
4. Load data into SQL Server database
5. Execute analytical queries and generate visualizations

**Dataset:** 2016-2018 retail store data (~10,000+ records)

---

## 🛠️ Technologies Used

- **Python 3.8+**: Pandas, NumPy, SQLAlchemy, Matplotlib
- **SQL Server 2019+**  
- **Jupyter Notebook**  
- **ODBC Driver 17** for SQL Server connection

---

## 📁 Project Structure

```

retail-store-data-pipeline/
├── README.md
├── requirements.txt
├── notebooks/
│   ├── 01_data_pipeline.ipynb       # ETL Pipeline: Load, Clean, Transform, Load
│   └── 02_final_report.ipynb        # Analysis & Visualizations
├── data/                             # Raw CSV files (9 files)
├── cleaned_data/                     # Cleaned CSV files
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_schema.sql
│   └── 03_analysis_queries.sql
├── reports/                          # Generated reports and plots
└── images/
├── erd_diagram.png
├── database_schema.png
├── sales_trend.png
└── top_customers.png

````

---

## 🗃️ Database Design

### ERD Diagram

![ERD Diagram](images/erd_diagram.png)

- Database follows **3NF**  
- Self-referencing FK in **Staffs.manager_id** handled carefully  
- All tables include **Primary Keys** and **Foreign Keys**  
- Composite PKs in `OrderItems` and `Stocks`

**Tables Overview:**
| Table       | Records | Notes |
|------------|---------|-------|
| Brands      | 9       | -     |
| Categories  | 7       | -     |
| Stores      | 3       | -     |
| Products    | 321     | FK → Brands, Categories |
| Staffs      | 10      | FK → Stores, Self-referencing manager_id |
| Customers   | 1,445   | -     |
| Orders      | 1,615   | FK → Customers, Stores, Staffs |
| OrderItems  | 4,722   | FK → Orders, Products |
| Stocks      | 939     | FK → Stores, Products |


---

## 🚀 Installation

### 1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/retail-store-data-pipeline.git
cd retail-store-data-pipeline
````

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Setup SQL Server

```bash
sqlcmd -S localhost -i sql/01_create_database.sql
sqlcmd -S localhost -d RetailDB -i sql/02_create_schema.sql
```

> ⚠️ Make sure SQL Server is running and ODBC Driver 17 is installed.

---

## 💻 Usage

### Run the ETL pipeline:

1. Open `notebooks/01_data_pipeline.ipynb`
2. Run all cells sequentially
3. Data will be cleaned and loaded into SQL Server

### Run analysis queries:

```bash
sqlcmd -S localhost -d RetailDB -i sql/03_analysis_queries.sql
```

### Generate reports & plots:

1. Open `notebooks/02_final_report.ipynb`
2. Run all cells to generate visualizations
3. Example plots are saved in `reports/` folder

---

## 🔄 Data Pipeline Steps

1. **Load CSV files** → Brands, Categories, Products, Customers, Orders, OrderItems, Staffs, Stores, Stocks
2. **Clean Data**

   * Handle missing phone/email
   * Standardize formats and types
   * Remove duplicates and unrealistic values
3. **Transform Data**

   * `total_price = quantity * list_price * (1 - discount)`
   * `order_total_amount` per order
   * Customer `full_name`
4. **Load into SQL Server**

   * Tables created with PKs, FKs, and constraints

---

## 📊 Analysis & Visualizations

### Sales Insights

* **Top 10 Best-Selling Products**
  ![Top Products](images/top_products.png)

* **Top 5 Customers by Spending**
  ![Top Customers](images/top_customers.png)

* **Revenue per Store**
  ![Revenue per Store](images/revenue_store.png)

* **Revenue per category**
  ![Revenue per Store](images/revenue_category.png)
  
* **Monthly Sales Trend**
  ![Sales Trend](images/sales_trend.png)

### Inventory Insights

* Products with **low stock (< average)**
* Stores with **highest inventory levels**

### Staff Performance

* Orders handled by each staff
* Best performing staff by **total sales**

### Customer Insights

* Customers with no orders
* Average spending per customer

---

## 📈 Key Results

* ✅ 9 tables cleaned and loaded into SQL Server
* ✅ 0 missing values after cleaning
* ✅ 47 duplicate rows removed
* ✅ 11+ analysis queries executed successfully
* ✅ 6 visualizations generated and saved in `reports/`

**Example Insights:**

* Top-selling product: Trek Fuel EX 8
* Highest revenue store: Store 1 ($123,456)
* Best customer: Customer #24 ($2,345 spent)

---

## 📬 Contact

* **LinkedIn:** [mahmoudgamalsaad](https://www.linkedin.com/in/mahmoudgamalsaad)
* **Email:** [mahmoud23456123@gmail.com](mailto:mahmoud23456123@gmail.com)

---
