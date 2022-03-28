-- info_carreras
-- id es AUTO_INCREMENT
INSERT INTO info_carreras (carrera) VALUES
('Ingeniería en Tecnologias de Computo y Telecomunicaciones'),
('Ingeniería en Mecatrónica'),
('Ingeniería Mecánica'),
('Ingeniería Biomédica'),
('Ingeniería Física'),
('Ingeniería Química'),
('Contaduria');

-- usuarios
-- id_cuenta es AUTO_INCREMENT
INSERT INTO usuarios (nombre, ap_paterno, ap_materno, idcarrera, semestre, fech_nac) VALUES
('Carlos', 'Ibarra', 'Rodriguez', 1, 4, '2000-12-28'),
('Vicente', 'Perez', 'Anastacio', 2, 4,'2001-02-09'),
('José', 'Fernandez', 'Ramirez', 6, 1,'1999-03-13'),
('Brenda', 'Rosas', 'Juarez', 4, 2,'2002-06-12'),
('Pedro', 'Romero', 'Felix', 2, 2,'1998-11-20'),
('Maria', 'Rodriguez', 'Urias', 5, 8,'1997-01-05'),
('Yureli', 'Morales', 'Hernandez', 7, 2,'2002-01-20');

-- Modos
INSERT INTO modos (tipo, descripcion) VALUES
(0, 'Administrador'),
(1, 'Usuario');

-- usuario_cuenta
INSERT INTO usuario_cuenta (id_cuenta, correo, contraseña, tipo) VALUES
(1, 'carlos@hotmail.com', '123', 0),
(2, 'vicente_perez_a@outlook.com', '543', 0),
(3, 'jose.f@ibero.mx', 'jose3', 1),
(4, 'brenda.r@ibero.mx', 'brenda4', 1),
(5, 'pedro.r@ibero.mx', 'pedro5', 1),
(6, 'maria.r@ibero.mx', 'maria6', 1),
(7, 'yureli.m@ibero.mx', 'yureli7', 1);

-- Materiales
-- idMaterial es AUTO_INCREMENT
INSERT INTO materiales (nombre, cantidad, prestados) VALUES
('Resistencias', 1000, 0),
('Protoboard', 200, 0),
('Capacitores', 1000, 0),
('Cables caiman-caiman', 500, 0),
('Multímetro', 600, 0),
('Cables para multímetro', 700, 0);

-- esta se llena en el programa
-- INSERT INTO prestamos (id_cuenta, idMaterial, cantidad, fech_prestamo, fech_devuelto) VALUES
-- (1, 1, 1, '', ''),
-- (1, 1, 1, '', ''),
-- (1, 1, 1, '', ''),
-- (1, 1, 1, '', ''),
-- (1, 1, 1, '', ''),
-- (1, 1, 1, '', ''),
-- (1, 1, 1, '', '');
