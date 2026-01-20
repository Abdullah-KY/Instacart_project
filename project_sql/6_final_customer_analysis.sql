/*
Question: Detailed customer purchase behavior combining aisle, product reorder %, 
    and peak ordering times.
Purpose: To analyze customer loyalty at the product and aisle level, 
    along with when they most frequently order.
Why it matters: This holistic insight supports optimizing inventory, 
    personalized offers, and efficient staffing based on real user patterns.
*/


WITH ranked_orders AS (
SELECT
    user_id,
    order_hour_of_day,
    COUNT(order_id) AS order_count,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY COUNT(order_id) DESC) AS rn
FROM orders 
GROUP BY
    user_id,
    order_hour_of_day
),
top_products AS (
    SELECT
    o.user_id,
    op.product_id,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN reordered=1 THEN 1
                ELSE 0
                END
        ) / COUNT(op.product_id), 2
    ) AS reorder_percentage
FROM orders o
INNER JOIN order_products_prior op ON o.order_id=op.order_id
GROUP BY
    o.user_id,
    op.product_id
),
product_info AS (
    SELECT
    p.product_id,
    p.product_name,
    a.aisle_name
FROM
    products p
    INNER JOIN aisles a ON p.aisle_id=a.aisle_id
)
SELECT
    ro.user_id,
    ro.order_hour_of_day AS top_order_hour,
    tp.product_id,
    pi.product_name,
    pi.aisle_name,
    tp.reorder_percentage,
    ro.order_count
FROM
    ranked_orders ro 
    INNER JOIN top_products tp ON ro.user_id=tp.user_id
    INNER JOIN product_info pi ON tp.product_id=pi.product_id
WHERE
    ro.rn=1
ORDER BY
    tp.reorder_percentage DESC, 
    ro.order_count DESC
LIMIT 25;


