/*
Question: What are the top 10 products with the highest reorder rates?
- What the query does:  
  Identifies the top 10 most reordered products by calculating the average 
  reorder rate for each item.
- What it focuses on:  
  Analyzes product-level customer behavior using prior orders to surface 
  items that users frequently buy again.
- Why this matters:  
  Understanding which products drive high repeat purchases helps
  businesses recognize customer loyalty patterns and can guide restocking, 
  promotions, or personalized product recommendations.
*/


SELECT
    p.product_name,
    AVG(o.reordered::FLOAT) AS reorder_rate
FROM order_products_prior o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    reorder_rate DESC
LIMIT 10;

/* 
Output result set:
[
  {
    "product_name": "Raw Veggie Wrappers",
    "reorder_rate": 0.9411764705882353
  },
  {
    "product_name": "Serenity Ultimate Extrema Overnight Pads",
    "reorder_rate": 0.9310344827586207
  },
  {
    "product_name": "Orange Energy Shots",
    "reorder_rate": 0.9230769230769231
  },
  {
    "product_name": "Chocolate Love Bar",
    "reorder_rate": 0.9207920792079208
  },
  {
    "product_name": "Soy Powder Infant Formula",
    "reorder_rate": 0.9142857142857143
  },
  {
    "product_name": "Simply Sleep Nighttime Sleep Aid",
    "reorder_rate": 0.9111111111111111
  },
  {
    "product_name": "Energy Shot, Grape Flavor",
    "reorder_rate": 0.9090909090909091
  },
  {
    "product_name": "Russian River Valley Reserve Pinot Noir",
    "reorder_rate": 0.9
  },
  {
    "product_name": "Maca Buttercups",
    "reorder_rate": 0.9
  },
  {
    "product_name": "Sparking Water",
    "reorder_rate": 0.9
  }
] */