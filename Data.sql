use spotify_avance_2

-- ###############################################################
-- #                    INSERCIÓN DE DATOS                       #
-- ###############################################################

-- Insertar datos en la tabla artistas
SET IDENTITY_INSERT artistas ON;
INSERT INTO artistas (id, nombre) VALUES
(1, 'The Beatles'),
(2, 'Shakira'),
(3, 'Bad Bunny'),
(4, 'Radiohead'),
(5, 'Adele'),
(6, 'Queen'),
(7, 'J Balvin'),
(8, 'Billie Eilish'),
(9, 'Metallica'),
(10, 'Rosalia');
SET IDENTITY_INSERT artistas OFF;

-- Insertar datos en la tabla generos
SET IDENTITY_INSERT generos ON;
INSERT INTO generos (id, nombre) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Reggaeton'),
(4, 'Metal'),
(5, 'Indie');
SET IDENTITY_INSERT generos OFF;

-- Insertar datos en la tabla tipos_medios
SET IDENTITY_INSERT tipos_medios ON;
INSERT INTO tipos_medios (id, nombre) VALUES
(1, 'MP3'),
(2, 'WAV'),
(3, 'AAC');
SET IDENTITY_INSERT tipos_medios OFF;

-- Insertar datos en la tabla albumes
SET IDENTITY_INSERT albumes ON;
INSERT INTO albumes (id, titulo) VALUES
(1, 'Abbey Road'),
(2, 'Pies Descalzos'),
(3, 'YHLQMDLG'),
(4, 'OK Computer'),
(5, '21'),
(6, 'A Night at the Opera'),
(7, 'Mi Gente'),
(8, 'When We All Fall Asleep'),
(9, 'Master of Puppets'),
(10, 'El Mal Querer'),
(11, 'Sgt. Peppers'),
(12, 'Te Quiero'),
(13, 'Un Verano Sin Ti'),
(14, 'Kid A'),
(15, '25'),
(16, 'Bohemian Rhapsody'),
(17, 'Vibras'),
(18, 'Happier Than Ever'),
(19, 'Ride the Lightning'),
(20, 'Motomami');
SET IDENTITY_INSERT albumes OFF;

-- Insertar datos en la tabla artistas_albumes
-- Estas columnas no son IDENTITY, no requieren SET IDENTITY_INSERT
INSERT INTO artistas_albumes (id_artista, id_album) VALUES
(1, 1),   -- The Beatles - Abbey Road
(1, 11),  -- The Beatles - Sgt. Peppers
(2, 2),   -- Shakira - Pies Descalzos
(2, 12),  -- Shakira - Te Quiero
(3, 3),   -- Bad Bunny - YHLQMDLG
(3, 13),  -- Bad Bunny - Un Verano Sin Ti
(4, 4),   -- Radiohead - OK Computer
(4, 14),  -- Radiohead - Kid A
(5, 5),   -- Adele - 21
(5, 15),  -- Adele - 25
(6, 6),   -- Queen - A Night at the Opera
(6, 16),  -- Queen - Bohemian Rhapsody
(7, 7),   -- J Balvin - Mi Gente
(7, 17),  -- J Balvin - Vibras
(8, 8),   -- Billie Eilish - When We All Fall Asleep
(8, 18),  -- Billie Eilish - Happier Than Ever
(9, 9),   -- Metallica - Master of Puppets
(9, 19),  -- Metallica - Ride the Lightning
(10, 10), -- Rosalia - El Mal Querer
(10, 20), -- Rosalia - Motomami
(2, 3),   -- Shakira colabora en YHLQMDLG (ejemplo de colaboración)
(7, 3),   -- J Balvin colabora en YHLQMDLG
(3, 12),  -- Bad Bunny colabora en Te Quiero
(8, 15),  -- Billie Eilish colabora en 25
(10, 13), -- Rosalia colabora en Un Verano Sin Ti
(1, 6),   -- The Beatles colabora en A Night at the Opera
(6, 11),  -- Queen colabora en Sgt. Peppers
(4, 8),   -- Radiohead colabora en When We All Fall Asleep
(5, 18);  -- Adele colabora en Happier Than Ever

