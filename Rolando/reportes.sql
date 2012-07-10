create proc creditosXProveedor  @idProv smallint as 
SELECT p.idProveedor, nc.idNota "Número Nota", p.empresa "Empresa",nc.Monto, nc.Fecha from NOTASCREDITO nc INNER JOIN PROVEEDORES p ON p.IDPROVEEDOR=nc.IDPROVEEDOR
WHERE p.IdProveedor=@idprov and p.activo=1  
Go


create proc fechaMinimaNOTASCREDITO as
select MIN(nc.FECHA) FECHA from NOTASCREDITO nc
go