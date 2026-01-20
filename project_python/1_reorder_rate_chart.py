import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
import textwrap

engine = create_engine("postgresql+psycopg2://postgres:1q2w3e@localhost:5432/instacart")

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
df=pd.read_sql(query,engine)


plt.figure(figsize=(14,7))
plt.bar(df['product_name'], df['reorder_rate'], color='skyblue')

ax = plt.gca()

plt.title("Top 10 Products With Highest Reorder Rates", fontsize=20, color='#FFD700', pad=20)
plt.xlabel("Product Names", fontsize=15, color='#FFD700')
plt.ylabel("Reorder Rate", fontsize=15, color='#FFD700', labelpad=20)

wrapped_labels = ["\n".join(textwrap.wrap(label, 12)) for label in df['product_name']]

plt.yticks(color='white')
plt.xticks(ticks=range(len(wrapped_labels)), labels=wrapped_labels, fontsize=10, color='white')

plt.ylim(0.85, 1.0)

plt.gcf().set_facecolor('black')
plt.gca().set_facecolor('black')

for spine in ax.spines.values():
    spine.set_edgecolor('white')
    spine.set_linewidth(2)

for i, rate in enumerate(df['reorder_rate']):
    plt.text(i, rate + 0.005, f"{rate:.2f}", ha='center', color='white')

plt.tight_layout()
plt.show()

