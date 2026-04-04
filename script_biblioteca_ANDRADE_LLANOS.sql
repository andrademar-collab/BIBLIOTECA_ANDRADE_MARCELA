-- //CREACION DE LA BASE DE DATOS 'BIBLIOTECA'//

DROP DATABASE IF EXISTS biblioteca;

CREATE DATABASE biblioteca;

-- Creacion de TABLAS:

USE biblioteca;

-- Tabla: usuario
CREATE TABLE IF NOT EXISTS usuario (
	id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	dni VARCHAR(20) NOT NULL UNIQUE,-- no se permite dni duplicado
	email VARCHAR(100) NOT NULL UNIQUE,-- no se permiten emails duplicados
	fecha_nacimiento DATE NOT NULL,
	telefono VARCHAR(20) NOT NULL
);

-- Tabla: autor
CREATE TABLE IF NOT EXISTS autor (
	id_autor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL
);

-- Tabla: editorial
CREATE TABLE IF NOT EXISTS editorial (
id_editorial INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL UNIQUE -- no se permiten editoriales duplicadas
);

-- Table: genero
CREATE TABLE IF NOT EXISTS genero (
id_genero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
genero VARCHAR(20) NOT NULL UNIQUE -- no se permiten generos duplicados
);

-- Tabla: libro
CREATE TABLE IF NOT EXISTS libro (
	id_libro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,-- ISBN identifica de manera unica un libro a nivel internacional
    anio_publicacion YEAR NOT NULL,
    id_autor INT NOT NULL,
    id_editorial INT NOT NULL,
    id_genero INT NOT NULL,

    FOREIGN KEY (id_autor) REFERENCES autor (id_autor),

    FOREIGN KEY (id_editorial) REFERENCES editorial (id_editorial),

    FOREIGN KEY (id_genero) REFERENCES genero (id_genero)
);

-- Tabla: ejemplar
CREATE TABLE IF NOT EXISTS ejemplar (
id_ejemplar INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_libro INT NOT NULL,-- registro a que libro corresponde cada ejemplar
estado ENUM ('disponible', 'prestado') NOT NULL,-- Describe el estado de cada ejemplar (disponible o prestado)

FOREIGN KEY (id_libro) REFERENCES libro (id_libro)
);

-- Tabla: prestamo
CREATE TABLE IF NOT EXISTS prestamo (
id_prestamo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_usuario INT NOT NULL,
id_ejemplar INT NOT NULL,
fecha_prestamo DATE NOT NULL,
fecha_vencimiento DATE NOT NULL,
fecha_devolucion DATE,-- si aun no se devolvio el ejemplar, el campo es NULL

FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),

FOREIGN KEY (id_ejemplar) REFERENCES ejemplar (id_ejemplar)
); 

-- -------------------------------------------------------------------------------------------------------------
-- //MODIFICACION EN LA BASE DE DATOS 'BIBLIOTECA'//

USE biblioteca;


-- Eliminar la columna estado de la tabla ejemplar:
ALTER TABLE ejemplar
DROP COLUMN estado;

-- NOTA= Se gestionara la disponibilidad de ejemplares a traves de vistas.

-- Fin de modificaciones
-- -------------------------------------------------------------------------------------------------------------
-- //CREACION DE FUNCIONES//

USE biblioteca;


DELIMITER //


-- Funcion #1: calcular la edad del usuario

DROP FUNCTION IF EXISTS fn_calcular_edad//

