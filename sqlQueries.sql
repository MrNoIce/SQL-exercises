-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT C.CustomerId, (C.FirstName || " " || C.LastName) AS "FullName", C.Country
FROM Customer as C
WHERE C.Country is NOT "USA";

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

SELECT C.CustomerId, (C.FirstName || " " || C.LastName) AS "FullName", C.Country
FROM Customer as C
WHERE C.Country is "Brazil";

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT I.InvoiceId, (C.FirstName || " " || C.LastName) AS "FullName", C.Country, I.InvoiceDate, I.BillingCountry
FROM Customer as C
JOIN Invoice as I
WHERE C.Country is "Brazil";

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT (E.FirstName || " " || E.LastName) as "FullName"
FROM Employee as E
WHERE E.Title is "Sales Support Agent";