SELECT * 
FROM   customer AS c 
WHERE  NOT EXISTS (SELECT * 
                   FROM   product AS P 
                   WHERE  NOT EXISTS (SELECT * 
                                      FROM   purchase AS Pu 
                                      WHERE  Pu.productid = P.productid 
                                             AND c.customerid = Pu.customerid)) 
       AND (SELECT Sum(pu.qty) 
            FROM   purchase AS pu 
            WHERE  pu.customerid = c.customerid) >= 50 