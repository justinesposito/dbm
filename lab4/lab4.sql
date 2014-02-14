
--Justin Esposito - Lab 4

--Q1
select city
from agents
where aid in (select aid
		from orders
		where cid in (select cid
				from customers
				where name = 'Basics'
				)
		)

--Q2
select pid
from orders
where aid in (select aid
		from customers
		where cid in ( select cid
				from customers
				where city = 'Kyoto'
		)		)

--Q3
select cid, name
from customers
where cid in (select cid
		from orders
		where aid != 'a03'
		)

--Q4
select cid, name
from customers
where cid in (select cid
		from orders
		where pid in ('p01', 'p07')
		group by cid
		having count(pid) > 1
		)
		

--Q5
select pid
from orders
where cid in (select cid
		from orders
		where aid = 'a03'
		)

--Q6
select name, discount
from customers
where cid in (select cid
		from orders
		where aid in ( select aid
				from agents
				where city = 'Dallas' or city = 'Duluth'
				)
		)

--Q7
select *
from customers
where city != 'Kyoto'
and city != 'Dallas'
and discount in (select discount
			from customers
			where city in ('Dallas', 'Kyoto')
			)
