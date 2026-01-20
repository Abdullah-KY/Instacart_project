/* Question: Total orders across each aisles 
- What the query does:  
  Aggregates total product orders across all aisles and ranks them 
  by total order count.
- What it focuses on:  
  Highlights which aisles have the most frequently purchased products, 
  giving insight into aisle-level demand.
- Why this matters:  
  Aisles with high product order volume indicate popular categories, 
  helping guide inventory prioritization and in-store layout planning.
*/

SELECT
    a.aisle_name,
    COUNT(op.product_id) AS total_orders
FROM order_products_prior op
INNER JOIN products p ON p.product_id=op.product_id
INNER JOIN aisles a ON p.aisle_id = a.aisle_id
GROUP BY 
    a.aisle_name
ORDER BY
    total_orders DESC
LIMIT 10;

/* Output result set: 
[
  {
    "aisle_name": "fresh fruits",
    "total_orders": "3642188"
  },
  {
    "aisle_name": "fresh vegetables",
    "total_orders": "3418021"
  },
  {
    "aisle_name": "packaged vegetables fruits",
    "total_orders": "1765313"
  },
  {
    "aisle_name": "yogurt",
    "total_orders": "1452343"
  },
  {
    "aisle_name": "packaged cheese",
    "total_orders": "979763"
  },
  {
    "aisle_name": "milk",
    "total_orders": "891015"
  },
  {
    "aisle_name": "water seltzer sparkling water",
    "total_orders": "841533"
  },
  {
    "aisle_name": "chips pretzels",
    "total_orders": "722470"
  },
  {
    "aisle_name": "soy lactosefree",
    "total_orders": "638253"
  },
  {
    "aisle_name": "bread",
    "total_orders": "584834"
  }
] */