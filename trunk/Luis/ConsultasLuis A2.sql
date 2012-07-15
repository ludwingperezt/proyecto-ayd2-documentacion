-----------------------Proveedor----------------------------------------------
create proc insersionProveedor @nomb varchar(70), @nit char(15), @dir varchar(60), 
								@empresa varchar(25), @propietario varchar(70), @tel char(15), 
								@cel char(15)
as
Begin
	insert into dbo.PROVEEDORES
	(NOMBRE,NIT,DIRECCION,EMPRESA,PROPIETARIO,TELEFONO,CELULAR,ACTIVO)
	 values
	 (@nomb, @nit, @dir, 
	  @empresa, @propietario, @tel, 
	  @cel,1)
	  return 1
End
go


create proc darDeBajaProveedor @id smallint
as
begin
	update dbo.PROVEEDORES
	set ACTIVO = 0
	where IDPROVEEDOR = @id
	return 1
end
go

create proc darDeAltaProveedor @id smallint
as
begin
	update dbo.PROVEEDORES
	set ACTIVO = 1
	where IDPROVEEDOR = @id
	return 1
end
go

create proc modificarProveedor @id smallint, @nomb varchar(70), @nit char(15), @dir varchar(60), 
							 @empresa varchar(25), @propietario varchar(70), @tel char(15), 
							 @cel char(15)
as
begin
	update dbo.PROVEEDORES
	set NOMBRE = @nomb,
		NIT = @nit,
		DIRECCION = @dir,
		EMPRESA = @empresa,
		PROPIETARIO = @propietario,
		TELEFONO = @tel,
		CELULAR = @cel		
	where IDPROVEEDOR = @id
	return 1
end
go


