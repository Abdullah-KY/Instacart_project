/*Question: What are the top 10 most frequently ordered products?
- Why? This will help practice joining two related tables and using 
    GROUP BY and COUNT() — essential for aggregation tasks.
- Join order_products__prior with products using product_id.
- Count how many times each product appears and sort it in descending order.*/


SELECT
    p.product_name,
    COUNT(order_id) AS order_count
FROM order_products_prior AS o
INNER JOIN products AS p ON o.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    order_count DESC
LIMIT 10;


/*
Output Result Set:

[
  {
    "product_name": "Banana",
    "order_no": "472565"
  },
  {
    "product_name": "Bag of Organic Bananas",
    "order_no": "379450"
  },
  {
    "product_name": "Organic Strawberries",
    "order_no": "264683"
  },
  {
    "product_name": "Organic Baby Spinach",
    "order_no": "241921"
  },
  {
    "product_name": "Organic Hass Avocado",
    "order_no": "213584"
  },
  {
    "product_name": "Organic Avocado",
    "order_no": "176815"
  },
  {
    "product_name": "Large Lemon",
    "order_no": "152657"
  },
  {
    "product_name": "Strawberries",
    "order_no": "142951"
  },
  {
    "product_name": "Limes",
    "order_no": "140627"
  },
  {
    "product_name": "Organic Whole Milk",
    "order_no": "137905"
  }
]
*/