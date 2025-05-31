use spotify_avance_2

-- ####################################################################
-- #                 PROCEDIMIENTOS ALMACENADOS SQL SERVER          #
-- ####################################################################

-- 1. Procedimiento para insertar un nuevo artista.
-- Toma el nombre del artista como parámetro e inserta un nuevo registro en la tabla 'artistas'.
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
-- Toma el ID de un álbum y devuelve una lista de todas las pistas de ese álbum.
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
EXEC sp_ObtenerPistasPorAlbum 10; -- Suponiendo que 10 es un ID de álbum válido


-- 3. PROCEDIMIENTO: sp_RegistrarNuevaSuscripcion
-- DESCRIPCIÓN: Registra una nueva suscripción para un usuario dado un plan.
--              Verifica si el usuario y el plan existen. Si el plan tiene duración,
--              calcula la fecha de fin. Si el usuario ya tiene una suscripción activa,
--              se podría manejar de diferentes maneras (aquí, simplemente se inserta una nueva,
--              pero en un sistema real se podría actualizar la existente o prohibir múltiples).
-- PARÁMETROS:
--   @id_usuario INT: El ID del usuario que se suscribe.
--   @id_plan INT: El ID del plan al que el usuario se suscribe.
-- RESULTADO:
--   Un mensaje de éxito o error.
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
-- Registrar una suscripción Premium Anual (ID 3) para el usuario 1 (si ya tiene una, se añade otra)
EXEC sp_RegistrarNuevaSuscripcion @id_usuario = 1, @id_plan = 3;

-- Registrar una suscripción Estándar (ID 2) para el usuario 6 (Diego Castro)
EXEC sp_RegistrarNuevaSuscripcion @id_usuario = 6, @id_plan = 2;


-- 4. PROCEDIMIENTO: sp_ObtenerTopPistasPorGenero
-- DESCRIPCIÓN: Devuelve las N pistas más reproducidas para un género específico.
--              Calcula el conteo de reproducciones de cada pista dentro del género
--              y las ordena de mayor a menor.
-- PARÁMETROS:
--   @id_genero INT: El ID del género para el cual se buscarán las pistas.
--   @top_n INT: El número de pistas principales a devolver.
-- RESULTADO:
--   Un conjunto de resultados con las pistas principales y su conteo de reproducciones.
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

-- Ejemplo de uso:
-- Obtener las 3 pistas de Rock (ID 1) más reproducidas
EXEC sp_ObtenerTopPistasPorGenero @id_genero = 1, @top_n = 3;

-- Obtener las 5 pistas de Pop (ID 2) más reproducidas
EXEC sp_ObtenerTopPistasPorGenero @id_genero = 2, @top_n = 5;



