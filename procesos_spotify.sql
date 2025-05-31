-- ####################################################################
-- #                 PROCEDIMIENTOS ALMACENADOS SQL SERVER           #
-- ####################################################################

-- 1. Procedimiento para insertar un nuevo artista.
GO
CREATE PROCEDURE sp_InsertarNuevoArtista
    @nombre_artista VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON; -- Evita que se devuelva el recuento de filas afectadas

    INSERT INTO artistas (nombre)
    VALUES (@nombre_artista);

    SELECT 'Artista insertado correctamente con ID: ' + CAST(SCOPE_IDENTITY() AS VARCHAR(10)) AS Mensaje;
END;
GO

-- Ejemplo de uso:
EXEC sp_InsertarNuevoArtista 'Nuevo Artista Ejemplo';


-- 2. Procedimiento para obtener todas las pistas de un álbum específico.
GO
CREATE PROCEDURE sp_ObtenerPistasPorAlbum
    @id_album INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.id,
        p.nombre AS NombrePista,
        p.compositor,
        p.milisegundos,
        p.bytes,
        p.precio_unitario,
        tm.nombre AS TipoMedio,
        g.nombre AS Genero
    FROM pistas AS p
    JOIN tipos_medios AS tm ON p.id_tipo_medio = tm.id
    JOIN generos AS g ON p.id_genero = g.id
    WHERE p.id_album = @id_album
    ORDER BY p.nombre;
END;
GO

-- Ejemplo de uso:
EXEC sp_ObtenerPistasPorAlbum 10;


-- 3. Procedimiento para registrar una nueva suscripción
GO
CREATE PROCEDURE sp_RegistrarNuevaSuscripcion
    @id_usuario INT,
    @id_plan INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @fecha_inicio DATE = GETDATE();
    DECLARE @fecha_fin DATE;
    DECLARE @duracion_meses INT;
    DECLARE @nombre_plan VARCHAR(100);

    -- Verificar si el usuario existe
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE id = @id_usuario)
    BEGIN
        SELECT 'Error: El usuario con el ID especificado no existe.' AS Mensaje;
        RETURN;
    END;

    -- Verificar si el plan existe y obtener su duración
    SELECT @duracion_meses = duracion_meses, @nombre_plan = nombre
    FROM planes
    WHERE id = @id_plan;

    IF @duracion_meses IS NULL AND @nombre_plan IS NULL
    BEGIN
        SELECT 'Error: El plan con el ID especificado no existe.' AS Mensaje;
        RETURN;
    END;

    -- Calcular fecha_fin si el plan tiene duración
    IF @duracion_meses IS NOT NULL
    BEGIN
        SET @fecha_fin = DATEADD(month, @duracion_meses, @fecha_inicio);
    END
    ELSE
    BEGIN
        SET @fecha_fin = NULL; -- Para planes gratuitos sin fecha de fin
    END;

    -- Insertar la nueva suscripción
    INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin)
    VALUES (@id_usuario, @id_plan, @fecha_inicio, @fecha_fin);

    SELECT 'Suscripción al plan "' + @nombre_plan + '" registrada correctamente para el usuario ' + CAST(@id_usuario AS VARCHAR(10)) AS Mensaje;
END;
GO

-- Ejemplo de uso:
EXEC sp_RegistrarNuevaSuscripcion @id_usuario = 1, @id_plan = 3;


-- 4. Procedimiento para obtener las pistas más reproducidas por género
GO
CREATE PROCEDURE sp_ObtenerTopPistasPorGenero
    @id_genero INT,
    @top_n INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el género existe
    IF NOT EXISTS (SELECT 1 FROM generos WHERE id = @id_genero)
    BEGIN
        SELECT 'Error: El género con el ID especificado no existe.' AS Mensaje;
        RETURN;
    END;

    SELECT TOP (@top_n)
        p.id AS ID_Pista,
        p.nombre AS NombrePista,
        g.nombre AS Genero,
        COUNT(h.id) AS TotalReproducciones
    FROM
        pistas AS p
    JOIN
        historial AS h ON p.id = h.id_pista
    JOIN
        generos AS g ON p.id_genero = g.id
    WHERE
        p.id_genero = @id_genero
    GROUP BY
        p.id, p.nombre, g.nombre
    ORDER BY
        TotalReproducciones DESC;
END;
GO

-- Ejemplo de uso:
EXEC sp_ObtenerTopPistasPorGenero @id_genero = 1, @top_n = 3;
EXEC sp_ObtenerTopPistasPorGenero @id_genero = 2, @top_n = 5;
