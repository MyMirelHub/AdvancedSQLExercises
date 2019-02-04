-- Doing it by Union Pivot 
SELECT temp.customerid, 
       temp.customername,--temp is the alias for the select queries 
       Sum(temp.invoicestotalvalue)                   AS InvoicesTotalValue, 
       Sum(temp.ordertotalvalue)                      AS OrderTotalValue, 
       Sum(temp.nbtotalinvoices)                      AS NBTotalInvoices, 
       Sum(temp.nbtotalorders)                        AS NBTotalOrders, 
       Abs(Sum(ordertotalvalue - invoicestotalvalue)) AS AbsoluteValueDifference 
FROM   ((SELECT C.customerid, 
                C.customername, 
                Sum(il.quantity * il.unitprice) AS InvoicesTotalValue, 
                0                               AS OrderTotalValue, 
                0                               AS NBTotalInvoices, 
                0                               AS NBTotalOrders 
         FROM   sales.invoices AS i, 
                sales.invoicelines AS il, 
                sales.customers AS c 
         WHERE  i.invoiceid = il.invoiceid 
                AND i.customerid = c.customerid 
         GROUP  BY C.customerid, 
                   C.customername) 
        UNION 
        (SELECT C.customerid, 
                C.customername, 
                0                               AS InvoicesTotalValue, 
                Sum(oi.quantity * oi.unitprice) AS OrderTotalValue, 
                0                               AS NBTotalInvoices, 
                0                               AS NBTotalOrders 
         FROM   sales.customers AS c, 
                sales.invoices AS i, 
                sales.orders AS o, 
                sales.orderlines AS oi 
         WHERE  o.orderid = oi.orderid 
                AND o.customerid = c.customerid 
                AND i.orderid = o.orderid 
         --makes sure orders are converted from invoices   
         GROUP  BY C.customerid, 
                   C.customername) 
        UNION 
        (SELECT C.customerid, 
                C.customername, 
                0                           AS InvoicesTotalValue, 
                0                           AS OrderTotalValue, 
                Count(DISTINCT i.invoiceid) AS NBTotalInvoices, 
                0                           AS NBTotalOrders 
         FROM   sales.invoices AS i, 
                sales.invoicelines AS il, 
                sales.customers AS c 
         WHERE  i.invoiceid = il.invoiceid 
                AND i.customerid = c.customerid 
         GROUP  BY C.customerid, 
                   C.customername) 
        UNION 
        (SELECT C.customerid, 
                C.customername, 
                0                         AS InvoicesTotalValue, 
                0                         AS OrderTotalValue, 
                0                         AS NBTotalInvoices, 
                Count(DISTINCT o.orderid) AS NBTotalOrders 
         FROM   sales.orders AS o, 
                sales.orderlines AS oi, 
                sales.customers AS c, 
                sales.invoices AS i 
         WHERE  o.orderid = oi.orderid 
                AND o.customerid = c.customerid 
                AND i.orderid = o.orderid 
         GROUP  BY C.customerid, 
                   C.customername))AS temp 
GROUP  BY temp.customerid, 
          temp.customername 
ORDER  BY absolutevaluedifference DESC, 
          nbtotalorders ASC, 
          temp.customername ASC 