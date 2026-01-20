import pandas as pd
import matplotlib.pyplot as plt
import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="instacart",
    user="postgres",
    password="1q2w3e"   
)

query="""
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
"""
df=pd.read_sql(query,conn)

conn.close()

plt.figure(figsize(12,6))
plt.bar(df['product_name'],df['reorder_rate'],color='skyblue')

plt.title("Top 10 Products With Highest Reorder Rates")
plt.xlabel("Product Name")
plt.ylabel("Reorder Rate")
plt.xticks(rotation=45, ha='right')

plt.tight_layout()
plt.show()