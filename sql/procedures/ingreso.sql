
--Ingreso
--- (usuario, contraseña)

DROP PROCEDURE ingreso;


DELIMITER $$
CREATE PROCEDURE ingreso (v_usuario INT, v_contra VARCHAR(50), OUT x INT)
BEGIN
SET x = (SELECT tipo FROM usuario_cuenta WHERE (id_cuenta = v_usuario) AND (contraseña = v_contra));
END$$
DELIMITER ;

CALL ingreso (1, '123', @tipo);
SELECT @tipo;



CALL ingreso (usuario, contraseña, @tipo);
SELECT @tipo;

SELECT tipo FROM usuario_cuenta WHERE id_cuenta = 1 AND contraseña = '123';

-- if (tipo == 0)
--    menu 1
--if (tipo == 1)
--    menu 2