-- Insertar datos en la tabla pistas (100 registros)
SET IDENTITY_INSERT pistas ON;
INSERT INTO pistas (id, id_album, id_tipo_medio, id_genero, nombre, compositor, milisegundos, bytes, precio_unitario) VALUES
(1, 1, 1, 1, 'Come Together', 'Lennon-McCartney', 260000, 5242880, 99),
(2, 1, 1, 1, 'Something', 'Harrison', 182000, 3670016, 99),
(3, 1, 1, 1, 'Maxwells Silver Hammer', 'Lennon-McCartney', 207000, 4177920, 99),
(4, 1, 1, 1, 'Oh! Darling', 'Lennon-McCartney', 207000, 4177920, 99),
(5, 1, 1, 1, 'Octopus Garden', 'Starr', 170000, 3427840, 99),
(6, 2, 2, 2, 'Estoy Aquí', 'Shakira', 231000, 4659200, 129),
(7, 2, 2, 2, 'Pies Descalzos, Sueños Blancos', 'Shakira', 220000, 4433920, 129),
(8, 2, 2, 2, 'Dónde Estás Corazón', 'Shakira', 230000, 4638720, 129),
(9, 2, 2, 2, 'Se Quiere, Se Mata', 'Shakira', 210000, 4239360, 129),
(10, 2, 2, 2, 'Te Necesito', 'Shakira', 240000, 4843520, 129),
(11, 3, 1, 3, 'Safaera', 'Bad Bunny', 295000, 5953600, 99),
(12, 3, 1, 3, 'La Santa', 'Bad Bunny', 206000, 4157440, 99),
(13, 3, 1, 3, 'Yo Perreo Sola', 'Bad Bunny', 172000, 3468800, 99),
(14, 3, 1, 3, 'Si Veo a Tu Mamá', 'Bad Bunny', 190000, 3834880, 99),
(15, 3, 1, 3, 'Soliá', 'Bad Bunny', 180000, 3630080, 99),
(16, 4, 3, 5, 'Paranoid Android', 'Radiohead', 387000, 7810560, 149),
(17, 4, 3, 5, 'Karma Police', 'Radiohead', 264000, 5324800, 149),
(18, 4, 3, 5, 'No Surprises', 'Radiohead', 229000, 4618240, 149),
(19, 4, 3, 5, 'Exit Music', 'Radiohead', 267000, 5386240, 149),
(20, 4, 3, 5, 'Airbag', 'Radiohead', 287000, 5790720, 149),
(21, 5, 1, 2, 'Rolling in the Deep', 'Adele', 228000, 4602880, 99),
(22, 5, 1, 2, 'Someone Like You', 'Adele', 285000, 5752320, 99),
(23, 5, 1, 2, 'Set Fire to the Rain', 'Adele', 242000, 4884480, 99),
(24, 5, 1, 2, 'Rumour Has It', 'Adele', 223000, 4499200, 99),
(25, 5, 1, 2, 'Turning Tables', 'Adele', 249000, 5022720, 99),
(26, 6, 2, 1, 'Bohemian Rhapsody', 'Mercury', 355000, 7168000, 129),
(27, 6, 2, 1, 'Love of My Life', 'Mercury', 217000, 4377600, 129),
(28, 6, 2, 1, 'Youre My Best Friend', 'Deacon', 171000, 3448320, 129),
(29, 6, 2, 1, 'Im in Love with My Car', 'Taylor', 185000, 3732480, 129),
(30, 6, 2, 1, 'Sweet Lady', 'May', 195000, 3936000, 129),
(31, 7, 1, 3, 'Mi Gente', 'J Balvin', 189000, 3814400, 99),
(32, 7, 1, 3, 'Ambiente', 'J Balvin', 204000, 4116480, 99),
(33, 7, 1, 3, 'Machika', 'J Balvin', 192000, 3870720, 99),
(34, 7, 1, 3, 'No Es Justo', 'J Balvin', 210000, 4239360, 99),
(35, 7, 1, 3, 'Ahora', 'J Balvin', 225000, 4540160, 99),
(36, 8, 3, 5, 'Bad Guy', 'Eilish-OConnell', 194000, 3911680, 149),
(37, 8, 3, 5, 'When the Partys Over', 'Eilish', 196000, 3952640, 149),
(38, 8, 3, 5, 'Everything I Wanted', 'Eilish', 245000, 4945920, 149),
(39, 8, 3, 5, 'Bury a Friend', 'Eilish', 193000, 3891200, 149),
(40, 8, 3, 5, 'Wish You Were Gay', 'Eilish', 221000, 4458240, 149),
(41, 9, 2, 4, 'Battery', 'Hetfield-Ulrich', 312000, 6297600, 129),
(42, 9, 2, 4, 'Master of Puppets', 'Hetfield-Ulrich', 515000, 10393600, 129),
(43, 9, 2, 4, 'Disposable Heroes', 'Hetfield-Ulrich', 496000, 10009600, 129),
(44, 9, 2, 4, 'Welcome Home (Sanitarium)', 'Hetfield-Ulrich', 387000, 7810560, 129),
(45, 9, 2, 4, 'Orion', 'Hetfield-Ulrich', 504000, 10174464, 129),
(46, 10, 1, 3, 'Malamente', 'Rosalia', 149000, 3005440, 99),
(47, 10, 1, 3, 'Pienso en Tu Mirá', 'Rosalia', 189000, 3814400, 99),
(48, 10, 1, 3, 'Di Mi Nombre', 'Rosalia', 167000, 3368960, 99),
(49, 10, 1, 3, 'Bagdad', 'Rosalia', 182000, 3670016, 99),
(50, 10, 1, 3, 'Que No Salga la Luna', 'Rosalia', 255000, 5145600, 99),
(51, 11, 1, 1, 'Lucy in the Sky', 'Lennon-McCartney', 208000, 4198400, 99),
(52, 11, 1, 1, 'A Day in the Life', 'Lennon-McCartney', 337000, 6804480, 99),
(53, 12, 2, 2, 'Te Espero', 'Shakira', 210000, 4239360, 129),
(54, 12, 2, 2, 'Amor', 'Shakira', 195000, 3936000, 129),
(55, 13, 1, 3, 'Tití Me Preguntó', 'Bad Bunny', 243000, 4904960, 99),
(56, 13, 1, 3, 'Moscow Mule', 'Bad Bunny', 245000, 4945920, 99),
(57, 14, 3, 5, 'Everything in Its Right Place', 'Radiohead', 251000, 5068800, 149),
(58, 14, 3, 5, 'Idioteque', 'Radiohead', 312000, 6297600, 149),
(59, 15, 1, 2, 'Hello', 'Adele', 295000, 5953600, 99),
(60, 15, 1, 2, 'Send My Love', 'Adele', 223000, 4499200, 99),
(61, 16, 2, 1, 'Killer Queen', 'Mercury', 179000, 3610880, 129),
(62, 16, 2, 1, 'We Are the Champions', 'Mercury', 179000, 3610880, 129),
(63, 17, 1, 3, 'Ginza', 'J Balvin', 171000, 3448320, 99),
(64, 17, 1, 3, 'Sigo Extrañándote', 'J Balvin', 199000, 4014080, 99),
(65, 18, 3, 5, 'Happier Than Ever', 'Eilish', 298000, 6016000, 149),
(66, 18, 3, 5, 'Your Power', 'Eilish', 247000, 4986880, 149),
(67, 19, 2, 4, 'Fade to Black', 'Hetfield-Ulrich', 417000, 8417280, 129),
(68, 19, 2, 4, 'For Whom the Bell Tolls', 'Hetfield-Ulrich', 310000, 6256640, 129),
(69, 20, 1, 3, 'Candy', 'Rosalia', 188000, 3793920, 99),
(70, 20, 1, 3, 'Hentai', 'Rosalia', 171000, 3448320, 99),
(71, 20, 1, 3, 'La Fama', 'Rosalia', 187000, 3773440, 99),
(72, 1, 1, 1, 'Here Comes the Sun', 'Harrison', 185000, 3732480, 99),
(73, 2, 2, 2, 'Un Día Sin Ti', 'Shakira', 240000, 4843520, 129),
(74, 3, 1, 3, 'Hablamos Mañana', 'Bad Bunny', 235000, 4741120, 99),
(75, 4, 3, 5, 'Climbing Up the Walls', 'Radiohead', 285000, 5752320, 149),
(76, 5, 1, 2, 'Dont You Remember', 'Adele', 243000, 4904960, 99),
(77, 6, 2, 1, 'Good Old-Fashioned Lover Boy', 'Mercury', 174000, 3512320, 129),
(78, 7, 1, 3, 'Peligrosa', 'J Balvin', 198000, 3993600, 99),
(79, 8, 3, 5, 'I Love You', 'Eilish', 275000, 5550080, 149),
(80, 9, 2, 4, 'Leper Messiah', 'Hetfield-Ulrich', 339000, 6842880, 129),
(81, 10, 1, 3, 'Nana', 'Rosalia', 181000, 3649536, 99),
(82, 11, 1, 1, 'With a Little Help', 'Lennon-McCartney', 166000, 3348480, 99),
(83, 12, 2, 2, 'Suerte', 'Shakira', 203000, 4096000, 129),
(84, 13, 1, 3, 'Ojitos Lindos', 'Bad Bunny', 258000, 5207040, 99),
(85, 14, 3, 5, 'Motion Picture Soundtrack', 'Radiohead', 420000, 8478720, 149),
(86, 15, 1, 2, 'When We Were Young', 'Adele', 290000, 5857280, 99),
(87, 16, 2, 1, 'We Will Rock You', 'May', 122000, 2457600, 129),
(88, 17, 1, 3, 'Bobo', 'J Balvin', 210000, 4239360, 99),
(89, 18, 3, 5, 'Oxytocin', 'Eilish', 211000, 4259840, 149),
(90, 19, 2, 4, 'Creeping Death', 'Hetfield-Ulrich', 396000, 7995392, 129),
(91, 20, 1, 3, 'Chicken Teriyaki', 'Rosalia', 174000, 3512320, 99),
(92, 1, 1, 1, 'I Want You', 'Lennon-McCartney', 467000, 9420800, 99),
(93, 2, 2, 2, 'Antología', 'Shakira', 263000, 5304320, 129),
(94, 3, 1, 3, 'Vete', 'Bad Bunny', 192000, 3870720, 99),
(95, 4, 3, 5, 'Let Down', 'Radiohead', 299000, 6033920, 149),
(96, 5, 1, 2, 'He Wont Go', 'Adele', 277000, 5586944, 99),
(97, 6, 2, 1, 'The Prophet Song', 'May', 498000, 10055680, 129),
(98, 7, 1, 3, 'Safari', 'J Balvin', 205000, 4136960, 99),
(99, 8, 3, 5, 'All the Good Girls Go to Hell', 'Eilish', 168000, 3389440, 149),
(100, 9, 2, 4, 'Damage, Inc.', 'Hetfield-Ulrich', 331000, 6678528, 129);
SET IDENTITY_INSERT pistas OFF;


