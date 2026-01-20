/*
Question: Which aisle contains the highest number of unique products?
- What the query does:  
  Counts the number of unique products in each aisle and returns the aisle 
  with the highest variety.
- What it focuses on:  
  Examines product diversity at the aisle level to understand which 
  sections of the store offer the widest selection.
- Why this matters:  
  This insight helps identify key aisles that contribute heavily to the catalog size — useful for planning layout, 
  stocking strategies, or identifying potential overcrowding in product categories.
*/


SELECT
    a.aisle_name,
    COUNT(DISTINCT p.product_id) AS prod_count
FROM products p
INNER JOIN aisles a ON p.aisle_id = a.aisle_id
WHERE
    aisle_name != 'missing'
GROUP BY 
    a.aisle_name
ORDER BY
    prod_count DESC
LIMIT 10;


/* Output result set:
[
  {
    "aisle_name": "candy chocolate",
    "prod_count": "1246"
  },
  {
    "aisle_name": "ice cream ice",
    "prod_count": "1091"
  },
  {
    "aisle_name": "vitamins supplements",
    "prod_count": "1038"
  },
  {
    "aisle_name": "yogurt",
    "prod_count": "1026"
  },
  {
    "aisle_name": "chips pretzels",
    "prod_count": "989"
  },
  {
    "aisle_name": "tea",
    "prod_count": "894"
  },
  {
    "aisle_name": "packaged cheese",
    "prod_count": "891"
  },
  {
    "aisle_name": "frozen meals",
    "prod_count": "880"
  },
  {
    "aisle_name": "cookies cakes",
    "prod_count": "874"
  },
  {
    "aisle_name": "energy granola bars",
    "prod_count": "832"
  }
] */