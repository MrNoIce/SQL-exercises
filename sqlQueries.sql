--1 non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT
	C.CustomerId,
	(C.FirstName || " " || C.LastName) AS "FullName",
	C.Country
FROM
	Customer AS C
WHERE
	C.Country IS NOT "USA";

--2 brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT
	C.CustomerId,
	(C.FirstName || " " || C.LastName) AS "FullName",
	C.Country
FROM
	Customer AS C
WHERE
	C.Country IS "Brazil";

--3 brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT
	I.InvoiceId,
	(C.FirstName || " " || C.LastName) AS "FullName",
	C.Country,
	I.InvoiceDate,
	I.BillingCountry
FROM
	Customer AS C
	JOIN Invoice AS I
WHERE
	C.Country IS "Brazil";

--4 sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT
	(E.FirstName || " " || E.LastName) AS "FullName"
FROM
	Employee AS E
WHERE
	E.Title IS "Sales Support Agent";

--5 unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT
	I.BillingCountry
FROM
	Invoice AS I;

--6 sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT
	(E.FirstName || " " || E.LastName) AS "Name",
	*
FROM
	Invoice AS I
	JOIN Employee AS E
	JOIN Customer AS C
WHERE
	E.EmployeeId = C.SupportRepId
	AND C.CustomerId = I.CustomerId
ORDER BY
	NAME;

--7 invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT
	(C.FirstName || " " || C.LastName) AS "Name",
	I.Total,
	C.Country,
	(E.FirstName || " " || E.LastName) AS "Name"
FROM
	Invoice AS I
	JOIN Employee AS E
	JOIN Customer AS C
WHERE
	E.EmployeeId = C.SupportRepId
	AND C.CustomerId = I.CustomerId
ORDER BY
	NAME;

--8 total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
SELECT
	I.InvoiceDate,
	COUNT(I.InvoiceDate)
FROM
	Invoice AS I
WHERE
	I.InvoiceDate BETWEEN '2009%'
	AND '2011%';

--9 total_sales_{year}.sql: What are the respective total sales for each of those years?
SELECT
	COUNT(InvoiceId) AS "num of invoices",
	sum(Total),
	strftime ("%Y",
		InvoiceDate) AS yearVal
FROM
	Invoice
WHERE
	yearVal = "2009"
	AND yearVal = "2011"
GROUP BY
	yearVal;

SELECT strftime('%Y',i.InvoiceDate) as "Year", SUM(i.Total) AS "YearTotal"
FROM Invoice i
WHERE YEAR = "2009" or YEAR = "2011"
GROUP BY YEAR;


--10 invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT
	COUNT(InvoiceId) AS "total items sold"
FROM
	InvoiceLine
WHERE
	InvoiceId = 37;

--11 line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT
	COUNT(InvoiceId) AS "total line items"
FROM
	InvoiceLine
GROUP BY
	InvoiceId;

--12 line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT
	I.InvoiceId, T.Name
FROM
	InvoiceLine as I
	Join Track as T
WHERE I.TrackId = T.TrackId
Order By InvoiceLineId;


--13 line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT
	I.InvoiceId, T.Name, A.Name
FROM
	InvoiceLine as I
	Join Track as T ON I.TrackId = T.TrackId
	join Album as Al ON Al.AlbumId = T.AlbumId
	Join Artist as A ON A.ArtistId = Al.ArtistId;

--14 country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT
	BillingCountry,
	COUNT(InvoiceId)
FROM Invoice
GROUP BY
	BillingCountry;

--15 playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
SELECT
	P.Name, COUNT(T.Name)
FROM
	Playlist as P
	JOIN PlaylistTrack as Pl ON P.PlaylistId = Pl.PlaylistId
	JOIN Track as T ON Pl.TrackId = T.TrackId
Order by
	P.NAME;

--16 tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT
	T.Name as "Track", A.Title "Album", M.Name "Media Type", G.Name "Genre"
FROM
	Track as T
	JOIN Album as A on A.AlbumId = T.AlbumId
	JOIN MediaType as M on M.MediaTypeId = T.MediaTypeId
	JOIN Genre as G on G.GenreId = T.GenreId
GROUP BY
	T.Name;
--17 invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT
	*, SUM(Quantity) AS "Total Sold"

FROM
	Invoice as I
	Join InvoiceLine as Il on I.InvoiceId = Il.InvoiceId
Group BY
	I.InvoiceId;

