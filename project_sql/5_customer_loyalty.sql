/*
Question: Find customers with the highest reorder rates and their top product.
Purpose: Identify loyal customers and their favorite products.
Why it matters: Helps tailor marketing and inventory strategies based on customer behavior.
*/


WITH reorder_stats AS (
  SELECT
    o.user_id,
    SUM(CASE WHEN op.reordered = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(op.product_id) AS reorder_rate_raw,
    COUNT(op.product_id) AS total_items_ordered
  FROM orders o
  JOIN order_products_prior op ON o.order_id = op.order_id
  GROUP BY o.user_id
),
top_products AS (
  SELECT user_id, product_id, prod_count
  FROM (
    SELECT
      o.user_id,
      op.product_id,
      COUNT(*) AS prod_count,
      ROW_NUMBER() OVER (PARTITION BY o.user_id ORDER BY COUNT(*) DESC) AS rn
    FROM orders o
    JOIN order_products_prior op ON o.order_id = op.order_id
    GROUP BY o.user_id, op.product_id
  ) ranked
  WHERE rn = 1
)
SELECT
  rs.user_id,
  ROUND(100.0 * rs.reorder_rate_raw, 2) AS reorder_percentage,
  rs.total_items_ordered,
  tp.product_id AS most_ordered_product_id,
  p.product_name,
  tp.prod_count AS times_user_ordered_that_product
FROM reorder_stats rs
JOIN top_products tp ON rs.user_id = tp.user_id
LEFT JOIN products p ON tp.product_id = p.product_id
ORDER BY rs.reorder_rate_raw DESC, tp.prod_count DESC
LIMIT 100;



/* 
Output result set:
[
  {
    "user_id": 99753,
    "reorder_percentage": "98.95",
    "most_ordered_product": 46614
  },
  {
    "user_id": 82414,
    "reorder_percentage": "98.13",
    "most_ordered_product": 808
  },
  {
    "user_id": 17997,
    "reorder_percentage": "97.93",
    "most_ordered_product": 23352
  },
  {
    "user_id": 5588,
    "reorder_percentage": "97.89",
    "most_ordered_product": 7948
  },
  {
    "user_id": 3269,
    "reorder_percentage": "97.82",
    "most_ordered_product": 7173
  },
  {
    "user_id": 12025,
    "reorder_percentage": "97.78",
    "most_ordered_product": 3447
  },
  {
    "user_id": 91160,
    "reorder_percentage": "97.64",
    "most_ordered_product": 44326
  },
  {
    "user_id": 184517,
    "reorder_percentage": "97.62",
    "most_ordered_product": 45841
  },
  {
    "user_id": 26489,
    "reorder_percentage": "97.35",
    "most_ordered_product": 18583
  },
  {
    "user_id": 37075,
    "reorder_percentage": "97.22",
    "most_ordered_product": 23012
  },
  {
    "user_id": 198506,
    "reorder_percentage": "96.81",
    "most_ordered_product": 21390
  },
  {
    "user_id": 165398,
    "reorder_percentage": "96.72",
    "most_ordered_product": 19139
  },
  {
    "user_id": 45671,
    "reorder_percentage": "96.61",
    "most_ordered_product": 19069
  },
  {
    "user_id": 100935,
    "reorder_percentage": "96.57",
    "most_ordered_product": 15064
  },
  {
    "user_id": 140753,
    "reorder_percentage": "96.56",
    "most_ordered_product": 45018
  },
  {
    "user_id": 75124,
    "reorder_percentage": "96.55",
    "most_ordered_product": 29139
  },
  {
    "user_id": 103593,
    "reorder_percentage": "96.54",
    "most_ordered_product": 28261
  },
  {
    "user_id": 86344,
    "reorder_percentage": "96.46",
    "most_ordered_product": 6111
  },
  {
    "user_id": 41211,
    "reorder_percentage": "96.40",
    "most_ordered_product": 6750
  },
  {
    "user_id": 154977,
    "reorder_percentage": "96.36",
    "most_ordered_product": 15858
  },
  {
    "user_id": 39176,
    "reorder_percentage": "96.30",
    "most_ordered_product": 4175
  },
  {
    "user_id": 145481,
    "reorder_percentage": "96.24",
    "most_ordered_product": 2515
  },
  {
    "user_id": 203143,
    "reorder_percentage": "96.23",
    "most_ordered_product": 3269
  },
  {
    "user_id": 100698,
    "reorder_percentage": "96.23",
    "most_ordered_product": 19162
  },
  {
    "user_id": 65180,
    "reorder_percentage": "96.17",
    "most_ordered_product": 26478
  },
  {
    "user_id": 106143,
    "reorder_percentage": "96.15",
    "most_ordered_product": 930
  },
  {
    "user_id": 167391,
    "reorder_percentage": "96.15",
    "most_ordered_product": 20246
  },
  {
    "user_id": 166786,
    "reorder_percentage": "96.10",
    "most_ordered_product": 39414
  },
  {
    "user_id": 106510,
    "reorder_percentage": "96.08",
    "most_ordered_product": 43751
  },
  {
    "user_id": 81678,
    "reorder_percentage": "96.08",
    "most_ordered_product": 3786
  },
  {
    "user_id": 66087,
    "reorder_percentage": "96.00",
    "most_ordered_product": 28911
  },
  {
    "user_id": 142936,
    "reorder_percentage": "95.95",
    "most_ordered_product": 39958
  },
  {
    "user_id": 141736,
    "reorder_percentage": "95.95",
    "most_ordered_product": 25138
  },
  {
    "user_id": 189546,
    "reorder_percentage": "95.91",
    "most_ordered_product": 14052
  },
  {
    "user_id": 204801,
    "reorder_percentage": "95.88",
    "most_ordered_product": 44271
  },
  {
    "user_id": 140440,
    "reorder_percentage": "95.88",
    "most_ordered_product": 31015
  },
  {
    "user_id": 55331,
    "reorder_percentage": "95.88",
    "most_ordered_product": 47826
  },
  {
    "user_id": 163388,
    "reorder_percentage": "95.65",
    "most_ordered_product": 37241
  },
  {
    "user_id": 179667,
    "reorder_percentage": "95.63",
    "most_ordered_product": 11669
  },
  {
    "user_id": 180621,
    "reorder_percentage": "95.59",
    "most_ordered_product": 10027
  },
  {
    "user_id": 16397,
    "reorder_percentage": "95.56",
    "most_ordered_product": 15454
  },
  {
    "user_id": 32971,
    "reorder_percentage": "95.55",
    "most_ordered_product": 21535
  },
  {
    "user_id": 97865,
    "reorder_percentage": "95.52",
    "most_ordered_product": 8861
  },
  {
    "user_id": 122725,
    "reorder_percentage": "95.51",
    "most_ordered_product": 39649
  },
  {
    "user_id": 148573,
    "reorder_percentage": "95.45",
    "most_ordered_product": 751
  },
  {
    "user_id": 14221,
    "reorder_percentage": "95.45",
    "most_ordered_product": 1795
  },
  {
    "user_id": 64259,
    "reorder_percentage": "95.45",
    "most_ordered_product": 19232
  },
  {
    "user_id": 111365,
    "reorder_percentage": "95.35",
    "most_ordered_product": 8843
  },
  {
    "user_id": 103507,
    "reorder_percentage": "95.28",
    "most_ordered_product": 13535
  },
  {
    "user_id": 162424,
    "reorder_percentage": "95.24",
    "most_ordered_product": 4744
  },
  {
    "user_id": 4433,
    "reorder_percentage": "95.24",
    "most_ordered_product": 38360
  },
  {
    "user_id": 184228,
    "reorder_percentage": "95.24",
    "most_ordered_product": 29706
  },
  {
    "user_id": 136558,
    "reorder_percentage": "95.22",
    "most_ordered_product": 32771
  },
  {
    "user_id": 171469,
    "reorder_percentage": "95.19",
    "most_ordered_product": 41509
  },
  {
    "user_id": 53543,
    "reorder_percentage": "95.15",
    "most_ordered_product": 24050
  },
  {
    "user_id": 159711,
    "reorder_percentage": "95.05",
    "most_ordered_product": 12859
  },
  {
    "user_id": 35214,
    "reorder_percentage": "95.01",
    "most_ordered_product": 41615
  },
  {
    "user_id": 164779,
    "reorder_percentage": "95.00",
    "most_ordered_product": 16903
  },
  {
    "user_id": 15182,
    "reorder_percentage": "94.98",
    "most_ordered_product": 3035
  },
  {
    "user_id": 153387,
    "reorder_percentage": "94.97",
    "most_ordered_product": 33216
  },
  {
    "user_id": 43952,
    "reorder_percentage": "94.97",
    "most_ordered_product": 38075
  },
  {
    "user_id": 190455,
    "reorder_percentage": "94.92",
    "most_ordered_product": 30378
  },
  {
    "user_id": 196224,
    "reorder_percentage": "94.85",
    "most_ordered_product": 12606
  },
  {
    "user_id": 91820,
    "reorder_percentage": "94.82",
    "most_ordered_product": 36161
  },
  {
    "user_id": 153455,
    "reorder_percentage": "94.79",
    "most_ordered_product": 18434
  },
  {
    "user_id": 172689,
    "reorder_percentage": "94.77",
    "most_ordered_product": 46004
  },
  {
    "user_id": 185406,
    "reorder_percentage": "94.77",
    "most_ordered_product": 3138
  },
  {
    "user_id": 71975,
    "reorder_percentage": "94.74",
    "most_ordered_product": 11818
  },
  {
    "user_id": 41413,
    "reorder_percentage": "94.64",
    "most_ordered_product": 41486
  },
  {
    "user_id": 38492,
    "reorder_percentage": "94.53",
    "most_ordered_product": 36029
  },
  {
    "user_id": 205147,
    "reorder_percentage": "94.46",
    "most_ordered_product": 2674
  },
  {
    "user_id": 159424,
    "reorder_percentage": "94.44",
    "most_ordered_product": 6489
  },
  {
    "user_id": 118685,
    "reorder_percentage": "94.43",
    "most_ordered_product": 35530
  },
  {
    "user_id": 154246,
    "reorder_percentage": "94.39",
    "most_ordered_product": 44211
  },
  {
    "user_id": 8359,
    "reorder_percentage": "94.34",
    "most_ordered_product": 1850
  },
  {
    "user_id": 18085,
    "reorder_percentage": "94.33",
    "most_ordered_product": 38203
  },
  {
    "user_id": 199641,
    "reorder_percentage": "94.25",
    "most_ordered_product": 28794
  },
  {
    "user_id": 30091,
    "reorder_percentage": "94.23",
    "most_ordered_product": 4189
  },
  {
    "user_id": 200531,
    "reorder_percentage": "94.20",
    "most_ordered_product": 7613
  },
  {
    "user_id": 86827,
    "reorder_percentage": "94.18",
    "most_ordered_product": 23637
  },
  {
    "user_id": 53748,
    "reorder_percentage": "94.17",
    "most_ordered_product": 33480
  },
  {
    "user_id": 31606,
    "reorder_percentage": "94.15",
    "most_ordered_product": 13331
  },
  {
    "user_id": 24810,
    "reorder_percentage": "94.12",
    "most_ordered_product": 31545
  },
  {
    "user_id": 158780,
    "reorder_percentage": "94.12",
    "most_ordered_product": 44173
  },
  {
    "user_id": 13092,
    "reorder_percentage": "94.09",
    "most_ordered_product": 42910
  },
  {
    "user_id": 12486,
    "reorder_percentage": "94.07",
    "most_ordered_product": 24826
  },
  {
    "user_id": 125863,
    "reorder_percentage": "94.04",
    "most_ordered_product": 3310
  },
  {
    "user_id": 41356,
    "reorder_percentage": "94.02",
    "most_ordered_product": 12166
  },
  {
    "user_id": 185562,
    "reorder_percentage": "93.94",
    "most_ordered_product": 12272
  },
  {
    "user_id": 184183,
    "reorder_percentage": "93.94",
    "most_ordered_product": 21067
  },
  {
    "user_id": 117186,
    "reorder_percentage": "93.91",
    "most_ordered_product": 41162
  },
  {
    "user_id": 178107,
    "reorder_percentage": "93.89",
    "most_ordered_product": 18212
  },
  {
    "user_id": 106755,
    "reorder_percentage": "93.82",
    "most_ordered_product": 29586
  },
  {
    "user_id": 68032,
    "reorder_percentage": "93.78",
    "most_ordered_product": 21221
  },
  {
    "user_id": 147197,
    "reorder_percentage": "93.76",
    "most_ordered_product": 10120
  },
  {
    "user_id": 143302,
    "reorder_percentage": "93.75",
    "most_ordered_product": 30240
  },
  {
    "user_id": 187628,
    "reorder_percentage": "93.75",
    "most_ordered_product": 17010
  },
  {
    "user_id": 48345,
    "reorder_percentage": "93.75",
    "most_ordered_product": 29738
  },
  {
    "user_id": 75805,
    "reorder_percentage": "93.69",
    "most_ordered_product": 2567
  },
  {
    "user_id": 79387,
    "reorder_percentage": "93.69",
    "most_ordered_product": 20585
  }
] /*