-- HISTORIAL DE VENTAS POR UN RANGO DE FECHAS

create function dbo.ventasPorFechaRango (@fechaI datetime2, @fechaF datetime2) returns table
as
	return(select fc.SERIE, fc.NUMERO, fc.FECHA, 
				fc.DESCUENTO, fc.SUBTOTAL, fc.TOTAL 
				from dbo.FACTURASCLIENTES fc 
					where fc.FECHA between @fechaI and @fechaF) 
go

--  HISTORIAL DE COMPRAS POR UN RANGO DE FECHAS

create function dbo.comprasPorFechaRango (@fechaI datetime2, @fechaF datetime2) returns table
as
	return(select fp.SERIE, fp.NUMERO, fp.FECHA,
				p.NOMBRE as 'NOMBRE PROVEEDOR',
				e.NOMBRE as 'NOMBRE EMPLEADO',
				pr.NOMBRE as 'NOMBRE PRODUCTO',
				dfp.COSTO, dfp.CANTIDAD, 
				(dfp.COSTO*dfp.CANTIDAD) as 'SUBTOTAL'   
				from dbo.FACTURASPROVEEDORES fp 
					inner join dbo.PROVEEDORES p
						on fp.IDPROVEEDOR = p.IDPROVEEDOR
					inner join dbo.EMPLEADOS e
						on fp.IDEMPLEADO = e.IDEMPLEADO
					inner join dbo.DETALLEFACTURASPROVEEDORES dfp
						on fp.IDFACTURAPROVEEDOR = dfp.IDFACTURAPROVEEDOR
					inner join dbo.PRODUCTOS pr
						on dfp.IDPRODUCTO = pr.IDPRODUCTO
					where fp.FECHA between @fechaI and @fechaF)
go

--  HISTORIAL DE COSTOS DE PRODUCTOS POR UN RANGO DE FECHAS

create function dbo.costosPorFechaRango (@fechaI datetime2, @fechaF datetime2) returns table
as 
	return(select fp.SERIE, fp.NUMERO, fp.FECHA,
				pr.NOMBRE, dfp.COSTO, dfp.CANTIDAD,
				(dfp.COSTO*dfp.CANTIDAD) as 'SUBTOTAL',    
				pr.PRECIOCOMPRA, pr.PRECIOVENTA   
				from dbo.FACTURASPROVEEDORES fp
					inner join dbo.DETALLEFACTURASPROVEEDORES dfp
						on fp.IDFACTURAPROVEEDOR = dfp.IDFACTURAPROVEEDOR
					inner join dbo.PRODUCTOS pr
						on dfp.IDPRODUCTO = pr.IDPRODUCTO
					where fp.FECHA between @fechaI and @fechaF)
go
 