CREATE FUNCTION fn_calcular_edad(p_id_usuario INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE v_fecha_nacimiento DATE;
    DECLARE v_edad INT;
    
    -- Buscar la fecha de nacimiento del usuario
    SELECT fecha_nacimiento INTO v_fecha_nacimiento
    FROM biblioteca.usuario
    WHERE id_usuario = p_id_usuario;
    
    -- Calcular la edad
    SET v_edad = TIMESTAMPDIFF(YEAR, v_fecha_nacimiento, CURDATE());
    
    RETURN v_edad;
END//



-- Funcion #2: calcular los dias restantes para el vencimiento de un prestamo activo
-- (dias para el momento de la devolucion)

DROP FUNCTION IF EXISTS fn_dias_restantes_vencimiento//

CREATE FUNCTION fn_dias_restantes_vencimiento(p_id_prestamo INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE v_fecha_vencimiento DATE;
    DECLARE v_dias_restantes INT;
    
    -- Buscar la fecha de vencimiento del prestamo
    SELECT fecha_vencimiento INTO v_fecha_vencimiento
	FROM biblioteca.prestamo
	WHERE 
		id_prestamo = p_id_prestamo
		AND fecha_devolucion IS NULL;
        
    -- Calcular los dias restantes para el vencimiento del prestamo
    SET v_dias_restantes = DATEDIFF(v_fecha_vencimiento, CURDATE());
    RETURN v_dias_restantes;
END//
-- NOTA= 
-- 		Retorno: 
-- 		> 0 : dias restantes hasta el vencimiento del prestamo
-- 		= 0 : prestamo vence hoy
-- 		< 0 : dias de atraso
-- 		NULL: el prestamo no existe o ya fue devuelto



-- Funcion #3: calcular la cantidad de prestamos realizados (finalizados y en curso) por usuario

DROP FUNCTION IF EXISTS fn_prestamos_x_usuario//

CREATE FUNCTION fn_prestamos_x_usuario(p_id_usuario INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE v_nro_prestamos INT;
    
    -- Contar el nro de prestamos realizados por usuario
    SELECT
		COUNT(*) INTO v_nro_prestamos
    FROM biblioteca.prestamo
    WHERE 
		id_usuario = p_id_usuario;
    
    RETURN v_nro_prestamos;
END//
-- N0TA=
-- 		Retorno = 0 : El usuario no realizo ningun prestamo


DELIMITER ;


-- Fin creacion de funciones
-- -------------------------------------------------------------------------------------------------------------
-- //CREACION DE VISTAS//

USE biblioteca;


-- Vista: prestamos activos (aun no devueltos)

CREATE OR REPLACE VIEW view_prestamos_activos AS
	SELECT
		p.id_prestamo,
        u.id_usuario,
        CONCAT(u.nombre, ' ', u.apellido) as usuario,
        u.dni,
        u.email,
        e.id_ejemplar,
        l.titulo,
        p.fecha_prestamo,
        p.fecha_vencimiento,
        fn_dias_restantes_vencimiento(p.id_prestamo) AS dias_restantes,
        CASE
			WHEN fn_dias_restantes_vencimiento(p.id_prestamo) < 0 THEN 'ATRASADO'
            WHEN fn_dias_restantes_vencimiento(p.id_prestamo) = 0 THEN 'VENCE HOY'
            WHEN fn_dias_restantes_vencimiento(p.id_prestamo) > 0 THEN 'EN TERMINO'
		END AS estado_prestamo
    FROM biblioteca.prestamo p
    INNER JOIN biblioteca.usuario u ON (p.id_usuario = u.id_usuario)
    INNER JOIN biblioteca.ejemplar e ON (p.id_ejemplar = e.id_ejemplar)
    INNER JOIN biblioteca.libro l ON (e.id_libro = l.id_libro)
    WHERE p.fecha_devolucion IS NULL;-- filtra solo los prestamos activos
    
    

-- Vista: lista de ejemplares y su disponibilidad (disponible/prestado)

CREATE OR REPLACE VIEW view_disponibilidad_ejemplares AS
	SELECT 
		e.id_ejemplar,
        l.id_libro,
        l.titulo,
        CONCAT (a.nombre, ' ', a.apellido) AS autor,
        l.anio_publicacion,
        l.isbn,
        ed.nombre AS editorial,
        g.genero,
        CASE
			WHEN p.id_prestamo IS NOT NULL THEN 'PRESTADO'
			WHEN p.id_prestamo IS NULL THEN 'DISPONIBLE'
		END AS disponibilidad
	FROM biblioteca.ejemplar e
    INNER JOIN biblioteca.libro l ON (e.id_libro = l.id_libro)
    INNER JOIN biblioteca.autor a ON (l.id_autor = a.id_autor)
    INNER JOIN biblioteca.editorial ed ON (l.id_editorial = ed.id_editorial)
    INNER JOIN biblioteca.genero g ON (l.id_genero = g.id_genero)
    LEFT JOIN biblioteca.prestamo p ON (e.id_ejemplar = p.id_ejemplar AND p.fecha_devolucion IS NULL)-- filtra solo los prestamos activos
    ORDER BY e.id_ejemplar;
    
-- NOTA= Cuando se realiza un prestamo, se crea un registro en la tabla prestamo y se deja la columna fecha_devolucion vacia. 
-- 		 Cuando dicho ejemplar se devuelve, se inserta la fecha de ese dia en la columna fecha_devolucion.
-- 		 Por lo tanto, cuando dicha columna marque NULL, significa que aun no se devolvio el ejemplar prestado, es decir, el prestamo sigue activo.
    
    
    
-- Vista: cantidad de prestamos realizados por usuario

CREATE OR REPLACE VIEW view_nro_prestamos_por_usuario AS
	SELECT
		u.id_usuario,
        CONCAT(u.nombre, ' ', u.apellido) AS nombre,
        u.fecha_nacimiento,
        fn_calcular_edad(u.id_usuario) AS edad,
        u.email,
        fn_prestamos_x_usuario(u.id_usuario) AS prestamos_realizados
    FROM biblioteca.usuario u;


-- Fin creacion de vistas
-- -------------------------------------------------------------------------------------------------------------
-- //CREACION DE TRIGGERS//

USE biblioteca;


-- Trigger #1: Validacion de la edad del usuario

DELIMITER //

DROP TRIGGER IF EXISTS tr_validar_edad_usuario//

CREATE TRIGGER tr_validar_edad_usuario
BEFORE INSERT ON biblioteca.usuario
FOR EACH ROW
BEGIN
	DECLARE v_edad INT;
    
    -- Validar que la fecha de nacimiento sea anterior a la fecha actual
    IF NEW.fecha_nacimiento >= CURDATE() THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La fecha de nacimiento debe ser anterior a la fecha actual.';
	END IF;
    
    -- Calcular la edad del usuario en años
    SET v_edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE());
    
    -- Validar que el usuario tenga entre 16 y 26 años (regla de negocio)
    IF v_edad < 16 OR v_edad > 26 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El usuario debe tener entre 16 y 26 años para registrarse.';
	END IF;
END//



-- Trigger #2: Verificar que el usuario este apto para realizar un prestamo segun reglas del negocio

DROP TRIGGER IF EXISTS tr_verificar_usuario_apto_prestamo//

CREATE TRIGGER tr_verificar_usuario_apto_prestamo
BEFORE INSERT ON biblioteca.prestamo
FOR EACH ROW
BEGIN
     
	-- Verificar que usuario no tenga ningun prestamo activo "atrasado"
    IF EXISTS (
		SELECT 1
        FROM view_prestamos_activos
        WHERE 
			id_usuario = NEW.id_usuario
            AND dias_restantes < 0
	) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El usuario tiene prestamos atrasados. No puede solicitar un préstamo nuevo.';
	END IF;
    
    -- Verificar que usuario no tenga ningun prestamo activo "en término"
    IF EXISTS (
		SELECT 1
        FROM view_prestamos_activos
        WHERE
			id_usuario = NEW.id_usuario
            AND dias_restantes >= 0
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El usuario tiene prestamos en curso. No puede solicitar un préstamo nuevo.';
	END IF;
    
	-- Verificar si el usuario esta sancionado por atraso
    IF EXISTS (
		SELECT 1
        FROM biblioteca.prestamo
		WHERE 
			id_usuario = NEW.id_usuario
			AND fecha_devolucion IS NOT NULL-- filtra prestamos finalizados
            AND fecha_devolucion > fecha_vencimiento
            AND DATEDIFF(CURDATE(), fecha_devolucion) < 20
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Usuario sancionado. Aun no puede solicitar un prestamo.';
	END IF;
END//

-- NOTA=
-- En la vista view_prestamos_activos solo se encuentran aquellos prestamos que aun no fueron devueltos
-- (en curso o atrasados).
-- Si un usuario tiene una tardanza en la devolucion de un ejemplar, tiene una sancion de 20 dias sin poder
-- solicitar ningun prestamo.


DELIMITER ;


-- Fin creacion de triggers
-- -------------------------------------------------------------------------------------------------------------
-- //CREACION DE STORED PROCEDURES (SP)//

USE biblioteca;


DELIMITER //


-- SP #1: Regristro del prestamo

DROP PROCEDURE IF EXISTS sp_registrar_prestamo//

CREATE PROCEDURE sp_registrar_prestamo(IN p_id_usuario INT, IN p_id_ejemplar INT)
BEGIN
    
	-- Insertar datos para el registro del prestamo
	INSERT INTO biblioteca.prestamo (id_usuario, id_ejemplar, fecha_prestamo, fecha_vencimiento)
    VALUES (p_id_usuario, p_id_ejemplar, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 20 DAY));
    
    -- Mensaje de confirmacion
    SELECT 
		CONCAT('Préstamo Nro. ', LAST_INSERT_ID(), ' registrado correctamente. Vencimiento: ', DATE_ADD(CURDATE(), INTERVAL 20 DAY))
		AS resultado_operacion;
END//

-- NOTAS=
-- Los triggers validan que el usuario este apto para solicitar un prestamo.
-- La columna fecha_devolucion se completa el dia que el usuario devuelve el ejemplar prestado mediante
-- el procedimiento que sigue; mientras el prestamo esta activo, dicha columna permanece con NULL.



-- SP #2: Registro de la devolucion del prestamo

DROP PROCEDURE IF EXISTS sp_registrar_devolucion//

CREATE PROCEDURE sp_registrar_devolucion(IN p_id_prestamo INT)
BEGIN
	DECLARE v_estado_prestamo VARCHAR(10);
    DECLARE v_mensaje VARCHAR(100);

	-- Ver el estado del prestamo (ATRASADO/EN TERMINO/VENCE HOY)
	SELECT estado_prestamo INTO v_estado_prestamo 
	FROM view_prestamos_activos
	WHERE id_prestamo = p_id_prestamo;
    
    -- Insertar la fecha de devolución
    UPDATE biblioteca.prestamo 
    SET fecha_devolucion = CURDATE()
    WHERE id_prestamo = p_id_prestamo;
    
    -- Definir el mensaje de retorno segun el estado del prestamo
    IF v_estado_prestamo = 'ATRASADO' THEN
        SET v_mensaje = 'Devolución tardía. No puede solicitar ningún préstamo en 20 días.';
	ELSE
		SET v_mensaje = 'Devolución registrada con éxito. El usuario puede solicitar un nuevo préstamo.';
	END IF;
    
    -- Mostrar el mensaje de retorno
    SELECT v_mensaje AS resultado_operacion;
END //
-- NOTA=
-- Cuando el usuario devuelve el ejemplar, se acutualiza la tabla prestamo con el registro de la fecha de devolucion.
-- Esto actualiza la informacion en las todas las vistas.

DELIMITER ;

-- Fin creacion de stored procedures
-- -------------------------------------------------------------------------------------------------------------
-- //INSERCION DE DATOS//

USE biblioteca;

-- Insertar generos
INSERT INTO biblioteca.genero (genero)
VALUES
('Misterio'),
('Romance'),
('Mitología Griega'),
('Ciencia Ficción'),
('Terror'),
('Aventura'),
('Novela'),
('Historieta'),
('Fantasía'),
('Policial');

-- Insertar editoriales
INSERT INTO biblioteca.editorial (nombre)
VALUES
('Planeta'),
('Penguin Random House'),
('Anagrama'),
('Ivrea'),
('Océano'),
('Salamandra'),
('Siglo XXI'),
('Urano'),
('Sudamericana'),
('V&R Editoras');

-- Insertar autores
INSERT INTO biblioteca.autor (nombre, apellido)
VALUES
('Mariana', 'Enríquez'),
('Rick', 'Riordan'),
('Alice', 'Oseman'),
('Stephen', 'King'),
('Liliana', 'Bodoc'),
('Agatha', 'Christie'),
('Leigh', 'Bardugo'),
('Quino', ' '),
('Neil', 'Gaiman'),
('Victoria', 'Aveyard');

-- Insertar libros
INSERT INTO biblioteca.libro (titulo, isbn, anio_publicacion, id_autor, id_editorial, id_genero)
VALUES 
('Nuestra parte de noche', '9789877253641', 2019, 1, 3, 5),
('Las cosas que perdimos en el fuego', '9789877120936', 2016, 1, 3, 5),
('El ladrón del rayo', '9788498386264', 2005, 2, 6, 3),
('El mar de los monstruos', '9788498386271', 2006, 2, 6, 3),
('Heartstopper vol 1', '9789877475173', 2019, 3, 10, 8),
('Heartstopper vol 2', '9789877475180', 2019, 3, 10, 8),
('It (Eso)', '9789506440442', 1986, 4, 2, 5),
('El resplandor', '9789500420105', 1977, 4, 2, 5),
('Los días del Venado', '9789875666276', 2000, 5, 9, 9),
('Diez negritos', '9789504924760', 1939, 6, 1, 1),
('Asesinato en el Orient Express', '9789504924777', 1934, 6, 1, 10),
('Sombra y hueso', '9789876098656', 2012, 7, 10, 9),
('Toda Mafalda', '9789505156054', 1993, 8, 4, 8),
('Coraline', '9788416240210', 2002, 9, 6, 5),
('American Gods', '9788416240685', 2001, 9, 2, 9),
('La reina roja', '9789876099684', 2015, 10, 1, 9),
('Seis de cuervos', '9789877472486', 2015, 7, 10, 6),
('Misery', '9789506440411', 1987, 4, 2, 5),
('La profecía del rastro', '9788498380897', 2007, 2, 6, 3),
('El imperio de las tormentas', '9789877472493', 2016, 10, 8, 9),
('Cien años de soledad', '9789500700924', 1967, 5, 9, 7),
('El misterio de la guía de ferrocarriles', '9788466336499', 1936, 6, 1, 10),
('Buenos días, princesa', '9789504928683', 2012, 3, 1, 2),
('Sandman: Preludios y Nocturnos', '9788417292211', 1989, 9, 4, 8),
('Los días del Fuego', '9789875666283', 2002, 5, 9, 9);

-- Insertar ejemplares
INSERT INTO biblioteca.ejemplar (id_libro) VALUES 
(1),
(1),
(1),
(2),
(2),
(3),
(3),
(3),
(4),
(4),
(5),
(5),
(5),
(6),
(6),
(7),
(7),
(7),
(8),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25);

-- Insertar usuarios
INSERT INTO biblioteca.usuario (nombre, apellido, dni, email, fecha_nacimiento, telefono)
VALUES 
('Lucas', 'Martínez', '42123456', 'lucas.m@mail.com', '2000-05-15', '1144556677'),
('Micaela', 'García', '43987654', 'mica.g@mail.com', '2002-11-20', '1122334455'),
('Enzo', 'Fernández', '41555666', 'enzo.f@mail.com', '2009-01-10', '1133445566'),
('Valentina', 'Pérez', '45111222', 'valen.p@mail.com', '2004-03-30', '1166778899'),
('Julián', 'Álvarez', '44333444', 'julian.a@mail.com', '2003-07-22', '1155667788'),
('Sofía', 'Rodríguez', '42000111', 'sofi.rod@mail.com', '2000-09-05', '2214455667'),
('Mateo', 'López', '46777888', 'mateo.l@mail.com', '2006-02-14', '3416677889'),
('Camila', 'Sosa', '43222111', 'cami.s@mail.com', '2001-12-12', '1199887766'),
('Bautista', 'Gómez', '44888999', 'bauti.g@mail.com', '2003-05-05', '1177665544'),
('Delfina', 'Ruiz', '41999000', 'delfina.r@mail.com', '2002-08-25', '1188776655');

-- Insertar prestamos
INSERT INTO biblioteca.prestamo (id_usuario, id_ejemplar, fecha_prestamo, fecha_vencimiento, fecha_devolucion)
VALUES 
(1, 1, '2026-03-01', '2026-03-21', NULL),
(6, 23, '2026-03-01', '2026-03-21', NULL),
(2, 4, '2026-03-05', '2026-03-25', NULL),
(3, 6, '2026-03-10', '2026-03-30', NULL),
(9, 20, '2026-03-10', '2026-03-30', NULL),
(4, 9, '2026-03-15', '2026-04-04', NULL),
(5, 11, '2026-03-20', '2026-04-09', NULL),
(7, 15, '2026-03-22', '2026-04-11', NULL),
(8, 17, '2026-03-28', '2026-04-17', NULL),
(10, 25, '2026-04-01', '2026-04-21', NULL);

-- NOTA=
-- Cuando se registra un prestamo, se deja la columa fecha_devolucion en blanco.
-- La misma es modificada en el momento de la devolucion del ejemplar, a traves del procedimiento sp_registrar_devolucion.
-- Ademas, es posible insertar nuevos prestamos a traves del procedimiento sp_registrar_prestamo.

-- Fin de insercion de datos

-- //End of file//