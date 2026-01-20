/* Question: Orders by hour of day (peak hours)
- What the query does:  
    Counts how many orders are placed during each hour of the day and ranks them 
    in descending order.
- What it focuses on:  
    Analyzes customer ordering behavior by hour (0–23) to find peak activity times.
- Why this matters:  
    Understanding hourly trends helps with optimizing app/server loads, 
    staffing, delivery windows, and targeted marketing during high-traffic periods.
*/

SELECT
    order_hour_of_day,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY
    order_hour_of_day
ORDER BY
    order_count DESC