--18 sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

SELECT
	E.FirstName, COUNT(I.CustomerId)
FROM
	Employee as E
	Join Invoice as I on C.CustomerId = I.CustomerId
	JOIN Customer as C on C.SupportRepId = E.EmployeeId
GROUP By
	E.FirstName;

-- 19. top_2009_agent.sql: Which sales agent made the most in sales in 2009?
--Hint: Use the MAX function on a subquery.

SELECT
	EmployeeName,
	InvoiceTotal,
	MAX(TotalSales) TotalSales
FROM (
	SELECT
		e.FirstName || ' ' || e.LastName AS EmployeeName,
		COUNT(*) InvoiceTotal,
		sum(i.Total) TotalSales
	FROM
		Invoice i
		JOIN Customer c ON i.CustomerId = c.CustomerId
		JOIN Employee e ON c.SupportRepId = e.EmployeeId
	WHERE
		SUBSTR(i.InvoiceDate, 1, 4) = '2009'
	GROUP BY
		EmployeeName);

-- 20. top_agent.sql: Which sales agent made the most in sales over all?
SELECT
	EmployeeName,
	TotalSales,
	MAX(InvoiceTotal) TotalSales
FROM (
	SELECT
		e.FirstName || ' ' || e.LastName AS EmployeeName,
		COUNT(*) TotalSales,
		sum(i.Total) InvoiceTotal
	FROM
		Invoice i
		JOIN Customer c ON i.CustomerId = c.CustomerId
		JOIN Employee e ON c.SupportRepId = e.EmployeeId
	GROUP BY
		EmployeeName);

-- 21. sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.
SELECT
	e.FirstName || ' ' || e.LastName AS EmployeeName,
	Count(*) NumberOfCustomers
FROM
	Customer c
	JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY
	EmployeeName;

-- 22. sales_per_country.sql: Provide a query that shows the total sales per country.
SELECT
	i.BillingCountry Country,
	COUNT(*) TotalSales,
	sum(i.Total) InvoiceTotal
FROM
	Invoice i
GROUP BY
	Country;

-- 23. Which country's customers spent the most?
SELECT
	Country,
	MAX(InvoiceTotal) InvoiceTotal
FROM (
	SELECT
		i.BillingCountry Country,
		COUNT(*) TotalSales,
		sum(i.Total) InvoiceTotal
	FROM
		Invoice i
	GROUP BY
		Country);

-- 24. Provide a query that shows the most purchased track of 2013.
SELECT
	Track,
	MAX(TotalPurchased) TotalPurchased
FROM (
	SELECT
		t.Name Track,
		COUNT(*) TotalPurchased
	FROM
		InvoiceLine il
		JOIN Track t ON t.TrackId = il.TrackId
		JOIN Invoice i
    WHERE
		i.InvoiceId IN(
			SELECT
				i.InvoiceId FROM Invoice i
			WHERE
				SUBSTR(i.InvoiceDate, 1, 4) = '2013')
	GROUP BY
		Track);

-- 25. Provide a query that shows the top 5 most purchased tracks over all.
    SELECT
        Track,
        TotalPurchased
    FROM ( SELECT DISTINCT
            t.Name Track,
            COUNT(il.TrackId) TotalPurchased
        FROM
            InvoiceLine il
            JOIN Track t ON t.TrackId = il.TrackId
        GROUP BY
            il.TrackId)
    ORDER BY
        TotalPurchased DESC
    LIMIT 5;

    -- 26. Provide a query that shows the top 3 best selling artists.
    SELECT
        *
    FROM ( SELECT DISTINCT
            a.Name Artist,
            COUNT(a.ArtistId) TracksSold
        FROM
            InvoiceLine il
            JOIN Track t ON t.TrackId = il.TrackId
            JOIN Album al ON al.AlbumId = t.AlbumId
            JOIN Artist a ON a.ArtistId = al.ArtistId
        GROUP BY
            a.ArtistId)
    ORDER BY
        TracksSold DESC
    LIMIT 3;

    -- 27. Provide a query that shows the most purchased Media Type.
    SELECT
        MediaType,
        MAX(TypeSold) TypeSold
    FROM ( SELECT DISTINCT
            mt.Name MediaType,
            COUNT(mt.MediaTypeId) TypeSold
        FROM
            InvoiceLine il
            JOIN Track t ON t.TrackId = il.TrackId
            JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
        GROUP BY
            mt.MediaTypeId);