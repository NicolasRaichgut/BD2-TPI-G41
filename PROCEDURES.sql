USE EmpresaTransporte
GO

-- sp_reporteViajes: recibe dos fechas y devuelve los viajes que se hicieron entre ambas.

CREATE PROCEDURE sp_reporteViajes(
	@FechaInicio DATE,
	@FechaFin DATE
)
AS
BEGIN

	IF @FechaInicio > @FechaFin
    BEGIN
        PRINT 'La fecha de inicio no puede ser mayor que la fecha de fin.';
        RETURN;
    END;

	Select CL.Apellido + ', ' + CL.Nombre AS ApeNomCliente,
		   CH.Apellido + ', ' + CH.Nombre AS ApeNomChofer,
		   V.Fecha AS FechaViaje, P.Monto
	From Viaje V INNER JOIN Cliente CL on V.DniCliente = CL.Dni
		         INNER JOIN Chofer CH on V.DniChofer = CH.Dni
				 INNER JOIN Pago P on V.IdPago = P.Id
				 INNER JOIN EstadoViaje EV on V.IdEstado = EV.Id
	Where V.Fecha BETWEEN @FechaInicio AND @FechaFin
		  AND EV.Descripcion = 'Finalizado'
	ORDER BY V.Fecha;

END;


GO


-- sp_agregarViaje

CREATE PROCEDURE sp_agregarViaje(
	@DniCliente VARCHAR(10),
	@DniChofer VARCHAR(10),
	@Fecha DATETIME,
	@DireccionOrigen VARCHAR(100),
	@DireccionDestino VARCHAR(100),
	@DistanciaKm DECIMAL(5,2)
)
AS
BEGIN
	INSERT INTO Viaje(DniCliente, DniChofer, Fecha, DireccionOrigen, DireccionDestino, DistanciaKm, IdEstado)
	VALUES(@DniCliente, @DniChofer, @Fecha, @DireccionOrigen, @DireccionDestino, @DistanciaKm, 1);
END;