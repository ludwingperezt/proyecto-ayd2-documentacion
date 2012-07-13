use textiles
go

create procedure dbo.insertarSerieFactura @serie char(3), @actual int, @limite int, @idSucursal tinyint,@idTerminal smallint 
as
begin
	INSERT INTO dbo.SERIES VALUES(@serie,@actual,@limite,@idSucursal,@idTerminal,1)
end
go

create procedure dbo.modificarSerieFactura @serie char(3), @actual int,@limite int, @idSucursal tinyint,@idTerminal smallint
as
begin
	UPDATE dbo.SERIES SET ACTUAL = @actual, LIMITE=@limite, IDSUCURSAL=@idSucursal,IDTERMINAL=@idTerminal WHERE SERIE = @serie
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
	SELECT s.SERIE,s.ACTUAL,s.LIMITE,s.IDSUCURSAL,s.IDTERMINAL,s.ACTIVA FROM dbo.SERIES s WHERE s.ACTIVA = 1
end
go

create procedure dbo.insertarPrimeraSerieFactura @serie char(3), @actual int, @limite int, @idSucursal tinyint 
as
begin
	declare @ultima int
	select @ultima = MAX(s.IDTERMINAL) from dbo.SERIES s
	set @ultima = @ultima + 1
	INSERT INTO dbo.SERIES VALUES(@serie,@actual,@limite,@idSucursal,@ultima,1)
end
go

create procedure dbo.obtenerSerieEspecificaPorEstacion  @serie char(3),@idEstacion smallint
as
begin
	SELECT s.SERIE,s.ACTUAL,s.LIMITE,s.IDSUCURSAL,s.IDTERMINAL,s.ACTIVA FROM dbo.SERIES s WHERE s.SERIE = @serie and s.IDTERMINAL = @idEstacion and s.ACTIVA=1
end
go