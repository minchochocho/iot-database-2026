SELECT	orderid, custid, saleprice
FROM	Orders od1
WHERE	saleprice> (SELECT AVG(saleprice)
FROM	Orders od2
WHERE	od1.custid=od2.custid);