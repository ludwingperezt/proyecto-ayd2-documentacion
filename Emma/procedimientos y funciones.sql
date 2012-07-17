

create PROCEDURE insertarCliente @IdtipoCliente tinyint, @nombreCliente varchar(100), 
@direccionCliente varchar(60), @nitCliente char(12)
AS
insert into CLIENTES (NOMBRE,DIRECCION,NIT,IDTIPOCLIENTE) values
  (@nombreCliente,@direccionCliente,@nitCliente,@IdtipoCliente);
GO


create PROCEDURE  insertarEmpleados @idRol tinyint, @nombreEmpleado varchar(40), 
@apellidoEmpleado varchar(40), @direccionEmpleado varchar(60), @telefonoEmpleado char(15),
@celularEmpleado char(15), @puestoEmpleado varchar(25), @fechaContratacionEmpleado datetime2(7),
@salarioEmpleado money, @usuarioEmpleado char(12), @passwordEmpleado binary(20), @habilitado bit,
@dpiCedulaEmpleado varchar(15)
AS
insert into EMPLEADOS(IDROL,NOMBRE,APELLIDO,DIRECCION,TELEFONO,CELULAR,PUESTO,FECHACONTRATACION,
SALARIO, USUARIO,PASSWORD, HABILITADO,dpiCedula) values
  (@idRol,@nombreEmpleado,@apellidoEmpleado,@direccionEmpleado, @telefonoEmpleado,
  @celularEmpleado,@puestoEmpleado,@fechaContratacionEmpleado,@salarioEmpleado,@usuarioEmpleado,
  @passwordEmpleado,@habilitado,@dpiCedulaEmpleado);
GO


create PROCEDURE darBajaEmpleado @idEmpleado tinyint
AS
update EMPLEADOS
set HABILITADO =0
where IDEMPLEADO=@idEmpleado;
GO


create PROCEDURE ModificarCliente @idCliente tinyint, @tipoCliente tinyint, 
@nombreCliente varchar(100), @direccionCliente varchar(60), @nitCliente char(15)
AS
update CLIENTES
set IDTIPOCLIENTE =@tipoCliente,
NIT = @nitCliente,
NOMBRE= @nombreCliente,
DIRECCION= @direccionCliente
where IDCLIENTE =@idCliente;
GO



create PROCEDURE ModificarEmpleado @idEmpleado tinyint, @idRol tinyint, @nombreEmpleado varchar(40), 
@apellidoEmpleado varchar(40), @direccionEmpleado varchar(60), @telefonoEmpleado char(15),
@celularEmpleado char(15), @puestoEmpleado varchar(25), @fechaContratacionEmpleado datetime2(7),
@salarioEmpleado money, @usuarioEmpleado char(12), @passwordEmpleado binary(20), @habilitado bit,
@dpiCedulaEmpleado varchar(15)
AS
update EMPLEADOS
set IDROL =@idRol,
NOMBRE= @nombreEmpleado,
APELLIDO= @apellidoEmpleado,
DIRECCION= @direccionEmpleado,
TELEFONO=@telefonoEmpleado,
CELULAR=@celularEmpleado,
PUESTO=@puestoEmpleado,
FECHACONTRATACION=@fechaContratacionEmpleado,
SALARIO=@salarioEmpleado,
USUARIO=@usuarioEmpleado,
PASSWORD=@passwordEmpleado,
dpiCedula=@dpiCedulaEmpleado
where IDEMPLEADO =@idEmpleado;
GO


CREATE FUNCTION buscarClienteNit (@nitCliente char(12))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from CLIENTES where NIT=@nitCliente
);


CREATE FUNCTION buscarClienteNombre (@nombreCliente varchar(100))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from CLIENTES where NOMBRE=@nombreCliente
);


CREATE FUNCTION buscarClienteDireccion (@direccionCliente varchar(60))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from CLIENTES where DIRECCION=@direccionCliente
);


CREATE FUNCTION buscarEmpleadoNombre (@nombreEmpleado varchar(40))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where NOMBRE=@nombreEmpleado
);



CREATE FUNCTION buscarEmpleadoApellido (@apellidoEmpleado varchar(40))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where APELLIDO=@apellidoEmpleado
);


CREATE FUNCTION buscarEmpleadoDireccion (@direccionEmpleado varchar(60))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where DIRECCION=@direccionEmpleado
);


