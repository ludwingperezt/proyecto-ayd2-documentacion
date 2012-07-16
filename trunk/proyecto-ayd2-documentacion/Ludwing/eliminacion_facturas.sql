use textiles
go

CREATE PROCEDURE dbo.buscarFacturasPorSerieNumero @serie char(3),@numero int
AS
BEGIN
	SELECT IDFACTURACLIENTE,IDCLIENTE,IDEMPLEADO,SERIE,NUMERO,FECHA,DESCUENTO,SUBTOTAL,TOTAL 
	FROM dbo.FACTURASCLIENTES 
	WHERE SERIE = @serie and NUMERO = @numero and 
		IDFACTURACLIENTE not in (SELECT s.IDFACTURACLIENTE FROM FACTURASCLIENTES s INNER JOIN dbo.FACTURASELIMINADAS e on s.IDFACTURACLIENTE = e.IDFACTURACLIENTE)
END
GO

CREATE PROCEDURE dbo.buscarDetalleFactura @idFactura int
AS
BEGIN
	SELECT IDDETALLEFACTURACLIENTE,IDPRODUCTO,PRECIO,CANTIDAD FROM dbo.DETALLESFACTURASCLIENTES WHERE IDFACTURACLIENTE = @idFactura
END
GO

CREATE PROCEDURE dbo.devolverProductosDetallesFacturaEliminada @idFactura int
AS
BEGIN
	declare @iddetalle int
	declare @idproducto smallint
	declare @cantidad float	
	declare CURSORITO cursor for select IDPRODUCTO,CANTIDAD from dbo.detallesfacturasclientes where IDFACTURACLIENTE = @idFactura
	open CURSORITO
	fetch next from CURSORITO
	into @idproducto, @cantidad while @@fetch_status = 0
    begin
		update dbo.PRODUCTOS set CANTIDAD = CANTIDAD + @cantidad WHERE IDPRODUCTO = @idproducto
		fetch next from CURSORITO into @idproducto, @cantidad
    end
    close CURSORITO
	deallocate CURSORITO
END
GO

CREATE PROCEDURE dbo.insertarFacturaEliminada @idFactura int, @idempleados tinyint, @nota varchar(200)
AS
BEGIN
	declare @fecha datetime2
	set @fecha = CAST(GETDATE() as datetime2)
	INSERT INTO dbo.FACTURASELIMINADAS VALUES(@idFactura,@idempleados,@fecha,@nota)
END
GO

CREATE PROCEDURE dbo.paginacionFacturasCliente @PageSize int, @PageNumber int
AS
BEGIN
	Declare @RowStart int
	Declare @RowEnd int
	if @PageNumber > 0
	Begin
		SET @PageNumber = @PageNumber -1
		SET @RowStart = @PageSize * @PageNumber + 1;
		SET @RowEnd = @RowStart + @PageSize - 1 ;
		With Cust AS 
		( 
			SELECT IDFACTURACLIENTE,IDCLIENTE,IDEMPLEADO,SERIE,NUMERO,FECHA,DESCUENTO,SUBTOTAL,TOTAL,ROW_NUMBER() OVER (order by FECHA desc) as RowNumber 
			FROM FACTURASCLIENTES 
			WHERE IDFACTURACLIENTE  not in (SELECT s.IDFACTURACLIENTE FROM FACTURASCLIENTES s INNER JOIN dbo.FACTURASELIMINADAS e on s.IDFACTURACLIENTE = e.IDFACTURACLIENTE)
		)
		select * from Cust Where RowNumber >= @RowStart and RowNumber <= @RowEnd 
	end
END
GO

create procedure dbo.obtenerClienteYTipoCliente @idCliente int
as
begin
select c.IDTIPOCLIENTE,c.NIT,c.NOMBRE,c.DIRECCION,t.NOMBRE,t.DESCRIPCION,t.DESCUENTO from dbo.CLIENTES c
inner join dbo.TIPOSCLIENTES t on t.IDTIPOCLIENTE = c.IDTIPOCLIENTE
where c.IDCLIENTE = @idCliente
end
go

create procedure dbo.obtenerNombreApellidoEmpleado @idEmpleado tinyint
as
begin
	SELECT e.NOMBRE,e.APELLIDO FROM dbo.EMPLEADOS e WHERE e.IDEMPLEADO = @idEmpleado
end
go