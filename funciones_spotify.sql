use spotify;
-- Función para obtener todas las pistas de una lista de reproducción
CREATE FUNCTION dbo.ObtenerPistasEnLista (@id_lista INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.id AS id_pista,
        p.nombre AS nombre_pista,
        a.titulo AS titulo_album,
        art.nombre AS nombre_artista,
        g.nombre AS nombre_genero,
        p.milisegundos AS duracion_ms
    FROM pistas p
    INNER JOIN playlist_pistas pp ON p.id = pp.id_pista
    INNER JOIN albumes a ON p.id_album = a.id
    INNER JOIN artistas_albumes aa ON a.id = aa.id_album
    INNER JOIN artistas art ON aa.id_artista = art.id
    INNER JOIN generos g ON p.id_genero = g.id
    WHERE pp.id_playlist = @id_lista
);

-- Función para obtener suscripciones activas de un usuario
CREATE FUNCTION dbo.ObtenerSuscripcionesActivasUsuario (@id_usuario INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        s.id AS id_suscripcion,
        p.nombre AS nombre_plan,
        p.precio AS precio_plan,
        s.fecha_inicio AS fecha_inicio,
        s.fecha_fin AS fecha_fin
    FROM suscripciones s
    INNER JOIN planes p ON s.id_plan = p.id
    WHERE s.id_usuario = @id_usuario
    AND GETDATE() BETWEEN s.fecha_inicio AND s.fecha_fin
);

-- Función para obtener los artistas más populares por número de pistas
CREATE FUNCTION dbo.ObtenerArtistasMasPistas (@top_n INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@top_n)
        a.nombre AS nombre_artista,
        COUNT(p.id) AS cantidad_pistas
    FROM artistas a
    INNER JOIN artistas_albumes aa ON a.id = aa.id_artista
    INNER JOIN albumes alb ON aa.id_album = alb.id
    INNER JOIN pistas p ON alb.id = p.id_album
    GROUP BY a.nombre
    ORDER BY cantidad_pistas DESC
);

-- Función para obtener el historial de reproducción de un usuario
CREATE FUNCTION dbo.ObtenerHistorialReproduccion (@id_usuario INT, @dias_atras INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.nombre AS nombre_pista,
        a.titulo AS titulo_album,
        art.nombre AS nombre_artista,
        h.fecha_reproduccion AS fecha_reproduccion
    FROM historial h
    INNER JOIN pistas p ON h.id_pista = p.id
    INNER JOIN albumes a ON p.id_album = a.id
    INNER JOIN artistas_albumes aa ON a.id = aa.id_album
    INNER JOIN artistas art ON aa.id_artista = art.id
    WHERE h.id_usuario = @id_usuario
    AND h.fecha_reproduccion >= DATEADD(DAY, -@dias_atras, GETDATE())
);

