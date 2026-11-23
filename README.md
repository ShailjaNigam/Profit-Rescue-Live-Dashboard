# Profit Rescue Analytics Project (SQL + Power BI)

## Project contents
- `data/`: seven CSV tables exported from the source workbook
- `sql/`: database schema, CSV import statements, and business analysis queries
- `powerbi/`: DAX measures, theme JSON, and report construction guide
- `dashboard/Profit_Rescue_Dashboard.html`: lightweight dashboard for immediate viewing in a browser
- `Profit_Rescue_Business_Data.xlsx`: original source workbook

## Quick start
### 1) View dashboard
Open `dashboard/Profit_Rescue_Dashboard.html` in Chrome/Edge. This is a standalone dashboard view.

### 2) MySQL setup
1. Open MySQL Workbench and connect to your local MySQL server.
2. Run `sql/01_schema.sql`.
3. Enable `LOCAL INFILE` if needed (Workbench connection settings; server/client policy may require configuration).
4. From the extracted project folder, run `sql/02_import_csv.sql`. If relative file paths fail, replace each `data/...` path with its absolute local path.
5. Run the queries in `sql/03_analysis_queries.sql`.

The import script assumes the CSV files are in a path accessible to the MySQL client and LOCAL INFILE is enabled. In some configurations, the SQL import needs a path adjustment.

### 3) Build the native Power BI report
Follow `powerbi/PowerBI_Build_Guide.md`, import CSVs, create the listed relationships, add the DAX measures and theme, then save your `.pbix` in Power BI Desktop. A native PBIX is not included because it must be generated and saved using Power BI Desktop; this project provides the complete data, model guidance, measures, theme and dashboard preview.

## Dashboard project analysis
The dataset is synthetic and designed to practice:
- Discount leakage and low-margin transaction detection
- Revenue/profit trends and regional performance
- Inventory stock-risk review
- Return reason/refund tracking
- Sales target comparisons and customer performance

## Caveats
- Returns are separate from sales profit in the base data. Do not subtract refund totals from profit without a carefully defined measure and appropriate return-item/quantity handling.
- Target comparison requires careful date + region grain; avoid relationships that duplicate target values across sales order lines.
- Data is synthetic, not real company data.


## Live interactive browser dashboard
Open `dashboard/Profit_Rescue_Dashboard.html` in Chrome/Edge. Use Region, Category and date filters to animate/recalculate the KPIs and charts. To refresh from changed data, choose the three CSV files `Sales_Order_Items.csv`, `Sales_Orders.csv`, and `Products.csv` together in the upload control. Dashboard refresh is browser-local and does not connect to a live database automatically.


## Live interactive dashboard refresh
The browser dashboard is interactive: filter by region/category/date and charts animate as the filtered values update. To refresh from a changed dataset, upload the three files `Sales_Order_Items.csv`, `Sales_Orders.csv`, and `Products.csv` together in the dashboard. This is a local browser dashboard and is not a hosted internet deployment or a live MySQL connection.

## Project title / portfolio description
**Profit Rescue Analytics — Retail Profitability & Leakage Dashboard.** The project investigates sales revenue, gross profit, discount leakage, regional/category performance, low-profit products and inventory/returns risk using SQL and dashboard analytics.
