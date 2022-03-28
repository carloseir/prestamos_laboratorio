--usuario podrá seleccionar cantidad y materiales disponibles del laboratorio,
--el programa deberá ser capaz de identificar si hay existencia o no para prestar

-- prestamos
DROP PROCEDURE prestamos;
DELIMITER $$
CREATE PROCEDURE prestamos(idalum int,idmat int,can int,OUT actual INT )
BEGIN
DECLARE resta int;
DECLARE existencia int;
DECLARE operaciones int;
DECLARE A INT;
DECLARE B INT;
SET existencia=(SELECT count(idMaterial) from materiales WHERE idMaterial=idmat);
SET A=(select cantidad from materiales WHERE idMaterial=idmat);
SET B=(SELECT prestados from materiales WHERE idMaterial=idmat);
SET operaciones=A-B;
SET resta=operaciones-can;
IF resta>=0 and existencia=1 THEN
INSERT INTO prestamos(id_cuenta,idMaterial,cantidad,fech_prestamo)VALUES(idalum,idmat,can,CURDATE());
SET operaciones=(B+can);
UPDATE materiales SET prestados=operaciones WHERE idMaterial=idmat;
SET actual=1;
END IF;
IF resta<0 OR existencia <> 1 THEN
SET actual=-1;
END IF;
END $$
DELIMITER ;

Call prestamos(1,1,100,@actual);
