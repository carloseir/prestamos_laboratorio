#include "tipos.h"

int main (void) {

  //variables
  int opcion_ingreso, opcion_admin, opcion_buscar_usuario, opcion_normal;
  //variables mysql
  char *server = "localhost";
  char *user = "ic19cir";
  char *passwd = "215574";
  char *db = "ic19cir";

  VARIABLES *conexion = malloc(sizeof(VARIABLES));

  mysql_init(&conexion->mysql); // Prepara la conexion al servidor de bases de datos
  // Se conecta al servidor de base de datos y verifica que no haya error
  if (!mysql_real_connect(&conexion->mysql, server, user, passwd, db, 0, NULL, 0)) {
    printf("Failed to connect to database: Error: %s\n", mysql_error(&conexion->mysql));
  }
  // Se conecta a la base de datos deseada
  if( mysql_select_db(&conexion->mysql, db) ){
    printf("Error selecting database: Error: %s\n", mysql_error(&conexion->mysql));
    abort();
  }

  do{

    //ingresar
    printf("\nNum. de cuenta: ");
    scanf("%d", &conexion->num_cuenta);
    printf("Contrasena: ");
    __fpurge(stdin);
    gets(conexion->contra);
    //__fpurge(stdin);

    opcion_ingreso = ingreso (conexion);//procedure
  }while( (opcion_ingreso != 0) && (opcion_ingreso != 1) ); //ingreso

  //ADMIN
  if (opcion_ingreso == 0) {

    do{

      opcion_admin = menu_admin();

      if(opcion_admin == 1)
      registrar_admin(conexion);
      if(opcion_admin == 2)
      buscar_admin(conexion);
      if(opcion_admin == 3)
      editar_usuario(conexion);
      if( (opcion_admin < 1) || (opcion_admin > 4) )
      printf("Opción invalida.\n");

    }while(opcion_admin != 4);//salir
  }//if

  else
  {
    //USUARIO NORMAL
    if(opcion_ingreso == 1)
    {
      do{
        opcion_normal = menu_normal();

        if(opcion_normal == 1)
        buscar_material(conexion);
        if(opcion_normal == 2)
        prestamo(conexion);
        if (opcion_normal == 3)
        devolucion(conexion);
        if( (opcion_normal < 1) || (opcion_normal > 4) )
        printf("Opcion invalida.\n");

      }while(opcion_normal != 4);//Salir
    }//if

    else
    printf("Error. Usuario no encontrado.\n");
  }//else
  mysql_close(&conexion->mysql);//cierra la conexion con al servidor
}//main
