use spotify_avance_2

-- ####################################################################
-- #                          NUEVAS VISTAS                           #
-- ####################################################################

-- 1. VISTA: vw_PistasConDetallesCompletos
-- DESCRIPCIÓN: Proporciona una vista completa de cada pista, incluyendo su nombre, compositor,
--              duración en segundos, tamaño en bytes, precio unitario, y los nombres
--              del álbum al que pertenece, el artista principal del álbum, el género y el tipo de medio.
CREATE VIEW vw_PistasConDetallesCompletos AS
SELECT
    p.id AS ID_Pista,
    p.nombre AS NombrePista,
    p.compositor,
    CAST(p.milisegundos AS DECIMAL(10, 2)) / 1000.00 AS DuracionSegundos,
    p.bytes AS TamanoBytes,
    p.precio_unitario AS PrecioUnitario,
    a.titulo AS NombreAlbum,
    ISNULL(art.nombre, 'Varios Artistas') AS NombreArtistaPrincipal, -- Maneja álbumes con múltiples artistas o sin artista principal claro
    g.nombre AS GeneroMusical,
    tm.nombre AS TipoDeMedio
FROM
    pistas AS p
LEFT JOIN
    albumes AS a ON p.id_album = a.id
LEFT JOIN
    artistas_albumes AS aa ON a.id = aa.id_album
LEFT JOIN
    artistas AS art ON aa.id_artista = art.id
LEFT JOIN
    generos AS g ON p.id_genero = g.id
LEFT JOIN
    tipos_medios AS tm ON p.id_tipo_medio = tm.id;


-- Ejemplo de uso:
SELECT * FROM vw_PistasConDetallesCompletos WHERE GeneroMusical = 'Rock';


-- 2. VISTA: vw_UsuariosConEstadoSuscripcion
-- DESCRIPCIÓN: Muestra información detallada de cada usuario junto con el nombre
--              de su plan de suscripción actual y una indicación si la suscripción está activa.
--              Incluye la fecha de inicio y fin de la suscripción.
CREATE VIEW vw_UsuariosConEstadoSuscripcion AS
SELECT
    u.id AS ID_Usuario,
    u.nombre AS NombreUsuario,
    u.correo AS CorreoUsuario,
    u.fecha_registro AS FechaRegistroUsuario,
    ISNULL(p.nombre, 'No Suscrito / Gratuito') AS PlanSuscripcion,
    s.fecha_inicio AS FechaInicioSuscripcion,
    s.fecha_fin AS FechaFinSuscripcion,
    CASE
        WHEN s.fecha_fin IS NULL THEN 'Activa (Sin Fin)' -- Para planes gratuitos
        WHEN s.fecha_fin >= GETDATE() THEN 'Activa'
        ELSE 'Expirada'
    END AS EstadoSuscripcion
FROM
    usuarios AS u
LEFT JOIN
    suscripciones AS s ON u.id = s.id_usuario
LEFT JOIN
    planes AS p ON s.id_plan = p.id;

-- Ejemplo de uso:
SELECT * FROM vw_UsuariosConEstadoSuscripcion WHERE EstadoSuscripcion = 'Activa';


-- 3. VISTA: vw_HistorialReproduccionDetallado
-- DESCRIPCIÓN: Proporciona un registro detallado de cada reproducción de pista,
--              incluyendo el usuario que la reprodujo, la pista, el álbum, el artista,
--              el género y el tipo de medio, junto con la fecha y hora de la reproducción.
CREATE VIEW vw_HistorialReproduccionDetallado AS
SELECT
    h.id AS ID_Historial,
    h.fecha_reproduccion AS FechaReproduccion,
    u.nombre AS NombreUsuario,
    u.correo AS CorreoUsuario,
    p.nombre AS NombrePista,
    a.titulo AS NombreAlbum,
    ISNULL(art.nombre, 'Varios Artistas') AS NombreArtistaPista,
    g.nombre AS GeneroMusical,
    tm.nombre AS TipoDeMedio
FROM
    historial AS h
JOIN
    usuarios AS u ON h.id_usuario = u.id
JOIN
    pistas AS p ON h.id_pista = p.id
LEFT JOIN
    albumes AS a ON p.id_album = a.id
LEFT JOIN
    artistas_albumes AS aa ON a.id = aa.id_album
LEFT JOIN
    artistas AS art ON aa.id_artista = art.id
LEFT JOIN
    generos AS g ON p.id_genero = g.id
LEFT JOIN
    tipos_medios AS tm ON p.id_tipo_medio = tm.id;

-- Ejemplo de uso:
SELECT * FROM vw_HistorialReproduccionDetallado WHERE NombreUsuario = 'Andrea Rodriguez';


-- 4. VISTA: vw_AlbumesConConteoPistasYArtistas
-- DESCRIPCIÓN: Muestra cada álbum con el conteo de pistas que contiene y una lista
--              concatenada de todos los artistas asociados a ese álbum.
CREATE VIEW vw_AlbumesConConteoPistasYArtistas AS
SELECT
    a.id AS ID_Album,
    a.titulo AS TituloAlbum,
    COUNT(DISTINCT p.id) AS CantidadPistas,
    STUFF((
        SELECT ', ' + art.nombre
        FROM artistas_albumes AS aa_inner
        JOIN artistas AS art ON aa_inner.id_artista = art.id
        WHERE aa_inner.id_album = a.id
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ArtistasDelAlbum
FROM
    albumes AS a
LEFT JOIN
    pistas AS p ON a.id = p.id_album
LEFT JOIN
    artistas_albumes AS aa ON a.id = aa.id_album
GROUP BY
    a.id, a.titulo;

-- Ejemplo de uso:
SELECT * FROM vw_AlbumesConConteoPistasYArtistas WHERE CantidadPistas > 5;


-- 5. VISTA: vw_PlaylistsConPropietarioYCuentasPistas
-- DESCRIPCIÓN: Muestra cada playlist con el nombre de su propietario (usuario)
--              y el número total de pistas que contiene.
CREATE VIEW vw_PlaylistsConPropietarioYCuentasPistas AS
SELECT
    pl.id AS ID_Playlist,
    pl.nombre AS NombrePlaylist,
    u.nombre AS PropietarioPlaylist,
    pl.fecha_creacion AS FechaCreacionPlaylist,
    COUNT(pp.id_pista) AS CantidadPistas
FROM
    playlists AS pl
JOIN
    usuarios AS u ON pl.id_usuario = u.id
LEFT JOIN
    playlist_pistas AS pp ON pl.id = pp.id_playlist
GROUP BY
    pl.id, pl.nombre, u.nombre, pl.fecha_creacion;

-- Ejemplo de uso:
SELECT * FROM vw_PlaylistsConPropietarioYCuentasPistas WHERE PropietarioPlaylist = 'Andrea Rodriguez';