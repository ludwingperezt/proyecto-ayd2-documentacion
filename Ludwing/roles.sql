use textiles
go

create procedure dbo.insertarRol 
	@nombre varchar(20),
	@pRoles binary(10),
	@pEmpleados binary(10),
	@pProveedores binary(10),
	@pProductos binary(10),
	@pCompras binary(10),
	@pClientes binary(10),
	@pVentas binary(10),
	@pReportes binary(10),
	@nivelAcceso tinyint
as
begin
	INSERT INTO dbo.ROLES VALUES (@nombre,@pRoles,@pEmpleados,@pProveedores,@pProductos,@pCompras,@pClientes,@pVentas,@pReportes,@nivelAcceso,1)
end
go

create procedure dbo.modificarEliminarRol
	@id tinyint,
	@nombre varchar(20),
	@pRoles binary(10),
	@pEmpleados binary(10),
	@pProveedores binary(10),
	@pProductos binary(10),
	@pCompras binary(10),
	@pClientes binary(10),
	@pVentas binary(10),
	@pReportes binary(10),
	@nivelAcceso tinyint,
	@habilitado bit
as
begin
	UPDATE dbo.ROLES SET NOMBRE=@nombre,MODULOROLES=@pRoles,MODULOEMPLEADOS=@pEmpleados,MODULOPROVEEDORES=@pProveedores,
		MODULOPRODUCTOS=@pProductos,MODULOCOMPRAS=@pCompras,MODULOCLIENTES=@pClientes,MODULOVENTAS=@pVentas,MODULOREPORTES=@pReportes,
		NIVELACCESO=@nivelAcceso,HABILITADO=@habilitado WHERE IDROL = @id
end
go

create procedure dbo.modificarRol
	@id tinyint,
	@nombre varchar(20),
	@pRoles binary(10),
	@pEmpleados binary(10),
	@pProveedores binary(10),
	@pProductos binary(10),
	@pCompras binary(10),
	@pClientes binary(10),
	@pVentas binary(10),
	@pReportes binary(10),
	@nivelAcceso tinyint
as
begin
	UPDATE dbo.ROLES SET NOMBRE=@nombre,MODULOROLES=@pRoles,MODULOEMPLEADOS=@pEmpleados,MODULOPROVEEDORES=@pProveedores,
		MODULOPRODUCTOS=@pProductos,MODULOCOMPRAS=@pCompras,MODULOCLIENTES=@pClientes,MODULOVENTAS=@pVentas,MODULOREPORTES=@pReportes,
		NIVELACCESO=@nivelAcceso WHERE IDROL = @id
end
go

create procedure dbo.eliminarRol @id tinyint
as
begin
	UPDATE dbo.ROLES SET HABILITADO=0 WHERE IDROL = @id
end
go

create procedure dbo.mostrarRoles
as
begin
	SELECT r.IDROL,r.NOMBRE,
			r.MODULOROLES,r.MODULOEMPLEADOS,r.MODULOPROVEEDORES,
			r.MODULOPRODUCTOS,r.MODULOCOMPRAS,r.MODULOCLIENTES,
			r.MODULOVENTAS,r.MODULOREPORTES,r.NIVELACCESO 
	FROM dbo.ROLES r WHERE r.HABILITADO = 1
end
go