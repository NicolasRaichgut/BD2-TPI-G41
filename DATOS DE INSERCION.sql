USE EmpresaTransporte;
GO

-----------------------------------------------------
-- TURNO
-----------------------------------------------------

INSERT INTO Turno(HoraInicio, HoraFin)
VALUES
('06:00', '14:00'),
('14:00', '22:00'),
('22:00', '06:00');

-----------------------------------------------------
-- TIPO VEHICULO
-----------------------------------------------------

INSERT INTO TipoVehiculo(Descripcion, TarifaBase)
VALUES
('Economico', 2500),
('Ejecutivo', 3500),
('Premium', 5000),
('Utilitario', 4200);

-----------------------------------------------------
-- CALIFICACIONES
-----------------------------------------------------

INSERT INTO Calificacion(Puntaje, Descripcion)
VALUES
(1,'Muy malo'),
(2,'Malo'),
(3,'Regular'),
(4,'Bueno'),
(5,'Excelente');

-----------------------------------------------------
-- METODOS DE PAGO
-----------------------------------------------------

INSERT INTO MetodoPago(Descripcion)
VALUES
('Efectivo'),
('Tarjeta'),
('Mercado Pago'),
('Transferencia');

-----------------------------------------------------
-- ESTADOS
-----------------------------------------------------

INSERT INTO EstadoViaje(Descripcion)
VALUES
('Solicitado'),
('Aceptado'),
('En curso'),
('Finalizado'),
('Cancelado');

-----------------------------------------------------
-- CLIENTES
-----------------------------------------------------

INSERT INTO Cliente
VALUES
('30111222','Juan','Perez','1122334455','Av. Rivadavia 1200','1995-02-15'),
('28999888','Ana','Gomez','1166778899','Belgrano 350','1990-09-10'),
('33444555','Carlos','Fernandez','1155443322','Mitre 845','1988-01-22'),
('35777111','Lucia','Martinez','1133445566','San Martin 200','1998-11-05'),
('40123456','Sofia','Lopez','1177889900','Sarmiento 1450','2001-07-18');

-----------------------------------------------------
-- CHOFERES
-----------------------------------------------------

INSERT INTO Chofer
VALUES
('22111222','Miguel','Suarez','1144441111','Laprida 450','2018-03-01',1),
('23333444','Roberto','Diaz','1166662222','Moreno 220','2020-08-15',2),
('25555666','Fernando','Ruiz','1133337777','Las Heras 150','2017-10-12',3),
('27777888','Jorge','Alvarez','1155559999','Cordoba 1800','2019-06-08',1);

-----------------------------------------------------
-- REMISES
-----------------------------------------------------

INSERT INTO Remis
VALUES
('AB123CD','Toyota','Corolla',2022,'22111222',2),
('AC456EF','Fiat','Cronos',2023,'23333444',1),
('AD789GH','Volkswagen','Vento',2021,'25555666',3),
('AE321IJ','Renault','Kangoo',2020,'27777888',4);

-----------------------------------------------------
-- PAGOS
-----------------------------------------------------

INSERT INTO Pago(IdMetodoPago,Monto,Fecha)
VALUES
(3,5800,'2026-06-01 09:15'),
(2,4200,'2026-06-03 18:30'),
(1,3600,'2026-06-05 11:00'),
(4,7400,'2026-06-08 20:45'),
(3,5200,'2026-06-10 14:20');

-----------------------------------------------------
-- VIAJES
-----------------------------------------------------

INSERT INTO Viaje
(
DniCliente,
DniChofer,
Fecha,
IdPago,
DireccionOrigen,
DireccionDestino,
IdCalificacion,
DistanciaKm,
DuracionMinutos,
ComentarioCliente,
IdEstado
)
VALUES

-- Finalizados
('30111222','22111222','2026-06-01 09:00',1,'Cabildo 100','Retiro',5,12.4,25,'Muy buen servicio',4),

('28999888','23333444','2026-06-03 18:00',2,'Congreso','Palermo',4,8.3,18,'Chofer muy amable',4),

('33444555','25555666','2026-06-05 10:30',3,'Recoleta','Belgrano',3,10.5,24,NULL,4),

('40123456','27777888','2026-06-08 20:00',4,'Once','Aeroparque',5,24.7,38,'Excelente viaje',4),

('30111222','23333444','2026-06-10 14:00',5,'Flores','Caballito',4,7.8,15,NULL,4),

-- En curso
('35777111','22111222','2026-06-20 18:00',NULL,'Villa Crespo','Nuñez',NULL,15.2,NULL,NULL,3),

-- Aceptado
('28999888','25555666','2026-06-22 12:00',NULL,'Almagro','Microcentro',NULL,9.8,NULL,NULL,2),

-- Solicitado
('40123456','23333444','2026-06-25 09:30',NULL,'Barracas','La Boca',NULL,6.5,NULL,NULL,1),

-- Cancelado
('33444555','27777888','2026-06-18 17:00',NULL,'Constitucion','Liniers',NULL,11.1,NULL,NULL,5);