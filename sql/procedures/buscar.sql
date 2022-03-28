-- Procedimiento de busqueda para el admin
DELIMITER $$
CREATE PROCEDURE busqueda_admin(parametro varchar(100))
BEGIN
-- DECLARACION DE VARIABLES
DECLARE contador int default 0;
DECLARE cuentaa int default 0;
DECLARE error VARCHAR (50);
-- Nombre
SET contador = (SELECT COUNT(id_cuenta) FROM usuarios WHERE nombre = parametro);
IF (0 < contador )then
SELECT u.nombre,u.ap_paterno as apellido_paterno,u.ap_materno as apellido_materno,p.cantidad,p.fech_prestamo as fecha_prestamo,m.nombre as material
FROM usuarios  u LEFT JOIN prestamos p ON u.id_cuenta=p.id_cuenta
LEFT JOIN materiales m ON p.idMaterial=m.idMaterial
WHERE parametro = u.nombre;

 ELSE
-- end if;
-- Apellidos
-- Apellido paterno
SET contador =  (SELECT COUNT(id_cuenta) FROM usuarios WHERE ap_paterno = parametro);
IF (0 < contador and cuentaa = 0) then
SELECT u.nombre,u.ap_paterno as apellido_paterno,u.ap_materno as apellido_materno,p.cantidad,p.fech_prestamo as fecha_prestamo,m.nombre as material
FROM usuarios  u LEFT JOIN prestamos p ON u.id_cuenta=p.id_cuenta
LEFT JOIN materiales m ON p.idMaterial=m.idMaterial
WHERE parametro = u.ap_paterno;

SET cuentaa=1;
ELSE
-- end if;
-- Apellido Materno
SET contador =  (SELECT COUNT(id_cuenta) FROM usuarios WHERE ap_materno = parametro);
IF( 0 < contador and cuentaa=0 )then
SELECT u.nombre,u.ap_paterno as apellido_paterno,u.ap_materno as apellido_materno,p.cantidad,p.fech_prestamo as fecha_prestamo,m.nombre as material
FROM usuarios  u LEFT JOIN prestamos p ON u.id_cuenta=p.id_cuenta
LEFT JOIN materiales m ON p.idMaterial=m.idMaterial
WHERE parametro = u.ap_materno;
SET cuentaa=1;
ELSE
-- end if;
-- carrera
SET contador =  (SELECT COUNT(idcarrera) FROM info_carreras WHERE carrera = parametro);
IF (0 < contador ) THEN

SELECT u.nombre,u.ap_paterno as apellido_paterno,u.ap_materno as apellido_materno,p.cantidad,p.fech_prestamo as fecha_prestamo,m.nombre as material
FROM usuarios  u LEFT JOIN prestamos p ON u.id_cuenta=p.id_cuenta
LEFT JOIN materiales m ON p.idMaterial=m.idMaterial
LEFT JOIN info_carreras c ON c.idcarrera=u.idcarrera
WHERE parametro = c.carrera;
ELSE
-- END IF;
-- Nombre del material
SET contador =  (SELECT COUNT(nombre) FROM materiales WHERE nombre = parametro);
IF (0 < contador) THEN
SELECT u.nombre,u.ap_paterno as apellido_paterno,u.ap_materno as apellido_materno,p.cantidad,p.fech_prestamo as fecha_prestamo,m.nombre as material
FROM materiales m LEFT JOIN prestamos p ON p.idMaterial=m.idMaterial LEFT JOIN usuarios  u  ON u.id_cuenta=p.id_cuenta
WHERE parametro =m.nombre ;
ELSE
-- END IF;
-- cast
SET cuentaa = (SELECT CAST(parametro AS unsigned));
SET contador =(SELECT COUNT(id_cuenta) from usuarios WHERE cuentaa=id_cuenta);
IF contador> 0 THEN
SELECT u.nombre,u.ap_paterno as apellido_paterno,u.ap_materno as apellido_materno,p.cantidad,p.fech_prestamo as fecha_prestamo,m.nombre as material
FROM usuarios  u LEFT JOIN prestamos p ON u.id_cuenta=p.id_cuenta
LEFT JOIN materiales m ON p.idMaterial=m.idMaterial
WHERE parametro = u.id_cuenta;

END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
IF contador = 0 THEN
SET error= CONCAT('el parametro: ', parametro,' es no valido' );
SELECT error;
END IF;
END $$
DELIMITER ;

call busqueda_admin('Juan');

drop PROCEDURE busqueda_admin;



-- mostrar al  usuario materiales
DELIMITER $$
CREATE PROCEDURE muestre_materiales()
BEGIN
SELECT  nombre,idMaterial,cantidad,prestados as ocupados from materiales;
END $$
DELIMITER ;

CALL muestre_materiales();

DROP PROCEDURE muestre_materiales;
