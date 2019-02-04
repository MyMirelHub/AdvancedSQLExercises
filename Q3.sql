CREATE OR ALTER PROCEDURE [dbo].[ReportCustomerTurnover](@Choice INT = 1, @Year INT = 2013) 
AS 
  BEGIN
  SET nocount ON;
  IF (@Choice = 1) 
    BEGIN 
      SELECT   C.customername, 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 1 
                      AND    Year(I.invoicedate) = @Year ) AS 'Jan', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 2 
                      AND    Year(I.invoicedate) = @Year ) AS 'Feb', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 3 
                      AND    Year(I.invoicedate) = @Year ) AS 'Mar', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 4 
                      AND    Year(I.invoicedate) = @Year ) AS 'Apr', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 5 
                      AND    Year(I.invoicedate) = @Year ) AS 'May', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 6 
                      AND    Year(I.invoicedate) = @Year ) AS 'Jun', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 7 
                      AND    Year(I.invoicedate) = @Year ) AS 'Jul', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 8 
                      AND    Year(I.invoicedate) = @Year ) AS 'Aug', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 9 
                      AND    Year(I.invoicedate) = @Year ) AS 'Sep', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 10 
                      AND    Year(I.invoicedate) = @Year ) AS 'Oct', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate)= 11 
                      AND    Year(I.invoicedate) = @Year ) AS 'Nov', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Month(I.invoicedate) = 12 
                      AND    Year(I.invoicedate) = @Year ) AS 'Dec' 
      FROM     sales.customers                             AS C 
      ORDER BY C.customername 
    END 
    IF (@Choice = 2) 
    BEGIN 
      SELECT   C.customername, 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Year(I.invoicedate) = @Year 
                      AND    Datepart(quarter, I.invoicedate) = 1 ) AS 'Q1', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Year(I.invoicedate) = @Year 
                      AND    Datepart(quarter, I.invoicedate) = 2 ) AS 'Q2', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Year(I.invoicedate) = @Year 
                      AND    Datepart(quarter, I.invoicedate) = 3 ) AS 'Q3', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    C.customerid = I.customerid 
                      AND    Year(I.invoicedate) = @Year 
                      AND    Datepart(quarter, I.invoicedate) = 4 ) AS 'Q4' 
      FROM     sales.customers                                      AS C 
      ORDER BY C.customername 
    END
    IF (@Choice = 3) 
    BEGIN 
      SELECT   customername, 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    Cu.customerid = I.customerid 
                      AND    Year(I.invoicedate) = 2013 ) AS '2013', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    Cu.customerid = I.customerid 
                      AND    Year(I.invoicedate) = 2014 ) AS '2014', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    Cu.customerid = I.customerid 
                      AND    Year(I.invoicedate) = 2015 ) AS '2015', 
               ( 
                      SELECT COALESCE(Sum(IL.unitprice*IL.quantity), 0) 
                      FROM   sales.invoicelines AS IL, 
                             sales.invoices     AS I 
                      WHERE  IL.invoiceid = I.invoiceid 
                      AND    Cu.customerid = I.customerid 
                      AND    Year(I.invoicedate) = 2016 ) AS '2016' 
      FROM     sales.customers                            AS Cu 
      ORDER BY customername 
    END
    END