#include "tipos.h"
//ADMINISTRADOR

void registrar_admin (VARIABLES *conexion){

  char nombre[50], ap_paterno[50], ap_materno[50], nombre_carrera[100], fecha_nac[20], correo[60], contra[50], tipo[20];
  int semestre, num_cuenta;
  char query1[500], query2[25];
  int salida;//salida del procedure

  printf("\nNombre: ");
  __fpurge(stdin);
  gets(nombre);
  printf("Apellido paterno: ");
  __fpurge(stdin);
  gets(ap_paterno);
  printf("Apellido materno: ");
  __fpurge(stdin);
  gets(ap_materno);
  printf("Carrera: ");
  __fpurge(stdin);
  gets(nombre_carrera);
  printf("Semestre: ");
  scanf("%d", &semestre);
  printf("Fecha de nacimiento en (AAAA-MM-DD): ");
  __fpurge(stdin);
  gets(fecha_nac);
  printf("Numero de cuenta: ");
  scanf("%d", &num_cuenta);
  printf("Correo electronico: ");
  __fpurge(stdin);
  gets(correo);
  printf("Contrasenia: ");
  __fpurge(stdin);
  gets(contra);
  printf("Tipo (Administrador o Normal): ");
  __fpurge(stdin);
  gets(tipo);
  //Ejecuta query
  sprintf (query1, "CALL registro ('%s','%s', '%s', '%s', %d, '%s', %d, '%s', '%s', '%s', @salida);", nombre, ap_paterno, ap_materno, nombre_carrera, semestre, fecha_nac, num_cuenta, correo, contra, tipo);
  puts(query1);
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
    if (salida == -1)
      printf("\nError. Usuario no registrado.\n");
    if (salida == 1)
      printf("\nUsuario registrado con exito.\n");
  }//if !=null
  mysql_free_result(conexion->res);//Liberar resultset
}//registrar_admin


void buscar_admin (VARIABLES *conexion){

  char parametro[90], query[128];
  //Impresion
  int i = 0;
  char campo1[15] = "NOMBRE(S)", campo2[15] = "AP. PATERNO", campo3[15] = "AP. MATERNO";
  char campo4[15] = "CANTIDAD", campo5[20] = "FECHA DE PRESTAMO", campo6[15] = "MATERIAL";

  printf("\nBusque por cualquier categoria: ");
  __fpurge(stdin);
  gets(parametro);

  //Ejecuta query
  sprintf (query, "CALL busqueda_admin ('%s');", parametro);
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
  printf("\n%25s %25s %25s %25s %25s %20s\n", campo1, campo2, campo3, campo4, campo5, campo6);
  while( (conexion->row = mysql_fetch_row(conexion->res)) ){
    i = 0;
    printf("____________________________________________________________________________________________________________________________________________________________________\n");
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
}//buscar_admin


void editar_usuario (VARIABLES *conexion){

  //call admin_editar('Rodriguez',3,1);
  char nuevo_valor[90], query[170];
  int id, opcion;

  printf("\n1.Modificar nombre.\n2.Modificar apellido paterno.\n3.Modificar apellido materno.\n4.Modificar carrera.\n5.Modificar semestre.\n6 Modificar fecha de nacimiento.\n7.Modificar correo electronico.\n8.Modificar contrasena.\n9.Modificar tipo.\nCualquier otro.REGRESAR\n>");
  scanf("%d", &opcion);
  if (opcion < 1 || opcion > 9)
  printf("Regresando.\n");

  else {

    printf("\nNumero de cuenta del usuario a modificar: ");
    __fpurge(stdin);
    scanf("%d", &id);
    __fpurge(stdin);
    printf("Nuevo valor: ");
    gets(nuevo_valor);
    __fpurge(stdin);
    //Ejecuta query
    sprintf (query, "CALL admin_editar ('%s', %d, %d, @salida);", nuevo_valor, opcion, id);
    if(mysql_query(&conexion->mysql, query)){
      printf("Error: %s\n", mysql_error(&conexion->mysql) );
      abort();
    }//else

    else
    printf("\nUsuario editado con exito.\n");
  }//else
}//editar_usuario
