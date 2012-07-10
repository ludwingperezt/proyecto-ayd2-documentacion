use textiles
go

create procedure dbo.insertarSerieFactura @serie char(3), @actual int
as
begin
	INSERT INTO dbo.SERIES VALUES(@serie,@actual,1)
end
go

create procedure dbo.modificarSerieFactura @serie char(3), @actual int
as
begin
	UPDATE dbo.SERIES SET ACTUAL = @actual WHERE SERIE = @serie
end
go

create procedure dbo.eliminarSerieFactura @serie char(3)
as
begin
	UPDATE dbo.SERIES SET ACTIVA = 0 WHERE SERIE = @serie
end
go

create procedure dbo.mostrarSeries
as
begin
	SELECT s.SERIE,s.ACTUAL,s.ACTIVA FROM dbo.SERIES s WHERE s.ACTIVA = 1
end
go