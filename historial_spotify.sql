USE spotify;
GO

-- Ejecutar el script completo
-- Declarar una variable para el ID del usuario actual.
-- Puedes cambiar este valor para ver el historial de diferentes usuarios.
DECLARE @id_usuario_actual INT = 1; -- Ejemplo: Andrea Rodriguez (Plan Premium)
-- DECLARE @id_usuario_actual INT = 3; -- Ejemplo: Laura Torres (Plan Gratis)
-- DECLARE @id_usuario_actual INT = 2; -- Ejemplo: Carlos Mendoza (Plan Est�ndar)

-- Declarar una variable para almacenar el ID del plan del usuario actual
DECLARE @id_plan_usuario_actual INT;

PRINT N'--- Historial Avanzado para el Usuario ID: ' + CAST(@id_usuario_actual AS NVARCHAR(10)) + ' ---';
PRINT N'';
-- Obtener el ID del plan del usuario actual
SELECT @id_plan_usuario_actual = s.id_plan
FROM suscripciones s
WHERE s.id_usuario = @id_usuario_actual;

PRINT N'--- Historial Avanzado para el Usuario ID: ' + CAST(@id_usuario_actual AS NVARCHAR(10)) + ' ---';
PRINT N'';

-- ###############################################################
-- #                 PARTE 1: TU HISTORIAL RECIENTE              #
-- ###############################################################
-- Esta secci�n muestra las �ltimas canciones que ha reproducido el usuario actual.
-- La cantidad de pistas mostradas var�a seg�n el tipo de suscripci�n.

PRINT N'--- 1. Tu Historial Reciente ---';
IF @id_plan_usuario_actual = 1 -- Plan Gratis
BEGIN
    PRINT N'Mostrando las �ltimas 5 pistas para usuarios con Plan Gratis.';
    SELECT TOP 5
        'Tu Historial' AS Origen,
        h.fecha_reproduccion AS Fecha_Reproduccion,
        u.nombre AS Usuario_Reproduccion,
        p.nombre AS Pista_Nombre,
        a.nombre AS Artista_Principal,
        al.titulo AS Album_Titulo,
        g.nombre AS Genero_Nombre,
        tm.nombre AS Tipo_Medio_Nombre,
        p.milisegundos AS Duracion_Milisegundos
    FROM
        historial h
    INNER JOIN
        usuarios u ON h.id_usuario = u.id
    INNER JOIN
        pistas p ON h.id_pista = p.id
    INNER JOIN
        albumes al ON p.id_album = al.id
    INNER JOIN
        artistas_albumes aa ON al.id = aa.id_album
    INNER JOIN
        artistas a ON aa.id_artista = a.id
    INNER JOIN
        generos g ON p.id_genero = g.id
    INNER JOIN
        tipos_medios tm ON p.id_tipo_medio = tm.id
    WHERE
        h.id_usuario = @id_usuario_actual
    ORDER BY
        h.fecha_reproduccion DESC;
END
ELSE IF @id_plan_usuario_actual = 2 -- Plan Est�ndar
BEGIN
    PRINT N'Mostrando las �ltimas 10 pistas para usuarios con Plan Est�ndar.';
    SELECT TOP 10
        'Tu Historial' AS Origen,
        h.fecha_reproduccion AS Fecha_Reproduccion,
        u.nombre AS Usuario_Reproduccion,
        p.nombre AS Pista_Nombre,
        a.nombre AS Artista_Principal,
        al.titulo AS Album_Titulo,
        g.nombre AS Genero_Nombre,
        tm.nombre AS Tipo_Medio_Nombre,
        p.milisegundos AS Duracion_Milisegundos
    FROM
        historial h
    INNER JOIN
        usuarios u ON h.id_usuario = u.id
    INNER JOIN
        pistas p ON h.id_pista = p.id
    INNER JOIN
        albumes al ON p.id_album = al.id
    INNER JOIN
        artistas_albumes aa ON al.id = aa.id_album
    INNER JOIN
        artistas a ON aa.id_artista = a.id
    INNER JOIN
        generos g ON p.id_genero = g.id
    INNER JOIN
        tipos_medios tm ON p.id_tipo_medio = tm.id
    WHERE
        h.id_usuario = @id_usuario_actual
    ORDER BY
        h.fecha_reproduccion DESC;
