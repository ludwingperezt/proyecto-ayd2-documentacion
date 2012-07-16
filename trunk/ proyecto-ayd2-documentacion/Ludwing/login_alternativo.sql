use textiles
go

create function dbo.ingreso (@usuario char(12), @pass binary(20)) returns int
as
begin
	declare @ret as int	
	if exists (select * from dbo.EMPLEADOS e where e.USUARIO = @usuario and e.PASSWORD = @pass)
		if exists (select * from dbo.EMPLEADOS e where e.USUARIO = @usuario and e.PASSWORD = @pass and e.HABILITADO = 1)
			set @ret = 1	--1= usuario existente y con acceso
		else
			set @ret = 2 --2 = usuario existente y válido pero sin acceso
	else
		set @ret = 0 -- 0 = no existe el usuario, o no es correcta su contraseña o password
	return @ret
end
go

create procedure dbo.obtenerEmpleadoValido @usuario char(12), @pass binary(20)
as
begin
select e.IDEMPLEADO,e.IDROL,e.NOMBRE,e.APELLIDO,e.DIRECCION,e.TELEFONO,e.CELULAR,e.PUESTO,e.FECHACONTRATACION,e.SALARIO,e.USUARIO,e.HABILITADO,e.DPICEDULA 
from EMPLEADOS e
where e.USUARIO = @usuario and e.PASSWORD = @pass and e.HABILITADO = 1
end
go

