-- 1

SELECT FirstName, LastName, CustomerId, Country FROM Customer
WHERE Country != "USA";

-- 2

SELECT FirstName, LastName, CustomerId, Country FROM Customer
WHERE Country = "Brazil";

-- 3

SELECT c.FirstName, c.LastName, c.Country, i.InvoiceId, i.InvoiceDate, i.BillingCountry FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE c.Country LIKE "Brazil";

--4

Select FirstName, LastName, Title FROM Employee
WHERE Title LIKE "Sales Support Agent"


--5

SELECT DISTINCT BillingCountry FROM Invoice

-- 6

SELECT e.FirstName, e.LastName, i.InvoiceId
FROM Employee e
JOIN Customer ON Customer.SupportRepId = e.EmployeeId
JOIN Invoice i ON Customer.CustomerId = i.CustomerId

-- 7

SELECT i.Total, c.FirstName, c.LastName, c.Country, e.FirstName, e.LastName
FROM Employee e 
JOIN Customer c on c.SupportRepId = e.EmployeeId
JOIN Invoice i on i.CustomerId = c.CustomerId

-- 8

SELECT `2009 Invoices`, `2011 Invoices` FROM
(
SELECT COUNT(i.InvoiceId) AS `2009 Invoices` FROM Invoice i
WHERE i.InvoiceDate like '2009%'
),
(
SELECT COUNT(i.InvoiceId) AS `2011 Invoices` FROM Invoice i
WHERE i.InvoiceDate like '2011%'
)


-- 9

SELECT `2009 Invoices`, `2011 Invoices` FROM
(
SELECT SUM(i.Total) AS `2009 Invoices` FROM Invoice i
WHERE i.InvoiceDate like '2009%'
),
(
SELECT SUM(i.Total) AS `2011 Invoices` FROM Invoice i
WHERE i.InvoiceDate like '2011%'
)


-- 10

SELECT Count(*) FROM InvoiceLine
JOIN Invoice i on i.InvoiceId = InvoiceLine.InvoiceId
WHERE InvoiceLine.InvoiceId


-- 11

SELECT Count(*) FROM InvoiceLine
JOIN Invoice i on i.InvoiceId = InvoiceLine.InvoiceId
GROUP BY InvoiceLine.InvoiceId

-- 12

SELECT i.InvoiceLineId, t.Name FROM InvoiceLine i 
JOIN Track t on t.TrackId = i.TrackId
ORDER BY i.InvoiceLineId

-- 13 

SELECT i.InvoiceLineId, t.Name, a.Name FROM InvoiceLine i 
JOIN Track t on t.TrackId = i.TrackId
JOIN Album on t.AlbumId = Album.AlbumId
JOIN Artist a on a.ArtistId = Album.ArtistId
ORDER BY i.InvoiceLineId

-- 14

SELECT DISTINCT i.BillingCountry, COUNT(i.InvoiceId) FROM Invoice i 
GROUP BY i.BillingCountry



-- 15

SELECT p.name, COUNT(*) as Number_Of_Tracks
FROM PlaylistTrack pt
JOIN Playlist p ON p.PlaylistId = pt.PlaylistId
GROUP BY pt.PlaylistId

-- 16
SELECT t.name, l.title, m.name, g.name FROM Track t 
JOIN Album l on l.AlbumId = t.AlbumId
JOIN MediaType m on m.MediaTypeId = t.MediaTypeId
JOIN Genre g on g.GenreId = t.GenreId

-- 17

SELECT i.InvoiceId, Count(*) FROM InvoiceLine l
JOIN Invoice i on i.InvoiceId = l.InvoiceId
GROUP BY l.InvoiceId

--18

SELECT e.FirstName || ' ' || e.LastName AS `employee_name`, SUM(i.total) FROM Customer c 
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY `employee_name`

-- 19

SELECT MAX(highest_sales), `employee_name` from (
SELECT e.FirstName || ' ' || e.LastName AS `employee_name`, SUM(i.total) as highest_sales from Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE I.InvoiceDate like '2009%'
GROUP BY `employee_name`
)


-- 20

SELECT MAX(highest_sales), `employee_name` from (
SELECT e.FirstName || ' ' || e.LastName AS `employee_name`, SUM(i.total) as highest_sales from Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY `employee_name`
)

--21

SELECT e.FirstName || ' ' || e.LastName AS `employee_name`, COUNT(*) as Number_of_customers FROM Customer c 
JOIN Employee e on e.EmployeeId = c.SupportRepId
GROUP BY `employee_name`

--22

SELECT BillingCountry, SUM(Total) from Invoice
GROUP BY BillingCountry

--23 
SELECT BillingCountry, MAX(highest_sales) from (
SELECT BillingCountry, SUM(Total) as highest_sales from Invoice
GROUP BY BillingCountry
)

--24


SELECT t.Name, COUNT(*) as total_sales from InvoiceLine l
JOIN Invoice i on l.InvoiceId = i.InvoiceId
JOIN Track t on l.TrackId = t.TrackId
WHERE i.InvoiceDate like '2013%'
GROUP BY i.InvoiceId
ORDER BY total_sales DESC;


-- 25

SELECT t.Name, COUNT(*) as total_sales from InvoiceLine l
JOIN Invoice i on l.InvoiceId = i.InvoiceId
JOIN Track t on l.TrackId = t.TrackId
GROUP BY i.InvoiceId
ORDER BY total_sales DESC
LIMIT 5;


-- 26
-- Provide a query that shows the top 3 best selling artists.

SELECT r.Name, SUM(Total) as total_sales from Invoice i 
JOIN InvoiceLine l on l.InvoiceId = i.InvoiceId
JOIN Track t on l.TrackId = t.TrackId
JOIN Album l on l.AlbumId = t.AlbumId
JOIN Artist r on r.ArtistId = l.ArtistId
GROUP BY r.Name
ORDER BY total_sales DESC
LIMIT 3;



-- 27
-- Provide a query that shows the most purchased Media Type.

SELECT m.Name, COUNT(*) as total_purchases from InvoiceLine l
JOIN Invoice i on l.InvoiceId = i.InvoiceId
JOIN Track t on l.TrackId = t.TrackId
JOIN MediaType m on t.MediaTypeId = m.MediaTypeId
GROUP BY m.name
ORDER BY total_purchases DESC
LIMIT 1;