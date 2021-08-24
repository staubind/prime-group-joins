-- Get all customers and their addresses
SELECT * FROM "customers"
JOIN "addresses"
	ON "customers"."id" = "addresses"."customer_id";

-- Get all orders and their line items (orders, quantity and product)
SELECT "orders"."id" as "ordersID", "quantity", "description" FROM "orders"
JOIN "line_items"
	ON "orders"."id" = "line_items"."order_id"
JOIN "products"
	ON "line_items"."product_id" = "products"."id";

-- Which warehouses have cheetos?
SELECT "warehouse" FROM "products"
JOIN "warehouse_product"
	ON "products"."id" = "warehouse_product"."product_id"
JOIN "warehouse"
	ON "warehouse_product"."warehouse_id" = "warehouse"."id"
WHERE "products"."id" = 5;

-- Which warehouses have diet pepsi?
SELECT "warehouse" FROM "products"
JOIN "warehouse_product"
	ON "products"."id" = "warehouse_product"."product_id"
JOIN "warehouse" 
	ON "warehouse_product"."warehouse_id" = "warehouse"."id"
WHERE "products"."description" = 'diet pepsi';

-- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "first_name", "last_name", count(*) FROM "customers"
JOIN "addresses"
	ON "customers"."id" = "addresses"."customer_id"
JOIN "orders"
	ON "addresses"."id" = "orders"."address_id"
GROUP BY "first_name", "last_name";


-- How many customers do we have?
SELECT count(*) FROM "customers";

-- How many products do we carry?
SELECT count(*) FROM "products";

-- What is the total available on-hand quantity of diet pepsi?
SELECT sum("on_hand") as "totalDietPepsi" FROM "products"
JOIN "warehouse_product"
	ON "products"."id" = "warehouse_product"."product_id"
JOIN "warehouse"
	ON "warehouse_product"."warehouse_id" = "warehouse"."id"
WHERE "products"."description" = 'diet pepsi';

----------------- STRETCH -----------------

-- How much was the total cost for each order?
SELECT 
	"orders"."id", 
	sum("unit_price"*"quantity") as "totalCost"
FROM "orders"
JOIN "line_items"
	ON "orders"."id" = "line_items"."order_id"
JOIN "products"
	ON "line_items"."product_id" = "products"."id"
GROUP BY "orders"."id"
ORDER BY "totalCost" DESC;

-- How much has each customer spent in total?
SELECT "first_name", "last_name", sum("products"."unit_price" * "line_items"."quantity") as "crossOrderTotalPrice" FROM "customers"
JOIN "addresses"
	ON "customers"."id" = "addresses"."customer_id"
JOIN "orders"
	ON "addresses"."id" = "orders"."address_id"
JOIN "line_items"
	ON "orders"."id" = "line_items"."order_id"
JOIN "products"
	ON "products"."id" = "line_items"."product_id"
GROUP BY "customers"."id"
ORDER BY "crossOrderTotalPrice" DESC;

