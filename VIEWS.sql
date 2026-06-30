USE EmpresaTransporte
GO

CREATE VIEW vw_infoViajes AS
SELECT
    V.Id,
    V.Fecha,
    CL.Apellido + ', ' + CL.Nombre AS ApeNomCliente,
    CH.Apellido + ', ' + CH.Nombre AS ApeNomChofer,
    V.DireccionOrigen,
    V.DireccionDestino,
    EV.Descripcion AS Estado,
    P.Monto,
    MP.Descripcion AS MetodoPago,
    CA.Descripcion AS Calificacion
FROM Viaje V
INNER JOIN Cliente CL
    ON V.DniCliente = CL.Dni
INNER JOIN Chofer CH
    ON V.DniChofer = CH.Dni
INNER JOIN EstadoViaje EV
    ON V.IdEstado = EV.Id
LEFT JOIN Pago P
    ON V.IdPago = P.Id
LEFT JOIN MetodoPago MP
    ON P.IdMetodoPago = MP.Id
LEFT JOIN Calificacion CA
    ON V.IdCalificacion = CA.Id;

GO

CREATE VIEW vw_infoRemises AS
SELECT
	R.Patente,
	R.Marca,
	R.Modelo,
	R.Anio,
	TV.Descripcion AS TipoVehiculo,
	TV.TarifaBase,
	CH.Apellido + ', ' + CH.Nombre AS ApeNomChofer,
	T.HoraInicio,
	T.HoraFin
FROM Remis R
INNER JOIN TipoVehiculo TV
	ON R.IdTipoVehiculo = TV.Id
INNER JOIN Chofer CH
	ON R.DniChofer = CH.Dni
INNER JOIN Turno T
	ON CH.IdTurno = T.Id

GO

CREATE VIEW vw_clientesXviajes AS
SELECT
    CL.Apellido + ', ' + CL.Nombre AS ApeNomCliente,
    COUNT(V.Id) AS CantViajes,
    MAX(V.Fecha) AS FechaUltimoViaje
FROM Cliente CL
LEFT JOIN Viaje V
    ON CL.Dni = V.DniCliente
GROUP BY
    CL.Dni,
    CL.Apellido,
    CL.Nombre;