END
ELSE -- Plan Premium
BEGIN
    PRINT N'Mostrando las �ltimas 20 pistas para usuarios con Plan Premium.';
    SELECT TOP 20
        'Tu Historial' AS Origen,
        h.fecha_reproduccion AS Fecha_Reproduccion,
        u.nombre AS Usuario_Reproduccion,
        p.nombre AS Pista_Nombre,
        a.nombre AS Artista_Principal,
        al.titulo AS Album_Titulo,
        g.nombre AS Genero_Nombre,
        tm.nombre AS Tipo_Medio_Nombre,
        p.milisegundos AS Duracion_Milisegundos
    FROM
        historial h
    INNER JOIN
        usuarios u ON h.id_usuario = u.id
    INNER JOIN
        pistas p ON h.id_pista = p.id
    INNER JOIN
        albumes al ON p.id_album = al.id
    INNER JOIN
        artistas_albumes aa ON al.id = aa.id_album
    INNER JOIN
        artistas a ON aa.id_artista = a.id
    INNER JOIN
        generos g ON p.id_genero = g.id
    INNER JOIN
        tipos_medios tm ON p.id_tipo_medio = tm.id
    WHERE
        h.id_usuario = @id_usuario_actual
    ORDER BY
        h.fecha_reproduccion DESC;
END;

PRINT N'';

-- ###############################################################
-- #             PARTE 2: ACTIVIDAD DE USUARIOS QUE SIGUES       #
-- ###############################################################
-- Esta secci�n muestra la actividad reciente de los usuarios que el usuario actual sigue.
-- Es una funci�n limitada o exclusiva para planes de pago.

PRINT N'--- 2. Actividad Reciente de Usuarios que Sigues ---';
IF @id_plan_usuario_actual = 1 -- Plan Gratis
BEGIN
    PRINT N'Esta funci�n est� limitada para usuarios con Plan Gratis. �Considera actualizar tu plan para ver la actividad de tus amigos!';
END
ELSE IF @id_plan_usuario_actual = 2 -- Plan Est�ndar
BEGIN
    PRINT N'Mostrando las �ltimas 10 actividades de usuarios seguidos para usuarios con Plan Est�ndar.';
    SELECT TOP 10
        'Actividad de Seguidos' AS Origen,
        h.fecha_reproduccion AS Fecha_Reproduccion,
        u_seguido.nombre AS Usuario_Reproduccion,
        p.nombre AS Pista_Nombre,
        a.nombre AS Artista_Principal,
        al.titulo AS Album_Titulo,
        g.nombre AS Genero_Nombre,
        tm.nombre AS Tipo_Medio_Nombre,
        p.milisegundos AS Duracion_Milisegundos
    FROM
        seguimientos s
    INNER JOIN
        historial h ON s.id_seguido = h.id_usuario
    INNER JOIN
        usuarios u_seguido ON h.id_usuario = u_seguido.id
    INNER JOIN
        pistas p ON h.id_pista = p.id
    INNER JOIN
        albumes al ON p.id_album = al.id
    INNER JOIN
        artistas_albumes aa ON al.id = aa.id_album
    INNER JOIN
        artistas a ON aa.id_artista = a.id
    INNER JOIN
        generos g ON p.id_genero = g.id
    INNER JOIN
        tipos_medios tm ON p.id_tipo_medio = tm.id
    WHERE
        s.id_seguidor = @id_usuario_actual
        AND h.id_usuario <> @id_usuario_actual -- Excluir la propia actividad si ya se incluy� arriba
    ORDER BY
        h.fecha_reproduccion DESC;
