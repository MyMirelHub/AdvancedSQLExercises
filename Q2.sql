UPDATE sales.invoicelines 
SET    sales.invoicelines.unitprice = sales.invoicelines.unitprice + 20 
WHERE  sales.invoicelines.invoicelineid = (SELECT TOP (1) il.invoicelineid 
                                           FROM   sales.customers AS c, 
                                                  sales.invoices AS i, 
                                                  sales.invoicelines AS il 
                                           WHERE  i.invoiceid = il.invoiceid 
                                                  AND i.customerid = 
                                                      c.customerid 
                                                  AND i.customerid = 1060 
                                           ORDER  BY il.invoicelineid ASC) 