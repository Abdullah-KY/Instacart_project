/* Question: On which day of the week do people order the most?
*/

SELECT
    order_dow,
    COUNT(order_id) AS order_count
FROM
    orders
GROUP BY
    order_dow
ORDER BY
    order_count DESC

/* Output Result Set: 
[
  {
    "order_dow": 0,
    "order_count": "600905"
  },
  {
    "order_dow": 1,
    "order_count": "587478"
  },
  {
    "order_dow": 2,
    "order_count": "467260"
  },
  {
    "order_dow": 5,
    "order_count": "453368"
  },
  {
    "order_dow": 6,
    "order_count": "448761"
  },
  {
    "order_dow": 3,
    "order_count": "436972"
  },
  {
    "order_dow": 4,
    "order_count": "426339"
  }
]*/