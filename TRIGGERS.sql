USE EmpresaTransporte
GO

-- tr_registrarViajeInsertado: guardamos informacion acerca del viaje insertado en la tabla AuditoriaViaje.

CREATE TRIGGER tr_registrarViajeInsertado
ON Viaje
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditoriaViaje(IdViaje, Operacion)
    SELECT Id, 'INSERT'
    FROM inserted;
END;

GO


-- tr_registrarViajeEliminado: guardamos informacion acerca del viaje eliminado en la tabla AuditoriaViaje.

CREATE TRIGGER tr_registrarViajeEliminado
ON Viaje
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditoriaViaje(IdViaje, Operacion)
    SELECT Id, 'DELETE'
    FROM deleted;
END;

GO


-- tr_validarViajeFinalizado: Valida que un viaje con estado finalizado tenga un pago y una calificacion asociada.

CREATE TRIGGER tr_validarViajeFinalizado
ON Viaje
AFTER UPDATE
AS
BEGIN
	IF EXISTS
	(
		SELECT 1
		FROM inserted I
			INNER JOIN deleted D
			    ON I.Id = D.Id
			INNER JOIN EstadoViaje EV
			    ON I.IdEstado = EV.Id
		WHERE I.IdEstado <> D.IdEstado
		  AND EV.Descripcion = 'Finalizado'
		  AND (I.IdPago IS NULL OR I.IdCalificacion IS NULL)
	)
	BEGIN
		RAISERROR('Un viaje finalizado debe tener pago y calificación.', 16, 1);
		ROLLBACK TRANSACTION;
	END
END;