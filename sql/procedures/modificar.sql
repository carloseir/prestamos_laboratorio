-- Editar un campo para el admin
DROP PROCEDURE admin_editar;


DELIMITER $$
CREATE PROCEDURE admin_editar(parametro VARCHAR(100), opcion INT, id INT, OUT salida INT)
BEGIN
DECLARE help INT;

CASE

WHEN opcion=1 THEN
UPDATE usuarios SET nombre = parametro WHERE id_cuenta= id;
SET help = 1;

WHEN opcion=2 THEN
UPDATE usuarios SET ap_paterno = parametro WHERE id_cuenta= id;
SET help = 1;

WHEN opcion=3 THEN
UPDATE usuarios SET ap_materno = parametro WHERE id_cuenta= id;
SET help = 1;

WHEN opcion=4 THEN
SET help = (SELECT idcarrera FROM info_carreras WHERE carrera = parametro);
UPDATE usuarios SET idcarrera = help WHERE id_cuenta= id;

WHEN opcion=5 THEN
SET help= CAST(parametro AS UNSIGNED);
UPDATE usuarios SET semestre= help WHERE id_cuenta= id;

WHEN opcion=6 THEN
UPDATE usuarios SET fech_nac = parametro WHERE id_cuenta= id;
SET help = 1;

WHEN opcion=7 THEN
UPDATE usuario_cuenta SET correo = parametro WHERE id_cuenta= id;
SET help = 1;

WHEN opcion=8 THEN
UPDATE usuario_cuenta SET contraseña = parametro WHERE id_cuenta= id;
SET help = 1;

WHEN opcion=9 THEN
IF parametro = 'Normal' THEN SET help = 1;
END IF;
IF parametro = 'Administrador' THEN SET help = 0;
END IF;
UPDATE usuario_cuenta SET tipo = help WHERE id_cuenta= id;

END CASE;
IF help = NULL THEN
SET salida = -1;
ELSE
SET salida = 1;
END IF;
END$$
DELIMITER ;

CALL admin_editar('Gomez',3,1, @salida);

CALL admin_editar('h', 4, 10, @salida);

CALL admin_editar('Ad', 9, 10, @salida);
