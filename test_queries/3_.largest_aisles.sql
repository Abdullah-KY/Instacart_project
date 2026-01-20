/* Question: Which 5 aisles have the largest variety of unique products?
- Join products and aisles using aisle_id.
- Group by aisle and count distinct product_id. 
 */

SELECT
    aisle_name,
    COUNT (DISTINCT product_id) AS product_count
FROM aisles a
LEFT JOIN products p ON a.aisle_id = p.aisle_id
WHERE
    aisle_name != 'missing'
GROUP BY
    aisle_name
ORDER BY
    product_count DESC
LIMIT 5;


/* Output result set: 
[
  {
    "aisle_name": "candy chocolate",
    "product_count": "1246"
  },
  {
    "aisle_name": "ice cream ice",
    "product_count": "1091"
  },
  {
    "aisle_name": "vitamins supplements",
    "product_count": "1038"
  },
  {
    "aisle_name": "yogurt",
    "product_count": "1026"
  },
  {
    "aisle_name": "chips pretzels",
    "product_count": "989"
  }
]
*/