#include "tipos.h"

//USUARIO NORMAL

void buscar_material (VARIABLES *conexion){
  //CALL muestre_materiales();
  char query[50];
  //Impresion
  int i = 0;
  char campo1[15] = "MATERIAL", campo2[15] = "ID MATERIAL", campo3[15] = "CANTIDAD", campo4[15] = "EN PRESTAMO";
  //Ejecuta query
  sprintf (query, "CALL muestre_materiales();");
  if(mysql_query(&conexion->mysql, query)){
    printf("Error: %s\n", mysql_error(&conexion->mysql) );
    abort();
  }
  //Obtiene query
  if( !(conexion->res = mysql_store_result(&conexion->mysql) ) ) {
    printf ("Error storing results. Error: %s\n", mysql_error(&conexion->mysql) );
    abort();
  }
  //Guardar resultset
  printf("\n%25s %25s %25s %25s\n", campo1, campo2, campo3, campo4);
  while( (conexion->row = mysql_fetch_row(conexion->res)) ){
    i = 0;
    printf("____________________________________________________________________________________________________________\n");
    for( i=0 ; i < mysql_num_fields(conexion->res); i++ ){
      //Imprime resultset
      printf("%25s", conexion->row[i]);
    }
    fputc('\n', stdout);
  }//while
  //Liberar resultset
  while(mysql_next_result(&conexion->mysql) == 0){
  }
  mysql_free_result(conexion->res);
}//muestre_materiales


void prestamo (VARIABLES *conexion){
  //call prestamos (id int, id mat int, cantidad int, @actualizado int)
  char query1[150], query2[30];
  int id_material, cantidad, salida;

  printf("ID del material solicitado: ");
  scanf("%d", &id_material);
  printf("Cantidad solicitada: ");
  scanf("%d", &cantidad);
  //Ejecuta query
  sprintf (query1, "CALL prestamos (%d, %d, %d, @salida);", conexion->num_cuenta, id_material, cantidad);
  if(mysql_query(&conexion->mysql, query1)){
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
    if (salida == -1)
      printf("\nError. No es posible prestar.\n");
    if (salida == 1)
      printf("\nMaterial prestado con exito.\n");
  }//if !=null
  mysql_free_result(conexion->res);//Liberar resultset
}//prestamo


void devolucion (VARIABLES *conexion){
  //call devoluciones (id int, id mat int, @actualizado int)
  char query1[150], query2[30];
  int id_material, salida;

  printf("ID del material a regresar: ");
  scanf("%d", &id_material);

  //Ejecuta query
  sprintf (query1, "CALL devoluciones (%d, %d, @salida);", conexion->num_cuenta, id_material);
  if(mysql_query(&conexion->mysql, query1)){
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
    if (salida == -1)
      printf("\nError. No se pudo devolver.\n");
    if (salida == 1)
      printf("\nMaterial devuelto con exito.\n");
  }//if !=null
  mysql_free_result(conexion->res);//Liberar resultset
}//devolucion
