/* Question: How many total orders has each user made?
- Why? Helps to work directly with user-level analysis using basic 
    grouping, useful for customer behavior insights. */

SELECT
    user_id,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY
    user_id
ORDER BY
    order_count DESC
