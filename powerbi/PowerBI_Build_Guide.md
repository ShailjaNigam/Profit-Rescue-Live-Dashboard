# Power BI build guide
1. Power BI Desktop > Get Data > Text/CSV; import the 7 CSVs in `data/`.
2. Rename tables: Customers, Products, Sales_Orders, Sales_Order_Items, Inventory_Snapshots, Returns, Sales_Targets. Set dates and numeric types correctly.
3. Create relationships: Customers[Customer_ID] 1 -> * Sales_Orders[Customer_ID]; Sales_Orders[Order_ID] 1 -> * Sales_Order_Items[Order_ID]; Products[Product_ID] 1 -> * Sales_Order_Items[Product_ID]; Products[Product_ID] 1 -> * Inventory_Snapshots[Product_ID]; Sales_Order_Items[Order_Item_ID] 1 -> * Returns[Order_Item_ID].
4. Create a Calendar table with CALENDAR(DATE(2024,1,1),DATE(2025,12,31)), Year, Month Name, Month Number and YearMonth. Sort Month Name by Month Number. Relate Calendar[Date] to Sales_Orders[Order_Date].
5. Add measures from DAX_Measures.txt (adjust table names if needed). Be careful to not double-count targets across order lines.
6. Suggested pages: Executive Overview (KPIs, monthly trend, region/category); Discount Leakage (discount bands, margin, low-margin detail); Inventory & Returns (latest stock risk, refund reasons); Customer & Sales (segment, top customers, salesperson).
7. Apply Profit_Rescue_Theme.json in View > Themes > Browse for themes.
8. Save Power BI Desktop file as Profit_Rescue_Dashboard.pbix. This package includes the CSVs, SQL, DAX, theme, instructions, and a browser dashboard; a native PBIX must be created/saved in Power BI Desktop.
