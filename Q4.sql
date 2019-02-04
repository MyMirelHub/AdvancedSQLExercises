SELECT loss.customercategoryname, 
       loss.maxloss, 
       T2.customername, 
       T2.customerid 
FROM   (SELECT T1.customercategoryname, 
               Max(T1.totalvaluelostorders) AS MaxLoss 
        FROM   (SELECT Cu.customerid, 
                       Cu.customername, 
                       Ca.customercategoryname, 
                       Sum(ol.quantity * ol.unitprice) AS TotalValueLostOrders 
                FROM   sales.orders AS O, 
                       sales.orderlines AS ol, 
                       sales.customers AS Cu, 
                       sales.customercategories AS Ca 
                WHERE  NOT EXISTS (SELECT * 
                                   FROM   sales.invoices AS I 
                                   WHERE  I.orderid = O.orderid) 
                       AND ol.orderid = O.orderid 
                       AND Cu.customerid = O.customerid 
                       AND Ca.customercategoryid = Cu.customercategoryid 
                GROUP  BY Cu.customerid, 
                          Cu.customername, 
                          Ca.customercategoryname) AS T1 
        GROUP  BY customercategoryname) AS loss, 
       (SELECT Cu.customerid, 
               Cu.customername, 
               Ca.customercategoryname, 
               Sum(ol.quantity * ol.unitprice) AS TotalValueLostOrders 
        FROM   sales.orders AS O, 
               sales.orderlines AS ol, 
               sales.customers AS Cu, 
               sales.customercategories AS Ca 
        WHERE  NOT EXISTS (SELECT * 
                           FROM   sales.invoices AS I 
                           WHERE  I.orderid = O.orderid) 
               AND ol.orderid = O.orderid 
               AND Cu.customerid = O.customerid 
               AND Ca.customercategoryid = Cu.customercategoryid 
        GROUP  BY Cu.customerid, 
                  Cu.customername, 
                  Ca.customercategoryname) AS T2 
WHERE  loss.customercategoryname = T2.customercategoryname 
       AND loss.maxloss = T2.totalvaluelostorders 
ORDER  BY loss.maxloss DESC 