-- infromacion de la carreras
CREATE TABLE info_carreras (idcarrera INT PRIMARY KEY AUTO_INCREMENT, carrera VARCHAR (100));

-- usuarios
CREATE TABLE usuarios (nombre VARCHAR(60), ap_paterno VARCHAR(60), ap_materno VARCHAR(60), idcarrera INT, semestre INT, fech_nac DATE,
id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
FOREIGN KEY (idcarrera) REFERENCES info_carreras (idcarrera) ON DELETE CASCADE ON UPDATE CASCADE);

-- descripcion de si es admin o no
CREATE TABLE modos (tipo INT PRIMARY KEY, descripcion VARCHAR(40));

-- las cuentas de los usuarios
CREATE TABLE usuario_cuenta (correo VARCHAR(100), id_cuenta INT, contraseña VARCHAR(50), tipo INT,
FOREIGN KEY (id_cuenta) REFERENCES usuarios (id_cuenta) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (tipo) REFERENCES modos(tipo) ON DELETE CASCADE ON UPDATE CASCADE);

-- Materiales
CREATE TABLE materiales (nombre VARCHAR(100) UNIQUE, cantidad INT, prestados INT, idMaterial INT PRIMARY KEY AUTO_INCREMENT);

-- Prestamos y Devoluciones (nueva)
CREATE TABLE prestamos (idprestamo INT PRIMARY KEY AUTO_INCREMENT, id_cuenta INT, idMaterial INT,
cantidad INT, fech_prestamo DATE, fech_devuelto DATE,
FOREIGN KEY (id_cuenta) REFERENCES usuarios (id_cuenta) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (idMaterial) REFERENCES materiales (idMaterial) ON DELETE CASCADE ON UPDATE CASCADE);

-- drop todo
DROP TABLE prestamos;
DROP TABLE materiales;
DROP TABLE usuario_cuenta;
DROP TABLE modos;
DROP TABLE usuarios;
DROP TABLE info_carreras;

-- truncate
TRUNCATE TABLE prestamos;
TRUNCATE TABLE materiales;
TRUNCATE TABLE usuario_cuenta;
TRUNCATE TABLE modos;
TRUNCATE TABLE usuarios;
TRUNCATE TABLE info_carreras;





--ANTES

-- Modificaciiones antes de utilizarlo
ALTER TABLE prestamos ADD idprestamo  int;
ALTER TABLE prestamos MODIFY idprestamo int  PRIMARY KEY AUTO_INCREMENT;

-- Prestamos y Devoluciones
CREATE TABLE prestamos (id_cuenta INT, idMaterial INT, cantidad INT, fech_prestamo DATE, fech_devuelto DATE,
FOREIGN KEY (id_cuenta) REFERENCES usuarios (id_cuenta) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (idMaterial) REFERENCES materiales (idMaterial) ON DELETE CASCADE ON UPDATE CASCADE);
