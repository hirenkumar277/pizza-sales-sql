-- intermediate queries
-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category, sum(order_details.quantity) 
as quantity from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- 2.Determine the distribution of orders by hour of the day.
select hour(order_time) as hour_time, count(order_id) as order_count 
from orders group by hour_time order by hour_time;

-- 3.join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) as count from pizza_types group by category order by count desc;

-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),0) as avg_pizzas_ordered_per_day from (select orders.order_date as order_date, sum(order_details.quantity) as quantity 
from orders join order_details on orders.order_id = order_details.order_id 
group by order_date order by order_date) as order_quantity;

-- 5.Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name as name,sum(pizzas.price*order_details.quantity) as revenue from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id join order_details on pizzas.pizza_id = order_details.pizza_id 
group by name order by revenue desc limit 3;