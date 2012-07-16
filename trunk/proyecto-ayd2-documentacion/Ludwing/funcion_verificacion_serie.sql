use textiles
go

create function dbo.verificarExistenciaSerie (@serie char(3)) returns bit
as
begin
	declare @ret as bit 	
	if exists (Select * from dbo.Series where serie = @serie)
		set @ret = 1
	else
		set @ret = 0
	return @ret
end
go