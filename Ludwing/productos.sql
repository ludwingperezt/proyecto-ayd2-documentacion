use textiles
go

create procedure dbo.insertarProducto 
	@codigo char(15),
	@nombre varchar(40),
	@cantidad float,
	@precioCompra money,
	@precioVenta money,
	@color varchar(15)
as
begin
	INSERT INTO dbo.PRODUCTOS VALUES (@codigo,@nombre,@cantidad,@precioCompra,@precioVenta,@color,1)
end
go

create procedure dbo.modificarProducto
	@id smallint,
	@codigo char(15),
	@nombre varchar(40),
	@cantidad float,
	@precioCompra money,
	@precioVenta money,
	@color varchar(15)
as
begin
	UPDATE dbo.PRODUCTOS SET CODIGO=@codigo,NOMBRE=@nombre,CANTIDAD=@cantidad,PRECIOCOMPRA=@precioCompra,PRECIOVENTA=@precioVenta,COLOR=@color
	WHERE IDPRODUCTO = @id
end
go

create procedure dbo.modificarEliminarProducto
	@id smallint,
	@codigo char(15),
	@nombre varchar(40),
	@cantidad float,
	@precioCompra money,
	@precioVenta money,
	@color varchar(15),
	@activo bit
as
begin
	UPDATE dbo.PRODUCTOS SET CODIGO=@codigo,NOMBRE=@nombre,CANTIDAD=@cantidad,PRECIOCOMPRA=@precioCompra,PRECIOVENTA=@precioVenta,COLOR=@color,ACTIVO=@activo
	WHERE IDPRODUCTO = @id
end
go

create procedure dbo.eliminarProducto @id smallint
as
begin
	UPDATE dbo.PRODUCTOS SET ACTIVO=0 WHERE IDPRODUCTO = @id
end
go

create procedure dbo.mostrarProductos
as
begin
	SELECT p.IDPRODUCTO,p.CODIGO,p.NOMBRE,p.CANTIDAD,p.PRECIOCOMPRA,p.PRECIOVENTA,p.COLOR FROM dbo.PRODUCTOS p WHERE p.ACTIVO = 1
end
go

create function dbo.verificarExistencia(@idProducto smallint, @cantidad float) returns bit
as
begin
	declare @ret bit
	declare @cant float
	select @cant = CANTIDAD from dbo.PRODUCTOS where IDPRODUCTO = @idProducto
	if @cant >= @cantidad
		begin
			set @ret = 1
		end
	else
		begin
			set @ret = 0
		end
	return @ret
end
go

create procedure dbo.aumentarStockProducto @idProducto smallint, @cantidad float
as
begin
	UPDATE dbo.PRODUCTOS SET CANTIDAD = CANTIDAD + @cantidad WHERE IDPRODUCTO = @idProducto
end
go

create procedure dbo.disminuirStockProducto @idProducto smallint, @cantidad float
as
begin
	UPDATE dbo.PRODUCTOS SET CANTIDAD = CANTIDAD - @cantidad WHERE IDPRODUCTO = @idProducto
end
go