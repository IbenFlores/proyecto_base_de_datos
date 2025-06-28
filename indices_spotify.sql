use spotify;

-- Índice para pistas por álbum, género y tipo de medio
CREATE NONCLUSTERED INDEX IX_pistas_album_genero_tipo
ON pistas (id_album, id_genero, id_tipo_medio)
INCLUDE (nombre, milisegundos, precio_unitario);

-- Índice para historial por usuario y fecha
CREATE NONCLUSTERED INDEX IX_historial_usuario_fecha
ON historial (id_usuario, fecha_reproduccion)
INCLUDE (id_pista);

-- Índice para pistas en listas de reproducción
CREATE NONCLUSTERED INDEX IX_playlist_pistas_lista
ON playlist_pistas (id_playlist)
INCLUDE (id_pista);

-- Índice para suscripciones por usuario y fechas
CREATE NONCLUSTERED INDEX IX_suscripciones_usuario_fecha
ON suscripciones (id_usuario, fecha_inicio, fecha_fin)
INCLUDE (id_plan);

-- Índice para artistas por álbum
CREATE NONCLUSTERED INDEX IX_artistas_albumes_album
ON artistas_albumes (id_album)
INCLUDE (id_artista);

-- Índice para usuarios por correo
CREATE NONCLUSTERED INDEX IX_usuarios_correo
ON usuarios (correo)
INCLUDE (nombre, id);