import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from sqlalchemy import create_engine
import textwrap

engine = create_engine("postgresql+psycopg2://postgres:1q2w3e@localhost:5432/instacart")

query="""
SELECT
    a.aisle_name,
    COUNT(op.product_id) AS total_orders
FROM order_products_prior op
INNER JOIN products p ON p.product_id=op.product_id
INNER JOIN aisles a ON p.aisle_id = a.aisle_id
GROUP BY 
    a.aisle_name
ORDER BY
    total_orders DESC
LIMIT 10;
"""
df=pd.read_sql(query,engine)


plt.figure(figsize=(12,6))
plt.bar(df['aisle_name'], df['total_orders'], color='lightpink')

plt.title("Top 10 Most Popular Products", fontsize=20, color='lightblue', pad=20)
plt.xlabel("Aisle Names", fontsize= 15, color='lightblue')
plt.ylabel("Total Orders", fontsize= 15, color='lightblue', labelpad=20)

wrapped_labels=[ "\n".join(textwrap.wrap(label,12)) for label in df['aisle_name'] ]

plt.xticks(ticks=range(len(wrapped_labels)), labels=wrapped_labels, fontsize=10, ha='center', color='white')
plt.yticks(color='white')

plt.gcf().set_facecolor('black')
plt.gca().set_facecolor('black')

ax=plt.gca()

ax.spines['top'].set_visible(True)
ax.spines['right'].set_visible(True)
ax.spines['left'].set_visible(True)
ax.spines['bottom'].set_visible(True)

for spine in ax.spines.values():
    spine.set_edgecolor('white')
    spine.set_linewidth(2)

for i,rate in enumerate(df['total_orders']):
    plt.text(i, rate + rate*0.01,f"{rate:,}", ha='center', fontsize=9, color='lightpink')

ax.yaxis.set_major_formatter(FuncFormatter(lambda x, _: f'{int(x):,}'))
plt.tight_layout()
plt.show()
