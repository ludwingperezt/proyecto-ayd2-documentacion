use textiles
create procedure cierredecaja 
@fechai datetime, @fechaf datetime
as
   select * from dbo.facturasclientes fc where fc.fecha between @fechai and @fechaf

go


create procedure devolucionesProvFecha
@fechai datetime, @fechaf datetime
as
   select * from dbo.FACTURASPROVEEDORES fp where fp.idfacturaproveedor = 
   (select idfacturaproveedor from dbo.FACTURASPROVEEDORELIMINADAS fpe where fpe.fecha between @fechai and @fechaf)
go

create procedure devolucionesProvNit
@nit char(15)
as
   select * from dbo.FACTURASPROVEEDORES fp where fp.idfacturaproveedor = 
   (select idfacturaproveedor from dbo.FACTURASPROVEEDORELIMINADAS fpe  where idfacturaproveedor = 
   ( select idfacturaproveedor from dbo.FACTURASPROVEEDORES fp where fp.idproveedor = 
   (select IDPROVEEDOR from dbo.PROVEEDORES p where p.nit = @nit  )))
   
    
   
go

create procedure devolucinesProvFechaNit
@fechai datetime, @fechaf datetime,@nit char(15)
as
    select * from dbo.FACTURASPROVEEDORES fp where fp.idfacturaproveedor = 
   (select idfacturaproveedor from dbo.FACTURASPROVEEDORELIMINADAS fpe where fpe.fecha between @fechai and @fechaf)
	union
	select * from dbo.FACTURASPROVEEDORES fp where fp.idfacturaproveedor = 
   (select idfacturaproveedor from dbo.FACTURASPROVEEDORELIMINADAS fpe  where idfacturaproveedor = 
   ( select idfacturaproveedor from dbo.FACTURASPROVEEDORES fp where fp.idproveedor = 
   (select IDPROVEEDOR from dbo.PROVEEDORES p where p.nit = @nit  )))
	
go

create procedure facturasEliminadasFecha 
@fechai datetime, @fechaf datetime
as
    select * from dbo.FACTURASCLIENTES fc where fc.idfacturacliente=  
    (select idfacturacliente from dbo.FACTURASELIMINADAS fe where fe.fecha between  @fechai and @fechaf)

go

create procedure facturasEliminadasNit
@nit char(15)
as
    select * from dbo.FACTURASCLIENTES  fc where fc.idfacturacliente = 
   ( select idfacturacliente from dbo.FACTURASELIMINADAS where idfacturacliente = 
    (select idfacturacliente from dbo.FACTURASCLIENTES fc where fc.nit = @nit ))


go

create procedure facturasEliminadasFechaNit
@fechai datetime, @fechaf datetime,@nit char(15)
as
	select * from dbo.FACTURASCLIENTES fc where fc.idfacturacliente=  
    (select idfacturacliente from dbo.FACTURASELIMINADAS fe where fe.fecha between  @fechai and @fechaf)
    
    union 
    
    select * from dbo.FACTURASCLIENTES  fc where fc.idfacturacliente = 
   ( select idfacturacliente from dbo.FACTURASELIMINADAS where idfacturacliente = 
    (select idfacturacliente from dbo.FACTURASCLIENTES fc where fc.nit = @nit ))

go

--DECLARE @ProductID datetime, @CheckDate datetime;
--SET @ProductID = '20050225';
--SET @CheckDate = '20050225';

--exec facturasEliminadasFecha @productID, @CheckDate
--exec devolucionesProvFecha @ProductID, @CheckDate;

--DECLARE @nit char(15)
--set @nit= '1233445'
--exec dbo.facturasEliminadasNit @nit; 
--exec dbo.devolucionesProvNit @nit;



--DECLARE @ProductID datetime, @CheckDate datetime,@nit char(15);
--SET @ProductID = '20050225';
--SET @CheckDate = '20050225';
--set @nit= '1233445'
--exec dbo.facturasEliminadasFechaNit @ProductID, @CheckDate,@nit;
--exec dbo.devolucinesProvFechaNit  @ProductID, @CheckDate,@nit;