-- Insertar datos en la tabla usuarios (10 registros, IDs explícitas)
SET IDENTITY_INSERT usuarios ON;
INSERT INTO usuarios (id, nombre, correo, contraseña, fecha_registro) VALUES
(1, 'Andrea Rodriguez', 'andrea.r@example.com', 'pass123', '2024-01-10'),
(2, 'Carlos Mendoza', 'carlos.m@example.com', 'securepass', '2023-11-20'),
(3, 'Laura Torres', 'laura.t@example.com', 'mypassword', '2024-02-01'),
(4, 'Pedro Gomez', 'pedro.g@example.com', 'gomezpass', '2023-10-05'),
(5, 'Sofia Ramirez', 'sofia.r@example.com', 'ramirezpass', '2024-03-15'),
(6, 'Diego Castro', 'diego.c@example.com', 'castropass', '2023-09-01'),
(7, 'Mariana Soto', 'mariana.s@example.com', 'sotopass', '2024-04-22'),
(8, 'Ricardo Vidal', 'ricardo.v@example.com', 'vidalpass', '2023-08-12'),
(9, 'Elena Diaz', 'elena.d@example.com', 'diazpass', '2024-01-25'),
(10, 'Fernando Ruiz', 'fernando.r@example.com', 'ruizpass', '2023-12-01');
SET IDENTITY_INSERT usuarios OFF;

