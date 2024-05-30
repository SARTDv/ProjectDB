
-- Creacion de los tipos de datos necesarios
-- creacion del tiopo direccion
CREATE TYPE Direccion AS (
    Ciudad VARCHAR(100),
    Direccion VARCHAR(200)
);
--Creacion del tipo estado_enum que se usara en la relacion estado
CREATE TYPE estado_enum AS ENUM ('solicitado', 'recogido', 'entregado');
--creacion del tipo  transporte_enum que se usara en servicio
CREATE TYPE transporte_enum AS ENUM ('moto ','carro ','camion');
--Creacion de todas las tablas necesarias para la BD
CREATE TABLE IF NOT EXISTS Cliente (
    cId INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion Direccion,
    Email VARCHAR(100),
    Telefono VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Sucursal (
    SucursalID INT,
    ClienteID INT,
    Nombre VARCHAR(100),
    Direccion Direccion,
    Telefono VARCHAR(20),
    PRIMARY KEY (SucursalID, ClienteID),
    FOREIGN KEY (ClienteID) REFERENCES Cliente(cId)
);

CREATE TABLE IF NOT EXISTS Usuario (
    uLogin VARCHAR(50) PRIMARY KEY,
    Contrasena VARCHAR(50) NOT NULL,
    Direccion Direccion,
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(cId)
);

CREATE TABLE IF NOT EXISTS Mensajero (
    Identificacion INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion Direccion,
    Email VARCHAR(100),
    Telefono VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Servicio (
    Codigo SERIAL PRIMARY KEY,
    FechaHoraSolicitud TIMESTAMP NOT NULL,
    Origen Direccion,
    Destino Direccion,
    Descripcion TEXT,
    TipoTransporte transporte_enum NOT NULL,
    NumPaquetes INT,
    Usuario_Login VARCHAR(50),
    Mensajero_ID INT,
    FOREIGN KEY (Usuario_Login) REFERENCES Usuario(uLogin),
    FOREIGN KEY (Mensajero_ID) REFERENCES Mensajero(Identificacion)
);
CREATE TABLE IF NOT EXISTS Estado (
    ID SERIAL PRIMARY KEY,
    Estado estado_enum DEFAULT 'solicitado' NOT NULL,
    FechaHora TIMESTAMP NOT NULL,
    Foto BYTEA,
    Servicio_Codigo INT,
    FOREIGN KEY (Servicio_Codigo) REFERENCES Servicio(Codigo)
);

-- inserciones default para probar el correcto funcionamiento de las consultas
INSERT INTO Cliente (cId, Nombre, Direccion, Email, Telefono)
VALUES ('12345', 'Default', ROW('Ciudad :', 'Dirección:'), 'default@default.com', 'default');
INSERT INTO Usuario (uLogin,Contrasena,Direccion,Telefono,Email,Cliente_ID)
VALUES ('default','default',ROW('Ciudad :', 'Dirección:'),'default','default@default.com','12345')
