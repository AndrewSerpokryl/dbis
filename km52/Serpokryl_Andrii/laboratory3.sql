-- LABORATORY WORK 3
-- BY Serpokryl_Andrii
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/



declare 
    amount int := 10;
    real_amount int;
    cust_name_first char(50);
    cust_id_first char(10) := '1000000001';
    
begin
    select count(*) into real_amount
    from customers;


    select customers.cust_name into cust_name_first
    from customers
    where customers.cust_id = cust_id_first;
    
    amount := amount - real_amount;
    
    for i in 1..amount loop
    insert into customers (cust_id, cust_name)
    values('test'||i, cust_name_first);
    end loop;
end;

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/


/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

create view all_in_all as
    select (*) 
    from 
    customers join orders on customer.cust_id = orders.cust_id 
    join orderitems on orders.order_num = orderitems.order_num join
    products on orderitems.prod_id = products.prod_id join
    vendors on products.vend_id = vendors.vend_id;
    
select sum(amount) from (
    select count(prod_id) as amount, vend_id
    from all_in_all
    where vend_country = 'Germany'
    group by vend_id);
    
select cust_id, sum(quantity)
from all_in_all
group by cust_id;
