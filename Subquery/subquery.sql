use classicmodels;
/*1. Find the names of customers who have placed an order.
   - Write a sub-query to get the customer numbers of customers who have placed an order.
   - Use the sub-query to get the names of these customers.*/
   
SELECT 
    customerNumber, customerName
FROM
    customers
WHERE
    customerNumber IN (SELECT DISTINCT
            (customerNumber)
        FROM
            orders);

/*2. List the product codes and names of products that have never been ordered.
   - Write a sub-query to get the product codes of products that have been ordered.
   - Use the sub-query to get the names of products that have never been ordered.*/
SELECT 
    productCode, productName
FROM
    products
WHERE
    productCode NOT IN (SELECT DISTINCT
            (productCode)
        FROM
            orderdetails);
/*3. Retrieve the office codes of offices that have employees who do not report to anyone.
   - Write a sub-query to get the employee numbers of employees who do not report to anyone.
   - Use the sub-query to get the office codes of these employees.*/
select officeCode from employees where reportsTo is null;
-- solve this question again
/*4. Find the order numbers of orders that have at least one product with a price each greater than the MSRP of the product.
   - Write a sub-query to get the MSRP of each product.
   - Use the sub-query to get the order numbers of orders meeting the condition.*/
   SELECT orderNumber,priceEach
   FROM orderdetails
   WHERE priceEach > (SELECT MSRP FROM products WHERE products.productCode = orderdetails.productCode);

/*5. Find the customer numbers of customers who have never made a payment.
   - Write a sub-query to get the customer numbers of customers who have made a payment.
   - Use the sub-query to find the customer numbers of customers who have never made a payment.*/
SELECT 
    *
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            payments);
            
/*6. Retrieve the product codes and names of products that have been ordered more than 100 times.
   - Write a sub-query to get the product codes of products ordered more than 100 times.
   - Use the sub-query to get the names of these products.*/
SELECT 
    productCode, productName
FROM
    products
WHERE
    productCode IN (SELECT 
            productCode
        FROM
            orderdetails
        GROUP BY productCode
        HAVING SUM(quantityOrdered) > 100);

/*7. List the office codes and cities of offices that havemore than five employees.
   - Write a sub-query to get the office codes of offices with more than five employees.
   - Use the sub-query to get the cities of these offices.*/
SELECT 
    officeCode, city
FROM
    offices
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            employees
        GROUP BY officeCode
        HAVING COUNT(*) > 5);
/*8. Find the names of customers who have placed orders with a total amount greater than $1000.
   - Write a sub-query to get the order numbers of orders with a total amount greater than $1000.
   - Use the sub-query to get the names of the customers who placed these orders.*/
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber IN (SELECT 
            customerNumber
        FROM
            orders o
                JOIN
            orderdetails od ON o.orderNumber = od.orderNumber
        GROUP BY od.orderNumber , customerNumber
        HAVING SUM(quantityOrdered * priceEach) > 1000); 
/*9. Retrieve the employee numbers and names of employees who report directly to the President.
    - Write a sub-query to get the employee number of the President.
    - Use the sub-query to get the names of employees who report to the President.*/
SELECT 
    employeeNumber, CONCAT(firstName, lastName)
FROM
    employees
WHERE
    reportsTo IN (SELECT 
            employeeNumber
        FROM
            employees
        WHERE
            jobTitle = 'President');
    
/*10. Find the product codes and names of products that have a quantity in stock less than the average quantity in stock.
    - Write a sub-query to get the average quantity in stock of all products.
    - Use the sub-query to get the names of products with a quantity in stock less than the average.*/
SELECT 
    productCode, productName
FROM
    products
WHERE
    quantityInStock < (SELECT 
            AVG(quantityInStock)
        FROM
            products);
/*11. Retrieve the employee numbers and names of employees who work in offices located in the USA.
    - Write a sub-query to get the office codes of offices located in the USA.
    - Use the sub-query to get the names of employees working in those offices.*/
SELECT 
    employeeNumber, CONCAT(firstName, lastName)
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');

/*12. List the customer numbers and names of customers who have placed more than three orders.
    - Write a sub-query to get the customer numbers of customers who have placed more than three orders.
    - Use the sub-query to get the names of these customers.*/
SELECT 
    customerNumber, customerName
FROM
    customers
WHERE
    customerNumber IN (SELECT 
            customerNumber
        FROM
            orders
        GROUP BY customerNumber
        HAVING COUNT(*) > 3);
/*13. Find the names of employees who do not have an email address.
    - Write a sub-query to get the employee numbers of employees who do not have an email address.
    - Use the sub-query to get the names of these employees.*/
SELECT 
    CONCAT(firstName, lastName)
FROM
    employees
WHERE
    email IS NULL;
/*14. List the employee numbers and names of employees who have the same job title as their manager.
    - Write a sub-query to get the job titles of managers.
    - Use the sub-query to get the names of employees with the same job title as their manager.*/
SELECT 
    employeeNumber, CONCAT(firstName, lastName)
FROM
    employees e1
WHERE
    jobtitle = (SELECT 
            jobTitle
        FROM
            employees e2
        WHERE
            e1.reportsTo = e2.employeeNumber); 
/*15. Retrieve the product codes and names of products supplied by more than one vendor.
    - Write a sub-query to get the vendors of each product.
    - Use the sub-query to get the names of products supplied by more than one vendor.*/
SELECT 
    productCode, productName
FROM
    products
WHERE
    productName IN (SELECT 
            productName
        FROM
            products
        GROUP BY productName
        HAVING COUNT(productVendor) > 1); 
/*16. List the order numbers of orders placed in the last 30 days.
    - Write a sub-query to get the order dates of orders placed in the last 30 days.
    - Use the sub-query to get the order numbers of these orders.*/
select orderNumber from orders where orderdate >= curdate() - interval 30 day;