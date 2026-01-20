import pandas as pd 
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
import matplotlib.ticker as mtick

engine= create_engine('postgresql+psycopg2://postgres:1q2w3e@localhost:5432/instacart')

query = """ SELECT
    order_hour_of_day,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY
    order_hour_of_day
ORDER BY
    order_count DESC """
    
df = pd.read_sql_query(query, engine)
df = df.sort_values("order_hour_of_day")

plt.figure(figsize=(14,7))
plt.plot(df['order_hour_of_day'], df['order_count'], marker='o', linewidth=2)


plt.title('Order Hour of Day (Peak Hours)', fontsize=20, color='yellow', pad=20)
plt.xlabel('Hour of Day (0-23)', fontsize=15, color='yellow')
plt.ylabel('Number of Orders', fontsize=15, color='yellow', labelpad=20)

ax=plt.gca()
for spine in ax.spines.values():
    spine.set_edgecolor('white')
    spine.set_linewidth(2)

ax.yaxis.set_major_formatter(mtick.FuncFormatter(lambda x, p: format(int(x), ',')))
ax.grid(True, alpha=0.15)

plt.gcf().set_facecolor('black')
plt.gca().set_facecolor('black')
plt.yticks(color='white')
plt.xticks(color='white')


for x, y in zip(df['order_hour_of_day'], df['order_count']):
    plt.text(x, y + 4500, f"{y:,}", color='white', ha='center', fontsize=8)

plt.tight_layout()
plt.show()