-- Insertar datos en la tabla planes (3 registros, IDs explícitas)
SET IDENTITY_INSERT planes ON;
INSERT INTO planes (id, nombre, precio, duracion_meses) VALUES
(1, 'Gratis', 0.00, NULL), -- Sin duración fija
(2, 'Estándar', 7.99, 1),
(3, 'Premium Anual', 79.99, 12);
SET IDENTITY_INSERT planes OFF;

-- Insertar datos en la tabla suscripciones (10 registros, IDs explícitas)
-- NOTA: Las fechas_fin se calculan a partir de la fecha actual para simular estados de suscripción.
-- La función GETDATE() se usa para la fecha de inicio actual si no se especifica.
SET IDENTITY_INSERT suscripciones ON;
INSERT INTO suscripciones (id, id_usuario, id_plan, fecha_inicio, fecha_fin) VALUES
(1, 1, 3, GETDATE(), DATEADD(year, 1, GETDATE())), -- Andrea: Premium Anual, activa
(2, 2, 2, GETDATE(), DATEADD(month, 1, GETDATE())), -- Carlos: Estándar, activa
(3, 3, 1, '2024-01-01', '2024-01-01'), -- Laura: Gratis, expirada o no aplica fecha fin
(4, 4, 3, DATEADD(month, -3, GETDATE()), DATEADD(month, 9, GETDATE())), -- Pedro: Premium, activa (con 3 meses de uso)
(5, 5, 2, '2024-01-15', '2024-02-15'), -- Sofia: Estándar, expirada
(6, 6, 1, GETDATE(), NULL), -- Diego: Gratis
(7, 7, 3, GETDATE(), DATEADD(year, 1, GETDATE())), -- Mariana: Premium, activa
(8, 8, 2, '2023-09-01', '2023-10-01'), -- Ricardo: Estándar, expirada
(9, 9, 1, GETDATE(), NULL), -- Elena: Gratis
(10, 10, 3, DATEADD(month, -6, GETDATE()), DATEADD(month, 6, GETDATE())); -- Fernando: Premium, activa (con 6 meses de uso)
SET IDENTITY_INSERT suscripciones OFF;

