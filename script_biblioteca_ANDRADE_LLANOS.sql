-- CREACION DE LA BASE DE DATOS 'BIBLIOTECA'

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

-- End of file.
