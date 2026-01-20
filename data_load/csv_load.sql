-- Load aisles.csv
COPY aisles(aisle_id, aisle_name)
FROM 'D:/CODING/SQL/Instacart_project/csv_files/aisles.csv'
DELIMITER ','
CSV HEADER;

-- Load departments.csv
COPY departments(department_id, department_name)
FROM 'D:/CODING/SQL/Instacart_project/csv_files/departments.csv'
DELIMITER ','
CSV HEADER;

-- Load products.csv
COPY products(product_id, product_name, aisle_id, department_id)
FROM 'D:/CODING/SQL/Instacart_project/csv_files/products.csv'
DELIMITER ','
CSV HEADER;

-- Load orders.csv
COPY orders(order_id, user_id, eval_set, order_number, order_dow, order_hour_of_day, days_since_prior_order)
FROM 'D:/CODING/SQL/Instacart_project/csv_files/orders.csv'
DELIMITER ','
CSV HEADER;

-- Load order_products__prior.csv
COPY order_products_prior(order_id, product_id, add_to_cart_order, reordered)
FROM 'D:/CODING/SQL/Instacart_project/csv_files/order_products__prior.csv'
DELIMITER ','
CSV HEADER;

-- Load order_products__train.csv
COPY order_products_train(order_id, product_id, add_to_cart_order, reordered)
FROM 'D:/CODING/SQL/Instacart_project/csv_files/order_products__train.csv'
DELIMITER ','
CSV HEADER;

