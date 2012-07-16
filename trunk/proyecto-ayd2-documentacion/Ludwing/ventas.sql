use textiles
go

create trigger dbo.actualizarSerie on dbo.FacturasClientes
after insert
as
begin
	declare @serie char(3)	
	declare @actual int
	declare @limite int
	select @serie = i.SERIE from inserted i
	select @actual = s.ACTUAL, @limite = s.LIMITE from dbo.SERIES s where s.SERIE = @serie
	if @actual > @limite
	begin
		update dbo.SERIES set ACTIVA = 0 where SERIE = @serie
		commit
	end
	else if @actual <= @limite
	begin	
		update dbo.SERIES set ACTUAL = ACTUAL + 1 where SERIE = @serie
	end
end
go

create procedure dbo.insertarEncabezadoFacturaCliente
	@idCliente int,
	@idEmpleado tinyint,
	@serie char(3),
	@descuento float,
	@subtotal money,
	@total money
as
begin
	declare @fecha datetime2
	declare @numero int
	set @fecha = CAST(GETDATE() as datetime2)
	select @numero = ACTUAL from dbo.SERIES where SERIE = @serie
	INSERT INTO dbo.FACTURASCLIENTES (IDCLIENTE,IDEMPLEADO,SERIE,NUMERO,FECHA,DESCUENTO,SUBTOTAL,TOTAL) VALUES (@idCliente,@idEmpleado,@serie,@numero,@fecha,@descuento,@subtotal,@total)
	SELECT SCOPE_IDENTITY()
end
go

create procedure dbo.insertarDetalleFacturaCliente 
	@idEncabezadoFactura int,
	@idProducto smallint,
	@precio money,
	@cantidad float
as
begin
	INSERT INTO dbo.DETALLESFACTURASCLIENTES VALUES (@idEncabezadoFactura,@idProducto,@precio,@cantidad)	
end
go

create function dbo.obtenerNumeroFacturaCliente (@idFactura int) returns int
as
begin
	declare @numero int
	select @numero = f.NUMERO from dbo.FACTURASCLIENTES f where f.IDFACTURACLIENTE = @idFactura
	return @numero
end
go