CREATE FUNCTION buscarEmpleadoTelefono (@telefonoEmpleado char(15))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where TELEFONO=@telefonoEmpleado
);



CREATE FUNCTION buscarEmpleadoCelular (@celularEmpleado char(15))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where CELULAR=@celularEmpleado
);


CREATE FUNCTION buscarEmpleadoPuesto (@puestoEmpleado varchar(25))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where PUESTO=@puestoEmpleado
);


CREATE FUNCTION buscarEmpleadoUsuario (@UsuarioEmpleado char(12))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where USUARIO=@UsuarioEmpleado
);


create PROCEDURE insertarTipoCliente @IdtipoCliente tinyint, @nombreTipo varchar(15), 
@descripcionTipo varchar(60), @descuentoTipo float
AS
insert into TIPOSCLIENTES(IDTIPOCLIENTE,NOMBRE,DESCRIPCION,DESCUENTO) values
  (@IdtipoCliente,@nombreTipo,@descripcionTipo,@descuentoTipo);
GO


create PROCEDURE ModificarTipoCliente @tipoCliente tinyint, @nombreTipo varchar(15), 
@descripcionTipo varchar(60), @descuentoTipo float 
AS
update TIPOSCLIENTES
set NOMBRE =@nombreTipo,
DESCRIPCION= @descripcionTipo,
DESCUENTO= @descripcionTipo
where IDTIPOCLIENTE =@tipoCliente;
GO


CREATE FUNCTION buscarTipoClienteNombre (@TipoClienteNombre char(15))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from TIPOSCLIENTES where NOMBRE=@TipoClienteNombre
);



CREATE FUNCTION buscarTipoClienteDescripcion (@TipoClienteDescripcion char(60))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from TIPOSCLIENTES where DESCRIPCION=@TipoClienteDescripcion
);


create PROCEDURE insertarFacturaProveedor @idProveedor int, 
@idEmpleado int, @serie char(4), @numero int, @fecha datetime, @total money
AS
insert into FACTURAFACTURASPROVEEDORES(IDPROVEEDOR, IDEMPLEADO,
SERIE, NUMERO, FECHA, TOTAL) values
  (@idProveedor,@idEmpleado,@serie,@numero, @fecha, @total);
GO



create PROCEDURE insertarDetalleFacturaProveedores @IdDetalleFactura int, @idFacturaProveedores int, 
@idProducto smallint, @costo money, @cantidad float
AS
insert into DETALLEFACTURASPROVEEDORES(IDDETALLEFACTURAPROVEEDOR, IDFACTURAPROVEEDOR, IDPRODUCTO,
COSTO, CANTIDAD) values
  (@IdDetalleFactura,@idFacturaProveedores,@idProducto,@costo,@cantidad);
GO


CREATE FUNCTION buscarProveedorNit (@nitProveedor char(15))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from PROVEEDORES where NIT=@nitProveedor
);




CREATE FUNCTION ultimosVeinteEmpleados ( )
RETURNS TABLE
AS 
RETURN
(
	SELECT TOP(20) * from EMPLEADOS WHERE HABILITADO = 1 ORDER BY FECHACONTRATACION
);


CREATE FUNCTION ultimasVeinteCompras ( )
RETURNS TABLE
AS 
RETURN
(
	SELECT TOP(20) * from FACTURASPROVEEDORES WHERE ACTIVO=1 ORDER BY FECHA
);

CREATE FUNCTION ultimosVeinteClientes ( )
RETURNS TABLE
AS 
RETURN
(
	SELECT TOP(20) * from CLIENTES ORDER BY NOMBRE
);


CREATE FUNCTION buscarEmpleadoCedulaDpi (@CedulaDpiEmpleado varchar(15))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from EMPLEADOS where DPICEDULA=@CedulaDpiEmpleado
);

CREATE FUNCTION devolverIdFactura (@numeroFactura int, @serieFactura char(4))
RETURNS TABLE
AS 
RETURN
(
	SELECT * from FACTURASPROVEEDORES where NUMERO=@numeroFactura and SERIE = @serieFactura 
);

CREATE FUNCTION ultimoRegistro ( )
RETURNS TABLE
AS 
RETURN
(
	SELECT TOP(1) * from FACTURASPROVEEDORES ORDER BY FECHA DESC 
);

