CREATE DATABASE EmpresaTransporte;
GO

USE EmpresaTransporte;
GO

CREATE TABLE [Cliente] (
	[Dni] VARCHAR(10) NOT NULL CHECK(LEN(Dni) BETWEEN 7 AND 8 AND Dni NOT LIKE '%[^0-9]%'),
	[Nombre] VARCHAR(40) NOT NULL,
	[Apellido] VARCHAR(40) NOT NULL,
	[NumeroTelefono] VARCHAR(20) NOT NULL CHECK(LEN(NumeroTelefono) BETWEEN 8 AND 16 AND NumeroTelefono NOT LIKE '%[^0-9]%'),
	[Direccion] VARCHAR(100),
	[FechaNacimiento] DATE NOT NULL CHECK(FechaNacimiento <= Getdate()),

	PRIMARY KEY([Dni])
);
GO

CREATE TABLE [TipoVehiculo] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[Descripcion] VARCHAR(50) NOT NULL UNIQUE,
	[TarifaBase] SMALLMONEY NOT NULL,

	PRIMARY KEY([Id])
);
GO

CREATE TABLE [Turno] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[HoraInicio] TIME NOT NULL,
	[HoraFin] TIME NOT NULL,

	PRIMARY KEY([Id]),
	CHECK(HoraInicio <> HoraFin)
);
GO

CREATE TABLE [Calificacion] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[Puntaje] TINYINT NOT NULL UNIQUE CHECK (Puntaje BETWEEN 1 AND 5),
	[Descripcion] VARCHAR(20) NOT NULL UNIQUE,

	PRIMARY KEY([Id])
);
GO

CREATE TABLE [MetodoPago] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[Descripcion] VARCHAR(40) NOT NULL UNIQUE,

	PRIMARY KEY([Id])
);
GO

CREATE TABLE [EstadoViaje] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[Descripcion] VARCHAR(40) NOT NULL UNIQUE CHECK(Descripcion IN('Solicitado', 'Aceptado', 'En curso', 'Finalizado', 'Cancelado')),

	PRIMARY KEY([Id])
);
GO

CREATE TABLE [Chofer] (
	[Dni] VARCHAR(10) NOT NULL CHECK(LEN(Dni) BETWEEN 7 AND 8 AND Dni NOT LIKE '%[^0-9]%'),
	[Nombre] VARCHAR(40) NOT NULL,
	[Apellido] VARCHAR(40) NOT NULL,
	[NumeroTelefono] VARCHAR(20) NOT NULL CHECK(LEN(NumeroTelefono) BETWEEN 8 AND 16 AND NumeroTelefono NOT LIKE '%[^0-9]%'),
	[Direccion] VARCHAR(100),
	[FechaIncorporacion] DATE NOT NULL CHECK(FechaIncorporacion <= Getdate()),
	[IdTurno] INTEGER NOT NULL,

	PRIMARY KEY([Dni]),
	FOREIGN KEY (IdTurno) REFERENCES Turno(Id)
);
GO

CREATE TABLE [Pago] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[IdMetodoPago] INTEGER NOT NULL,
	[Monto] SMALLMONEY NOT NULL,
	[Fecha] DATETIME NOT NULL,

	PRIMARY KEY([Id]),
	FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPago(Id)
);
GO

CREATE TABLE [Viaje] (
	[Id] INTEGER NOT NULL IDENTITY(1,1),
	[DniCliente] VARCHAR(10) NOT NULL,
	[DniChofer] VARCHAR(10) NOT NULL,
	[Fecha] DATETIME NOT NULL,
	[IdPago] INTEGER UNIQUE,
	[DireccionOrigen] VARCHAR(100) NOT NULL,
	[DireccionDestino] VARCHAR(100) NOT NULL,
	[IdCalificacion] INTEGER,
	[DistanciaKm] DECIMAL(5, 2) NOT NULL CHECK (DistanciaKm > 0),
	[DuracionMinutos] SMALLINT CHECK (DuracionMinutos > 0),
	[ComentarioCliente] VARCHAR(250),
	[IdEstado] INTEGER NOT NULL,

	PRIMARY KEY([Id]),
	FOREIGN KEY (DniCliente) REFERENCES Cliente(Dni),
	FOREIGN KEY (DniChofer) REFERENCES Chofer(Dni),
	FOREIGN KEY (IdPago) REFERENCES Pago(Id),
	FOREIGN KEY (IdCalificacion) REFERENCES Calificacion(Id),
	FOREIGN KEY (IdEstado) REFERENCES EstadoViaje(Id)
);
GO

CREATE TABLE [Remis] (
	[Patente] VARCHAR(10) NOT NULL CHECK(LEN(Patente) BETWEEN 6 AND 7),
	[Marca] VARCHAR(40) NOT NULL,
	[Modelo] VARCHAR(40) NOT NULL,
	[Anio] SMALLINT NOT NULL CHECK(Anio BETWEEN 1970 AND Year(Getdate())),
	[DniChofer] VARCHAR(10) NOT NULL UNIQUE,
	[IdTipoVehiculo] INTEGER NOT NULL,

	PRIMARY KEY([Patente]),
	FOREIGN KEY (DniChofer) REFERENCES Chofer(Dni),
	FOREIGN KEY (IdTipoVehiculo) REFERENCES TipoVehiculo(Id)
);
GO

CREATE TABLE AuditoriaViaje
(
    [Id] INTEGER NOT NULL IDENTITY(1,1),
    [IdViaje] INTEGER NOT NULL,
    [Operacion] VARCHAR(10) NOT NULL,
    [Fecha] DATETIME NOT NULL DEFAULT GETDATE(),

	PRIMARY KEY ([Id])
);
GO

