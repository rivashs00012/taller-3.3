use northwind
go
drop function if exists dbo.totalpedido
go
create function dbo.totalpedido(@orderid int)
returns money
as
begin
declare @total money
select @total = sum(unitprice * quantity)
from [order details]
where orderid = @orderid
return isnull(@total, 0)
end
go
-- prueba
select dbo.totalpedido(10248) as total_pedido
go

-- Base de Datos: Northwind
-- Tipo: Funcion Escalar
-- Funcion: nombreempleado
drop function if exists dbo.nombreempleado
go
create function dbo.nombreempleado(@employeeid int)
returns varchar(100)
as
begin
declare @nombre varchar(100)
select @nombre = firstname + ' ' + lastname
from employees
where employeeid = @employeeid
return isnull(@nombre, 'no encontrado')
end
go
-- prueba
select dbo.nombreempleado(1) as empleado
go



-- Base de Datos: Northwind
-- Tipo: Funcion de Tabla
-- Funcion: pedidoscliente
drop function if exists dbo.pedidoscliente
go
create function dbo.pedidoscliente(@customerid nchar(5))
returns table
as
return
(
select
orderid,
orderdate,
shipcountry
from orders
where customerid = @customerid
)
go
-- prueba
select * from dbo.pedidoscliente('ALFKI')
go






USE pubs;
GO
-- Base: Pubs | Tipo: Escalar | Función: Calcula total vendido por un título
DROP FUNCTION IF EXISTS dbo.fn_TotalVentasPorTitulo;
GO
CREATE FUNCTION dbo.fn_TotalVentasPorTitulo(@title_id VARCHAR(6))
RETURNS INT
AS
BEGIN
DECLARE @total INT;
SELECT @total = SUM(qty)
FROM sales
WHERE title_id = @title_id;
RETURN ISNULL(@total, 0);
END;
GO
-- Prueba
SELECT dbo.fn_TotalVentasPorTitulo('PS3333') AS TotalVendido;
-- Base: Pubs | Tipo: Escalar | Función: Cuenta títulos por editorial
DROP FUNCTION IF EXISTS dbo.fn_CantidadTitulosPorEditorial;
GO
CREATE FUNCTION dbo.fn_CantidadTitulosPorEditorial(@pub_id VARCHAR(4))
RETURNS INT
AS
BEGIN
DECLARE @cantidad INT;
SELECT @cantidad = COUNT(*)
FROM titles
WHERE pub_id = @pub_id;
RETURN ISNULL(@cantidad, 0);
END;
GO
-- Prueba
SELECT dbo.fn_CantidadTitulosPorEditorial('0736') AS Cantidad;
-- Base: Pubs | Tipo: Tabla | Función: Muestra autores con sus libros
DROP FUNCTION IF EXISTS dbo.fn_AutoresConTitulos;
GO
CREATE FUNCTION dbo.fn_AutoresConTitulos()
RETURNS TABLE
AS
RETURN
(
SELECT
a.au_lname + ' ' + a.au_fname AS Autor,
t.title AS Titulo
FROM authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id = t.title_id
);
GO
-- Prueba
SELECT * FROM dbo.fn_AutoresConTitulos();







USE AdventureWorks;
GO
------------------------------------------------------------
-- 1) FUNCIÓN ESCALAR: Calcula el IGV (18%) de un subtotal
------------------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fn_calcular_igv;
GO
CREATE FUNCTION dbo.fn_calcular_igv
(
@subtotal DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN @subtotal * 0.18;
END;
GO
-- PRUEBA
SELECT dbo.fn_calcular_igv(1000) AS igv;
GO
------------------------------------------------------------
-- 2) FUNCIÓN ESCALAR: Devuelve el nombre completo de un empleado
------------------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fn_nombre_empleado;
GO
CREATE FUNCTION dbo.fn_nombre_empleado
(
@BusinessEntityID INT
)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @nombre VARCHAR(100);
SELECT @nombre = FirstName + ' ' + LastName
FROM Person.Person
WHERE BusinessEntityID = @BusinessEntityID;
RETURN ISNULL(@nombre,'No existe');
END;
GO
-- PRUEBA
SELECT dbo.fn_nombre_empleado(1) AS NombreEmpleado;
GO
------------------------------------------------------------
-- 3) FUNCIÓN TIPO TABLA: Ventas por año
------------------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fn_ventas_por_anio;
GO
CREATE FUNCTION dbo.fn_ventas_por_anio
(
@anio INT
)
RETURNS TABLE
AS
RETURN
(
SELECT
YEAR(OrderDate) AS anio,
SUM(TotalDue) AS total_ventas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = @anio
GROUP BY YEAR(OrderDate)
);
GO
-- PRUEBA
SELECT * FROM dbo.fn_ventas_por_anio(2013);
GO
------------------------------------------------------------
-- 4) FUNCIÓN TIPO TABLA: Lista de productos por categoría
------------------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fn_productos_por_categoria;
GO
CREATE FUNCTION dbo.fn_productos_por_categoria
(
@categoria INT
)
RETURNS TABLE
AS
RETURN
(
SELECT
P.ProductID,
P.Name,
P.ListPrice
FROM Production.Product P
JOIN Production.ProductSubcategory S
ON P.ProductSubcategoryID = S.ProductSubcategoryID
WHERE S.ProductCategoryID = @categoria
);
GO
-- PRUEBA
SELECT * FROM dbo.fn_productos_por_categoria(1);
GO


