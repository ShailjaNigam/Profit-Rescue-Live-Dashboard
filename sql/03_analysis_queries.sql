USE profit_rescue_db;
-- Executive KPIs
SELECT SUM(revenue) revenue,SUM(profit) profit,SUM(gross_sales) gross_sales,SUM(discount_amount) discounts,SUM(quantity) units,COUNT(DISTINCT order_id) orders FROM sales_order_items;
-- Discount bands
SELECT CASE WHEN discount_rate>=.30 THEN '30%+' WHEN discount_rate>=.20 THEN '20-29%' WHEN discount_rate>=.10 THEN '10-19%' ELSE '0-9%' END discount_band,COUNT(*) lines,SUM(revenue) revenue,SUM(profit) profit,AVG(discount_rate) avg_discount FROM sales_order_items GROUP BY discount_band ORDER BY discount_band;
-- Month trend
SELECT DATE_FORMAT(o.order_date,'%Y-%m') month,SUM(i.revenue) revenue,SUM(i.profit) profit FROM sales_orders o JOIN sales_order_items i ON o.order_id=i.order_id GROUP BY month ORDER BY month;
-- Regional performance
SELECT o.region,SUM(i.revenue) revenue,SUM(i.profit) profit,SUM(i.discount_amount) discounts FROM sales_orders o JOIN sales_order_items i ON o.order_id=i.order_id GROUP BY o.region ORDER BY profit DESC;
-- Product and category
SELECT p.category,p.product_name,SUM(i.quantity) units,SUM(i.revenue) revenue,SUM(i.profit) profit,SUM(i.discount_amount) discounts FROM products p JOIN sales_order_items i ON p.product_id=i.product_id GROUP BY p.category,p.product_name ORDER BY profit ASC;
-- Low-margin lines
SELECT i.order_item_id,p.product_name,o.order_date,o.region,i.discount_rate,i.revenue,i.cost,i.profit,ROUND(100*i.profit/NULLIF(i.revenue,0),2) margin_pct FROM sales_order_items i JOIN products p ON p.product_id=i.product_id JOIN sales_orders o ON o.order_id=i.order_id WHERE i.profit<0 OR i.profit/NULLIF(i.revenue,0)<.10 ORDER BY i.profit;
-- Returns reason
SELECT return_reason,COUNT(*) return_count,SUM(refund_amount) refunds FROM returns GROUP BY return_reason ORDER BY refunds DESC;
-- Latest inventory stock-risk products
WITH r AS(SELECT *,ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY snapshot_date DESC) rn FROM inventory_snapshots) SELECT p.product_name,p.category,r.snapshot_date,r.stock_on_hand,r.reorder_level FROM r JOIN products p ON p.product_id=r.product_id WHERE rn=1 AND stock_on_hand<=reorder_level ORDER BY stock_on_hand;
-- Regional monthly targets
SELECT t.target_month,t.region,t.target_revenue,COALESCE(SUM(i.revenue),0) actual_revenue,COALESCE(SUM(i.revenue),0)-t.target_revenue variance FROM sales_targets t LEFT JOIN sales_orders o ON o.region=t.region AND DATE_FORMAT(o.order_date,'%Y-%m')=DATE_FORMAT(t.target_month,'%Y-%m') LEFT JOIN sales_order_items i ON i.order_id=o.order_id GROUP BY t.target_month,t.region,t.target_revenue ORDER BY t.target_month,t.region;
-- Top customers
SELECT c.customer_id,c.customer_name,c.segment,c.city,SUM(i.revenue) revenue,SUM(i.profit) profit,COUNT(DISTINCT o.order_id) orders FROM customers c JOIN sales_orders o ON c.customer_id=o.customer_id JOIN sales_order_items i ON o.order_id=i.order_id GROUP BY c.customer_id,c.customer_name,c.segment,c.city ORDER BY revenue DESC LIMIT 25;