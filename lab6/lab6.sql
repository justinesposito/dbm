-- Justin Esposito Lab 6
--Q1,Q2? couldn't find an effective way to show values tied for being max

select distinct customers.name, customers.city
from customers, products
where products.city = customers.city and
 products.city in
(
select city
from products
group by city
order by count(city) desc
limit 1
)


--Q3
select *
from products
where priceUSD >(select avg(priceUSD)
		from products)

--Q4
select distinct customers.name, orders.pid, orders.dollars
from customers, orders, products
where customers.cid = orders.cid
order by orders.dollars desc

--Q5

--Q6
select customers.name, products.name, agents.name
from customers, orders, products, agents
where customers.cid = orders.cid and
agents.aid = orders.aid and
products.pid = orders.pid and
agents.city = 'New York'

--Q7