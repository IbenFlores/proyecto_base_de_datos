create database spotify;
use spotify;

-- Crear la tabla artistas
CREATE TABLE artistas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255)
);

-- Crear la tabla generos
CREATE TABLE generos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255)
);

-- Crear la tabla tipos_medios
CREATE TABLE tipos_medios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255)
);

-- Crear la tabla albumes
CREATE TABLE albumes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(255)
);

-- Crear la tabla intermedia artistas_albumes
CREATE TABLE artistas_albumes (
    id_artista INT,
    id_album INT,
    PRIMARY KEY (id_artista, id_album), -- Clave primaria compuesta
    CONSTRAINT fk_artistas_albumes_artistas FOREIGN KEY (id_artista) REFERENCES artistas(id),
    CONSTRAINT fk_artistas_albumes_albumes FOREIGN KEY (id_album) REFERENCES albumes(id)

);

-- Crear la tabla pistas
CREATE TABLE pistas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_album INT,
    id_tipo_medio INT,
    id_genero INT,
    nombre VARCHAR(255),
    compositor VARCHAR(255),
    milisegundos INT,
    bytes INT,
    precio_unitario INT,
    CONSTRAINT fk_pistas_albumes FOREIGN KEY (id_album) REFERENCES albumes(id),
    CONSTRAINT fk_pistas_tipos_medios FOREIGN KEY (id_tipo_medio) REFERENCES tipos_medios(id),
    CONSTRAINT fk_pistas_generos FOREIGN KEY (id_genero) REFERENCES�generos(id)

);
-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    contrase�a VARCHAR(255) NOT NULL,
    fecha_registro DATE DEFAULT GETDATE()
);
-- Crear la tabla de playlist (lista de reproduccion)
CREATE TABLE playlists (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    id_usuario INT,
    fecha_creacion DATE DEFAULT GETDATE(),
    CONSTRAINT fk_playlists_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);
-- Creando tabla que conecta playlist y pistas
CREATE TABLE playlist_pistas (
    id_playlist INT,
    id_pista INT,
    PRIMARY KEY (id_playlist, id_pista),
    CONSTRAINT fk_playlist_pistas_playlist FOREIGN KEY (id_playlist) REFERENCES playlists(id),
    CONSTRAINT fk_playlist_pistas_pista FOREIGN KEY (id_pista) REFERENCES pistas(id)
);
--Creando tabla Planes Usuario
CREATE TABLE planes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2),
    duracion_meses INT
);
--Creando tabla Suscripciones 
CREATE TABLE suscripciones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT,
    id_plan INT,
    fecha_inicio DATE DEFAULT GETDATE(),
    fecha_fin DATE,
    CONSTRAINT fk_suscripciones_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    CONSTRAINT fk_suscripciones_planes FOREIGN KEY (id_plan) REFERENCES planes(id)
);
--creando tabla historial de Reproducci�n
CREATE TABLE historial (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT,
    id_pista INT,
    fecha_reproduccion DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_historial_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    CONSTRAINT fk_historial_pista FOREIGN KEY (id_pista) REFERENCES pistas(id)
);

CREATE TABLE seguimientos (
    id_seguidor INT,
    id_seguido INT,
    fecha_creacion DATETIME DEFAULT GETDATE(), -- Almacena la fecha y hora del seguimiento
    PRIMARY KEY (id_seguidor, id_seguido), -- Clave primaria compuesta para asegurar unicidad y evitar duplicados
    CONSTRAINT fk_seguimientos_seguidor FOREIGN KEY (id_seguidor) REFERENCES usuarios(id),
    CONSTRAINT fk_seguimientos_seguido FOREIGN KEY (id_seguido) REFERENCES usuarios(id)
);