create function ProveedorPorID (@id smallint)
returns table
as
return
(
	select * from dbo.PROVEEDORES p where p.IDPROVEEDOR = @id and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorID @id smallint
as
	select * from dbo.ProveedorPorID(@id)
go
--

create function ProveedorPorNombre (@nomb varchar(70))
returns table
as
return 
(
	select * from dbo.PROVEEDORES where NOMBRE like @nomb and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorNombre @nomb varchar(70)
as
	select * from dbo.ProveedorPorNombre(@nomb)
go
--

create function ProveedorPorNit (@nit char(15))
returns table
as
return
(
	select * from PROVEEDORES where NIT like '%'+@nit+'%' and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorNit @nit char(15)
as
begin
	declare @buscar char(15)
	set @buscar = '%'+RTRIM(@nit)+'%'
	select * from ProveedorPorNit(@buscar)
end
go
--
	
create function ProveedorPorDireccion (@dir varchar(60))
returns table
as
return
(
	select * from PROVEEDORES where DIRECCION like @dir and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorDireccion @dir varchar(60)
as
	declare @buscar char(60)
	set @buscar = '%'+RTRIM(@dir)+'%'
	select * from ProveedorPorDireccion(@buscar)
go
--

create function ProveedorPorEmpresa (@emp varchar(25))
returns table
as
return
(
	select * from PROVEEDORES where EMPRESA like @emp and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorEmpresa @emp varchar(25)
as
	declare @buscar char(25)
	set @buscar = '%'+RTRIM(@emp)+'%'
	select * from dbo.ProveedorPorEmpresa(@emp)
go
--

create function ProveedorPorPropietario (@prop varchar(70))
returns table
as
return
(
	select * from PROVEEDORES where PROPIETARIO like @prop and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorPropietaio @prop varchar(70)
as
	declare @buscar char(60)
	set @buscar = '%'+RTRIM(@prop)+'%'
	select * from dbo.ProveedorPorPropietario(@prop)
go
--

create function ProveedorPorTelefonoOCelular (@tel char(15))
returns table
as
return
(
	select * from PROVEEDORES where TELEFONO like @tel OR CELULAR like @tel and ACTIVO = 1
)
go
--proc
create proc buscarProveedorPorTelefonoOCelular @tel char(15)
as
	declare @buscar char(60)
	set @buscar = '%'+RTRIM(@tel)+'%'
	select * from dbo.ProveedorPorTelefonoOCelular(@tel)
go
--

create function ProveedorPorEstado (@activo bit)
returns table
as
return
(
	select * from PROVEEDORES where ACTIVO = @activo
)
go
--proc
create proc buscarProveedorPorEstado @activo bit
as
	select * from dbo.ProveedorPorEstado(@activo)
go
--
------------------------------------Serie----------------------------------------------------

create proc insersionSerie @serie char(3), @actual int
as
begin
	insert into dbo.SERIES
	(SERIE, ACTUAL, ACTIVA) values
	(@serie,@actual, 1)
end
go

create proc darDeBajaSerie @serie char(3)
as
begin
	update dbo.SERIES
	set ACTIVA = 0
	where SERIE = @serie
	return 1
end
go

create proc darDeAltaSerie @serie char(3)
as
begin
	update dbo.SERIES
	set ACTIVA = 1
	where SERIE = @serie
	return 1
end
go

create proc modificarSerie @serie char(3), @actual int
as
begin
	update dbo.SERIES
	set ACTUAL = @actual
	where SERIE = @serie
	return 1
end
go

create function SeriePorSerie (@serie char(3))
returns table
as
return
(
	select * from SERIES where SERIE = @serie
)
go
--proc
create proc buscarSeriePorSerie @serie char(3)
as
	select * from dbo.SeriePorSerie(@serie)
go
--

create function SeriePorActual (@act int)
returns table
as
return
(
	select * from SERIES where ACTUAL = @act
)
go
--proc
create proc buscarSeriePorActual @act char(3)
as
	select * from dbo.SeriePorActual(@act)
go
--

create function SeriePorEstado (@estado bit)
returns table
as
return
(
	select * from SERIES where ACTIVA = @estado
)
go
--proc
create proc buscarSeriePorEstado @estado char(3)
as
	select * from dbo.SeriePorEstado(@estado)
go
--

----------------............Listados...............-------------------------
create proc listarProveedores 
as
	select * from dbo.PROVEEDORES where ACTIVO = 1
go

create proc listarSeries
as
	select * from dbo.SERIES where ACTIVA = 1
go

create proc listarFacturasProveedorEliminadas
as
	select * from dbo.FACTURASPROVEEDORELIMINADAS
go

------------------------------- Facturas de Proveedor Eliminadas  ---------------------------
create proc insersionFacturaProveedorEliminada @idFact int, @idEmpleado tinyint, @fecha datetime2, @anotacion varchar(200)
as
begin
	insert into FACTURASPROVEEDORELIMINADAS (
		IDFACTURAPROVEEDOR, IDEMPLEADO, FECHA, ANOTACION
	)
	values (@idFact,@idEmpleado,@fecha,@anotacion)
end
go

create proc modificarFacutraProveedorEliminada @idFact int, @idEmpleado tinyint, @fecha datetime2, @anotacion varchar(200)
as
begin
	update dbo.FACTURASPROVEEDORELIMINADAS
	set IDEMPLEADO = @idEmpleado,
		FECHA = @fecha,
		ANOTACION = @anotacion
	where IDFACTURAPROVEEDOR = @idFact
end
go

create proc eliminarFacturaProveedorEliminada @idFact int
as
begin
	delete dbo.FACTURASPROVEEDORELIMINADAS
	where IDFACTURAPROVEEDOR = @idFact
end
go

create proc buscarFacturaProveedorEliminadaPorIdempleado @id tinyint
as
	select * from FACTURASPROVEEDORELIMINADAS where IDEMPLEADO = @id
go

create proc buscarFacturaProveedorEliminadaDesdeFecha @fecha datetime2
as
	select * from FACTURASPROVEEDORELIMINADAS where FECHA >= @fecha
go

create proc buscarFacturaProveedorEliminadaHastaFecha @fecha datetime2
as 
	select * from FACTURASPROVEEDORELIMINADAS where FECHA < @fecha
go

------------------------------Facturas Proveedor------------------------------------
create proc darDeBajaFacturaProveedor @id int, @anotacion varchar(200)
as
begin
	update dbo.FACTURASPROVEEDORES 
	set ACTIVO = 0
	where IDFACTURAPROVEEDOR = @id
	
	declare @idempleado tinyint
	set @idempleado = (select f.IDEMPLEADO from dbo.FACTURASPROVEEDORES f where f.IDFACTURAPROVEEDOR = @id)
	exec insersionFacturaProveedorEliminada @id,@idempleado, getdate, @anotacion
end
go