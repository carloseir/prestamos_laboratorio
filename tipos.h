#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

//TIPOS
typedef struct mysql_conexion {
  MYSQL mysql;
  MYSQL_RES *res;
  MYSQL_ROW row;
  MYSQL_FIELD *fields;

  int num_cuenta;
  char contra[15];

}VARIABLES;


//FUNCIONES
extern int ingreso (VARIABLES *conexion);
extern int menu_admin();
extern int menu_normal();
extern int menu_buscar_usuario();

extern void registrar_admin (VARIABLES *conexion);
extern void buscar_admin (VARIABLES *conexion);
extern void editar_usuario (VARIABLES *conexion);

extern void buscar_material (VARIABLES *conexion);
extern void prestamo (VARIABLES *conexion);
extern void devolucion (VARIABLES *conexion);
