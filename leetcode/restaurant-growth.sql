# Write your MySQL query statement below
SELECT visited_on,
(
    select sum(amount)
    from customer
    where visited_on between date_sub(c.visited_on , interval 6 day)
    and c.visited_on
) as amount , 
round((
    select sum(amount)/7
    from customer
    where visited_on between date_sub(c.visited_on , interval 6 day)
    and c.visited_on
),2) as average_amount
FROM customer c
where c.visited_on >= (
    SELECT date_add(min(visited_on), interval 6 day)
    FROM customer
)
group by visited_on
order by visited_on