use textiles
go

create procedure dbo.devolverRolPorId @id int
as
begin
	SELECT r.IDROL,r.NOMBRE,
			r.MODULOROLES,r.MODULOEMPLEADOS,r.MODULOPROVEEDORES,
			r.MODULOPRODUCTOS,r.MODULOCOMPRAS,r.MODULOCLIENTES,
			r.MODULOVENTAS,r.MODULOREPORTES,r.NIVELACCESO 
	FROM dbo.ROLES r WHERE r.IDROL = @id
end 
go

create procedure dbo.obtenerSeriePorEstacion @idEstacion smallint
as
begin
	SELECT s.SERIE,s.ACTUAL,s.LIMITE,s.IDSUCURSAL,s.IDTERMINAL,s.ACTIVA FROM dbo.SERIES s WHERE s.IDTERMINAL = @idEstacion and s.ACTIVA=1
end
go

create procedure dbo.obtenerSeriePorSucursal @idSucursal tinyint
as
begin
	SELECT s.SERIE,s.ACTUAL,s.LIMITE,s.IDSUCURSAL,s.IDTERMINAL,s.ACTIVA FROM dbo.SERIES s WHERE s.IDSUCURSAL = @idSucursal and s.ACTIVA=1
end
go

create procedure dbo.buscarProductoPorId @id smallint
as
begin
	SELECT p.IDPRODUCTO,p.CODIGO,p.NOMBRE,p.CANTIDAD,p.PRECIOCOMPRA,p.PRECIOVENTA,p.COLOR FROM dbo.PRODUCTOS p WHERE p.IDPRODUCTO = @id and p.ACTIVO = 1
end
go

create procedure dbo.buscarProductoPorCodigo @codigo varchar(14)
as
begin
	declare @patron varchar(15)
	select @patron = RTRIM(@codigo)+'%'
	SELECT p.IDPRODUCTO,p.CODIGO,p.NOMBRE,p.CANTIDAD,p.PRECIOCOMPRA,p.PRECIOVENTA,p.COLOR FROM dbo.PRODUCTOS p WHERE p.ACTIVO = 1 and p.CODIGO like @patron
end
go

create procedure dbo.buscarProductoPorNombre @nombre varchar(39)
as
begin
	declare @patron varchar(40)
	select @patron = RTRIM(@nombre)+'%'
	SELECT p.IDPRODUCTO,p.CODIGO,p.NOMBRE,p.CANTIDAD,p.PRECIOCOMPRA,p.PRECIOVENTA,p.COLOR FROM dbo.PRODUCTOS p WHERE p.ACTIVO = 1 and p.NOMBRE like @patron
end
go

CREATE PROCEDURE dbo.paginacionProductos @PageSize int, @PageNumber int
AS
BEGIN
	Declare @RowStart int
	Declare @RowEnd int
	if @PageNumber > 0
	Begin
		SET @PageNumber = @PageNumber -1
		SET @RowStart = @PageSize * @PageNumber + 1;
		SET @RowEnd = @RowStart + @PageSize - 1 ;
		With Cust AS ( SELECT IDPRODUCTO,CODIGO,NOMBRE,CANTIDAD,PRECIOCOMPRA,PRECIOVENTA,COLOR,ROW_NUMBER() OVER (order by idproducto) as RowNumber FROM productos )
		select * from Cust Where RowNumber >= @RowStart and RowNumber <= @RowEnd 
	end
END

CREATE PROCEDURE dbo.bcn @nit char(12)
AS
BEGIN
	SELECT IDCLIENTE,IDTIPOCLIENTE,NIT,NOMBRE,DIRECCION from CLIENTES where NIT=@nit
END
GO
