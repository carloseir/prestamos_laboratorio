-- nombre[50], ap_paterno[50], ap_materno[50], nombre_carrera[100], semestre, fecha[20],
-- num_cuenta, correo[60], contra[50], tipo[20];

DROP PROCEDURE registro;


DELIMITER $$
CREATE PROCEDURE registro (nombre VARCHAR(60), ap_paterno VARCHAR(50), ap_materno VARCHAR(50),
nombre_carrera VARCHAR(100), semestre SMALLINT, fecha DATE, num_cuenta INT, correo VARCHAR(60),
contra VARCHAR(50), tipo VARCHAR(20), OUT salida INT)
BEGIN

-- DECLARE v_fecha DATE;
DECLARE v_tipo INT;
DECLARE v_idcarrera INT;

-- SET v_fecha = CONVERT(DATE, fecha);
-- SET v_fecha = CAST (fecha AS DATE);

SET v_tipo = CASE
WHEN tipo = 'Administrador' THEN 0
WHEN tipo = 'Normal' THEN 1
ELSE NULL END;

IF v_tipo IS NOT NULL THEN

SET v_idcarrera = (SELECT idcarrera FROM info_carreras WHERE carrera = nombre_carrera);

IF v_idcarrera IS NOT NULL THEN

INSERT INTO usuarios VALUES (nombre, ap_paterno, ap_materno, v_idcarrera, semestre, fecha, num_cuenta);
INSERT INTO usuario_cuenta VALUES (correo, num_cuenta, contra, v_tipo);

END IF;
SET salida = 1;
END IF;

IF (v_tipo IS NULL) OR (v_idcarrera IS NULL) THEN
SET salida = -1;
END IF;

END$$
DELIMITER ;


CALL registro ('Andrés', 'Lopez', 'Ruiz', 'Contaduria', 1, '2000-11-02', 8, 'andres.l@ibero.mx', 'andres8', 'Normal',
@salida);

CALL registro ('Fernando', 'Gamez', 'J.', 'Ingeniería en Mecatrónica', 2, '2000-02-09', 10, 'fer10l@ibero.mx', 'fer10', 'Normal',
@salida);
CALL registro ('Sebastian','Marquez', 'Alvarez', 'Ingeniería en Mecatrónica', 1, '2001-01-15', 11, 'sebastian.m@ibero.mx', 'sebastian11', 'Normal', @salida);

CALL registro ('a','a', 'a', 'Ingeniería en Mecatrónica', 1, '2001-01-01', 11, 'a', 'a', 'Normal', @salida);


CALL registro (nombre, ap_paterno, ap_materno, nombre_carrera, semestre, fecha, num_cuenta,
correo, contra, tipo, @id_carrera);
