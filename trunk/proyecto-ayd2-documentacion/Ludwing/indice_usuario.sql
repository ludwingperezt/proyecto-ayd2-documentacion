USE [textiles]
GO
CREATE UNIQUE NONCLUSTERED INDEX [usuario-empleado] ON [dbo].[EMPLEADOS] 
(
	[USUARIO] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
