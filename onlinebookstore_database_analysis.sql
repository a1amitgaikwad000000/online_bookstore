CREATE DATABASE onlinebookstore_db;
USE onlinebookstore_db;

-- 1. Retrieve all books in the “Fiction” genre
SELECT * 
FROM books 
WHERE genre = 'Fiction';

-- 2. Find books published after the year 1950
SELECT * 
FROM books 
WHERE published_year > 1950;

-- 3. List all customers from Canada
SELECT * 
FROM customers 
WHERE country = 'Canada';

-- 4. Show orders placed in November 2023
SELECT * 
FROM orders 
WHERE MONTH(order_date) = 11 
  AND YEAR(order_date) = 2023;

-- 5. Retrieve the total stock of books available
SELECT SUM(stock) AS total_stock
FROM books;

-- 6. Find the details of the most expensive book
SELECT * 
FROM books 
ORDER BY price DESC 
LIMIT 1;

-- 7. Show all customers who ordered more than 1 quantity of a book
SELECT DISTINCT c.customer_id, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.quantity > 1;

-- 8. Retrieve all orders where the total amount exceeds $20
SELECT * 
FROM orders 
WHERE total_amount > 20;

-- 9. List all distinct genres in the bookstore
SELECT DISTINCT genre 
FROM books;

-- 10. Find the book with the lowest stock available
SELECT * 
FROM books 
ORDER BY stock ASC 
LIMIT 1;

-- 11. Calculate the total revenue from all orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- 12. Retrieve the total number of books sold for each genre
SELECT b.genre, SUM(o.quantity) AS total_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

-- 13. Find the average price of books in the “Fantasy” genre
SELECT AVG(price) AS avg_fantasy_price
FROM books 
WHERE genre = 'Fantasy';

-- 14. List customers who have placed at least 2 orders
SELECT c.customer_id, c.name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

-- 15. Find the most frequently ordered book
SELECT b.title, SUM(o.quantity) AS total_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY total_sold DESC
LIMIT 1;

-- 16. Show the top 3 most expensive books of the “Fantasy” genre
SELECT title, price
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 17. Retrieve the total quantity of books sold by each author
SELECT b.author, SUM(o.quantity) AS total_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author
ORDER BY total_sold DESC;

-- 18. List the cities of customers who spent over $30
SELECT c.city, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 30;

-- 19. Find the customer who spent the most on orders
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- 20. Calculate the stock remaining after fulfilling all orders
SELECT b.title, 
       b.stock - IFNULL(SUM(o.quantity), 0) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY remaining_stock ASC;