/* 
[
  {
    "user_id": 41356,
    "top_order_hour": 7,
    "product_id": 6583,
    "product_name": "Oraganic Lemon Elation Yerba Mate Drink",
    "aisle_name": "juice nectars",
    "reorder_percentage": "98.99",
    "order_count": "53"
  },
  {
    "user_id": 41356,
    "top_order_hour": 7,
    "product_id": 38652,
    "product_name": "Yerba Mate Orange Exuberance Tea",
    "aisle_name": "energy sports drinks",
    "reorder_percentage": "98.99",
    "order_count": "53"
  },
  {
    "user_id": 41356,
    "top_order_hour": 7,
    "product_id": 14366,
    "product_name": "Enlighten Mint Organic",
    "aisle_name": "tea",
    "reorder_percentage": "98.99",
    "order_count": "53"
  },
  {
    "user_id": 141736,
    "top_order_hour": 9,
    "product_id": 25133,
    "product_name": "Organic String Cheese",
    "aisle_name": "packaged cheese",
    "reorder_percentage": "98.99",
    "order_count": "52"
  },
  {
    "user_id": 17997,
    "top_order_hour": 17,
    "product_id": 4210,
    "product_name": "Whole Milk",
    "aisle_name": "milk",
    "reorder_percentage": "98.99",
    "order_count": "23"
  },
  {
    "user_id": 41356,
    "top_order_hour": 7,
    "product_id": 29671,
    "product_name": "Organic Bluephoria Yerba Mate",
    "aisle_name": "tea",
    "reorder_percentage": "98.98",
    "order_count": "53"
  },
  {
    "user_id": 103593,
    "top_order_hour": 10,
    "product_id": 28204,
    "product_name": "Organic Fuji Apple",
    "aisle_name": "fresh fruits",
    "reorder_percentage": "98.98",
    "order_count": "34"
  },
  {
    "user_id": 120897,
    "top_order_hour": 19,
    "product_id": 12013,
    "product_name": "Pinot Noir",
    "aisle_name": "red wines",
    "reorder_percentage": "98.98",
    "order_count": "17"
  },
  {
    "user_id": 84478,
    "top_order_hour": 10,
    "product_id": 31981,
    "product_name": "1% Low Fat Milk",
    "aisle_name": "milk",
    "reorder_percentage": "98.97",
    "order_count": "43"
  },
  {
    "user_id": 99707,
    "top_order_hour": 13,
    "product_id": 24852,
    "product_name": "Banana",
    "aisle_name": "fresh fruits",
    "reorder_percentage": "98.97",
    "order_count": "36"
  },
  {
    "user_id": 98085,
    "top_order_hour": 15,
    "product_id": 196,
    "product_name": "Soda",
    "aisle_name": "soft drinks",
    "reorder_percentage": "98.97",
    "order_count": "22"
  },
  {
    "user_id": 141736,
    "top_order_hour": 9,
    "product_id": 14947,
    "product_name": "Pure Sparkling Water",
    "aisle_name": "water seltzer sparkling water",
    "reorder_percentage": "98.96",
    "order_count": "52"
  },
  {
    "user_id": 99753,
    "top_order_hour": 8,
    "product_id": 27845,
    "product_name": "Organic Whole Milk",
    "aisle_name": "milk",
    "reorder_percentage": "98.96",
    "order_count": "33"
  },
  {
    "user_id": 69919,
    "top_order_hour": 15,
    "product_id": 24852,
    "product_name": "Banana",
    "aisle_name": "fresh fruits",
    "reorder_percentage": "98.96",
    "order_count": "18"
  },
  {
    "user_id": 178107,
    "top_order_hour": 9,
    "product_id": 24852,
    "product_name": "Banana",
    "aisle_name": "fresh fruits",
    "reorder_percentage": "98.95",
    "order_count": "50"
  },
  {
    "user_id": 103593,
    "top_order_hour": 10,
    "product_id": 4920,
    "product_name": "Seedless Red Grapes",
    "aisle_name": "packaged vegetables fruits",
    "reorder_percentage": "98.95",
    "order_count": "34"
  },
  {
    "user_id": 140440,
    "top_order_hour": 8,
    "product_id": 18926,
    "product_name": "Fat Free Strawberry Yogurt",
    "aisle_name": "yogurt",
    "reorder_percentage": "98.95",
    "order_count": "34"
  },
  {
    "user_id": 99753,
    "top_order_hour": 8,
    "product_id": 38689,
    "product_name": "Organic Reduced Fat Milk",
    "aisle_name": "milk",
    "reorder_percentage": "98.95",
    "order_count": "33"
  },
  {
    "user_id": 36335,
    "top_order_hour": 18,
    "product_id": 11784,
    "product_name": "Duck Eggs",
    "aisle_name": "eggs",
    "reorder_percentage": "98.95",
    "order_count": "26"
  },
  {
    "user_id": 76678,
    "top_order_hour": 17,
    "product_id": 19660,
    "product_name": "Spring Water",
    "aisle_name": "water seltzer sparkling water",
    "reorder_percentage": "98.95",
    "order_count": "17"
  },
  {
    "user_id": 123746,
    "top_order_hour": 17,
    "product_id": 1160,
    "product_name": "Pinot Grigio",
    "aisle_name": "white wines",
    "reorder_percentage": "98.95",
    "order_count": "14"
  },
  {
    "user_id": 75124,
    "top_order_hour": 9,
    "product_id": 40571,
    "product_name": "Total 2% Greek Strained Yogurt with Cherry 5.3 oz",
    "aisle_name": "yogurt",
    "reorder_percentage": "98.94",
    "order_count": "79"
  },
  {
    "user_id": 75124,
    "top_order_hour": 9,
    "product_id": 24954,
    "product_name": "Total 0% with Honey Nonfat Greek Strained Yogurt",
    "aisle_name": "yogurt",
    "reorder_percentage": "98.94",
    "order_count": "79"
  },
  {
    "user_id": 75124,
    "top_order_hour": 9,
    "product_id": 11925,
    "product_name": "Total 2% with Raspberry Pomegranate Lowfat Greek Strained Yogurt",
    "aisle_name": "yogurt",
    "reorder_percentage": "98.94",
    "order_count": "79"
  },
  {
    "user_id": 75124,
    "top_order_hour": 9,
    "product_id": 8061,
    "product_name": "Pineapple Yogurt 2%",
    "aisle_name": "yogurt",
    "reorder_percentage": "98.94",
    "order_count": "79"
  }
] */