END
ELSE -- Plan Premium
BEGIN

    PRINT N'Mostrando las �ltimas 20 actividades de usuarios seguidos para usuarios con Plan Premium.';
    SELECT TOP 20
        'Actividad de Seguidos' AS Origen,
        h.fecha_reproduccion AS Fecha_Reproduccion,
        u_seguido.nombre AS Usuario_Reproduccion,
        p.nombre AS Pista_Nombre,
        a.nombre AS Artista_Principal,
        al.titulo AS Album_Titulo,
        g.nombre AS Genero_Nombre,
        tm.nombre AS Tipo_Medio_Nombre,
        p.milisegundos AS Duracion_Milisegundos
    FROM
        seguimientos s
    INNER JOIN
        historial h ON s.id_seguido = h.id_usuario
    INNER JOIN
        usuarios u_seguido ON h.id_usuario = u_seguido.id
    INNER JOIN
        pistas p ON h.id_pista = p.id
    INNER JOIN
        albumes al ON p.id_album = al.id
    INNER JOIN
        artistas_albumes aa ON al.id = aa.id_album
    INNER JOIN
        artistas a ON aa.id_artista = a.id
    INNER JOIN
        generos g ON p.id_genero = g.id
    INNER JOIN
        tipos_medios tm ON p.id_tipo_medio = tm.id
    WHERE
        s.id_seguidor = @id_usuario_actual
        AND h.id_usuario <> @id_usuario_actual -- Excluir la propia actividad si ya se incluy� arriba
    ORDER BY
        h.fecha_reproduccion DESC;
END;

PRINT N'';

-- ###############################################################
-- #             PARTE 3: AN�LISIS DE H�BITOS DE ESCUCHA         #
-- ###############################################################
-- Esta secci�n proporciona un resumen de los g�neros m�s escuchados por el usuario
-- y los artistas m�s populares en su historial.

PRINT N'--- 3. An�lisis de H�bitos de Escucha ---';

-- 3.1 Top 5 G�neros M�s Escuchados por el Usuario
PRINT N'--- Top 5 G�neros M�s Escuchados ---';
SELECT TOP 5
    g.nombre AS Genero,
    COUNT(h.id_pista) AS Total_Reproducciones
FROM
    historial h
INNER JOIN
    pistas p ON h.id_pista = p.id
INNER JOIN
    generos g ON p.id_genero = g.id
WHERE
    h.id_usuario = @id_usuario_actual
GROUP BY
    g.nombre
ORDER BY
    Total_Reproducciones DESC;

PRINT N'';

-- 3.2 Top 5 Artistas M�s Escuchados por el Usuario
PRINT N'--- Top 5 Artistas M�s Escuchados ---';
SELECT TOP 5
    ar.nombre AS Artista,
    COUNT(h.id_pista) AS Total_Reproducciones
FROM
    historial h
INNER JOIN
    pistas p ON h.id_pista = p.id
INNER JOIN
    albumes al ON p.id_album = al.id
INNER JOIN
    artistas_albumes aa ON al.id = aa.id_album
INNER JOIN
    artistas ar ON aa.id_artista = ar.id
WHERE
    h.id_usuario = @id_usuario_actual
GROUP BY
    ar.nombre
ORDER BY
    Total_Reproducciones DESC;

PRINT N'';

-- ###############################################################
-- #             PARTE 4: INFORMACI�N DE SUSCRIPCI�N DEL USUARIO #
-- ###############################################################
-- Esta secci�n muestra la informaci�n del plan de suscripci�n del usuario actual.


-------
PRINT N'--- 4. Tu Informaci�n de Suscripci�n ---';
SELECT
    u.nombre AS Nombre_Usuario,
    p.nombre AS Nombre_Plan,
    p.precio AS Precio_Plan,
    s.fecha_inicio AS Fecha_Inicio_Suscripcion,
    s.fecha_fin AS Fecha_Fin_Suscripcion,
    CASE
        WHEN s.fecha_fin IS NULL THEN 'N/A (Gratis o Sin Fecha Fin)'
        WHEN s.fecha_fin >= GETDATE() THEN 'Activa'
        ELSE 'Expirada'
    END AS Estado_Suscripcion
FROM
    usuarios u
INNER JOIN
    suscripciones s ON u.id = s.id_usuario
INNER JOIN
    planes p ON s.id_plan = p.id
WHERE
    u.id = @id_usuario_actual;

PRINT N'';