-- Insertar datos en la tabla playlists (15 registros, IDs explícitas)
SET IDENTITY_INSERT playlists ON;
INSERT INTO playlists (id, nombre, id_usuario, fecha_creacion) VALUES
(1, 'Mis Favoritas de Rock', 1, '2024-01-20'),
(2, 'Entrenamiento Pop', 2, '2024-03-01'),
(3, 'Relajación Indie', 3, '2024-02-15'),
(4, 'Reggaeton Party', 4, '2024-04-10'),
(5, 'Metal Clásico', 5, '2023-12-01'),
(6, 'Top Hits 2024', 1, '2024-05-10'),
(7, 'Chill Vibes', 3, '2024-03-25'),
(8, 'Workout Mix', 2, '2024-04-18'),
(9, 'Viaje Musical', 6, '2024-01-05'),
(10, 'Descubrimientos Indie', 7, '2024-05-01'),
(11, 'Pop Latino', 4, '2024-03-01'),
(12, 'Alternativo Favorito', 8, '2023-10-10'),
(13, 'Clásicos de Rock', 9, '2024-02-28'),
(14, 'Novedades', 10, '2024-05-25'),
(15, 'Para Concentrarse', 5, '2024-01-01');
SET IDENTITY_INSERT playlists OFF;

-- Insertar datos en la tabla playlist_pistas (ejemplo de 30 relaciones)
-- Estas columnas no son IDENTITY, no requieren SET IDENTITY_INSERT
INSERT INTO playlist_pistas (id_playlist, id_pista) VALUES
(1, 1), (1, 2), (1, 26), (1, 61), -- Rock para Andrea
(2, 6), (2, 7), (2, 21), (2, 22), -- Pop para Carlos
(3, 16), (3, 17), (3, 36), (3, 37), -- Indie para Laura
(4, 11), (4, 12), (4, 46), (4, 47), -- Reggaeton para Pedro
(5, 41), (5, 42), (5, 67), (5, 68), -- Metal para Sofia
(6, 21), (6, 59), (6, 11), (6, 31), -- Top Hits para Andrea
(7, 18), (7, 57), (7, 38), (7, 65), -- Chill para Laura
(8, 74), (8, 55), (8, 33), (8, 88), -- Workout para Carlos
(9, 72), (9, 93), (9, 85), (9, 97), -- Viaje para Diego
(10, 75), (10, 89), (10, 95);     -- Descubrimientos para Mariana

-- Insertar datos en la tabla historial (ejemplo de 20 reproducciones)
-- NOTA: Las fechas_reproduccion se basan en la fecha y hora actuales.
SET IDENTITY_INSERT historial ON;
INSERT INTO historial (id, id_usuario, id_pista, fecha_reproduccion) VALUES
(1, 1, 1, '2025-05-30 08:00:00'),
(2, 1, 26, '2025-05-30 08:05:30'),
(3, 2, 6, '2025-05-29 17:15:00'),
(4, 3, 16, '2025-05-28 20:00:00'),
(5, 4, 11, '2025-05-27 10:30:00'),
(6, 5, 41, '2025-05-26 14:00:00'),
(7, 1, 6, '2025-05-30 08:15:00'),
(8, 2, 21, '2025-05-29 17:20:30'),
(9, 3, 36, '2025-05-28 20:10:00'),
(10, 4, 46, '2025-05-27 10:35:00'),
(11, 5, 67, '2025-05-26 14:05:00'),
(12, 6, 72, '2025-05-25 11:00:00'),
(13, 7, 75, '2025-05-24 16:00:00'),
(14, 8, 80, '2025-05-23 09:00:00'),
(15, 9, 87, '2025-05-22 19:00:00'),
(16, 10, 91, '2025-05-21 12:00:00'),
(17, 1, 92, '2025-05-30 08:30:00'),
(18, 2, 93, '2025-05-29 17:40:00'),
(19, 3, 95, '2025-05-28 20:25:00'),
(20, 4, 98, '2025-05-27 10:45:00');
SET IDENTITY_INSERT historial OFF;


