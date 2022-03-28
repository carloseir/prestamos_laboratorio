#include "tipos.h"

int menu_admin () {
  int opcion;
  printf("\n1.Registrar usuarios\n2.Buscar usuarios\n3.Modificar usuarios.\n4.SALIR\n>");
  scanf("%d", &opcion);
  return opcion;
}//menu_admin

int menu_normal () {
  int opcion;
  printf("\n1.Buscar material\n2.Prestamo\n3.Devolucion\n4.SALIR\n>");
  scanf("%d", &opcion);
  return opcion;
}//menu_normal

int ingreso (VARIABLES *conexion){

  char query1[100], query2[100];
  int salida=5;
  //Ejecuta query
  sprintf (query1, "CALL ingreso (%d,'%s',@salida);", conexion->num_cuenta, conexion->contra);
  if(mysql_query(&conexion->mysql, query1 )){
    printf("Error: %s\n", mysql_error(&conexion->mysql) );
    abort();
  }
  //Ejecuta query
  sprintf (query2, "SELECT @salida;");
  if(mysql_query(&conexion->mysql, query2) ){
    printf("Error: %s\n", mysql_error(&conexion->mysql) );
    abort();
  }
  //Obtiene query
  if( !(conexion->res = mysql_store_result(&conexion->mysql) ) ) {
    printf ("Error storing results. Error: %s\n", mysql_error(&conexion->mysql) );
    abort();
  }
  //Guadar resultset
  conexion->row = mysql_fetch_row(conexion->res);
  //Imprime resultset
  if(conexion->row[0] != NULL){

    salida = atoi(conexion->row[0]);
    if (salida == 0)
      printf("\nINGRESO COMO ADMIN.\n");
    if (salida == 1)
      printf("\nINGRESO COMO USUARIO NORMAL.\n");
  }//if !=null
  mysql_free_result(conexion->res);//Liberar resultset
  return salida;
}//ingreso
