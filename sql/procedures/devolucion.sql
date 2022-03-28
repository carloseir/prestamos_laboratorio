-- devoluciones

-- Procedimiento
DROP PROCEDURE devoluciones;

DELIMITER $$
CREATE PROCEDURE devoluciones(idalum int, idmat int,OUT valor int)
BEGIN
DECLARE existencia int;
DECLARE v_sal_del_ciclo INTEGER DEFAULT 0;
DECLARE ayuda int default 0;
DECLARE A int;
DECLARE B int;
DECLARE c int;
-- Declarancion de cursor
DECLARE cursor_p CURSOR FOR SELECT idprestamo
FROM prestamos p WHERE id_cuenta=idalum and idMaterial=idmat and fech_devuelto IS NULL;
-- Cuando no existan mas datos que leer de la tabla se iguala variable v_sal_del_ciclo =1
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_sal_del_ciclo = 1;
SET c=0;
SET existencia=(SELECT COUNT(cantidad)FROM prestamos p
 WHERE id_cuenta=idalum and idMaterial=idmat and fech_devuelto IS NULL);
-- Open cursor
OPEN cursor_p;
IF existencia > 0 THEN
lee_prestamos: LOOP
-- FETCH cursor
FETCH cursor_p into ayuda;
IF v_sal_del_ciclo = 1 THEN
LEAVE lee_prestamos;
ELSE
SET A=(SELECT prestados FROM materiales WHERE idMaterial=idmat);
SET B=(SELECT cantidad from prestamos WHERE id_cuenta=idalum and idMaterial=idmat and idprestamo=ayuda and fech_devuelto IS NULL);
SET c=(A-B);
UPDATE prestamos SET fech_devuelto=(CURDATE()) WHERE id_cuenta=idalum and idMaterial=idmat and idprestamo=ayuda;
UPDATE materiales SET prestados=c WHERE idMaterial=idmat;
END IF;
-- IF v_sal_del_ciclo = 1 THEN
END LOOP lee_prestamos;
END IF;
-- IF existencia >0 THEN
IF existencia = 0 or existencia IS NULL THEN
SET valor=-1;
END IF;
IF existencia >0 THEN
SET valor= 1;
END if;
CLOSE cursor_p;
END $$
DELIMITER ;
CALL devoluciones(1,1,@valor);
