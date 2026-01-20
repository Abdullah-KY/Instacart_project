/*Question: What is the reorder rate for each product?
- Use order_products__prior and join with products.
- Average the reordered column after casting it to float or numeric.*/

SELECT
    p.product_name,
    AVG(o.reordered::FLOAT) AS reorder_rate

FROM
    order_products_prior o 
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY
    reorder_rate DESC
LIMIT 10;