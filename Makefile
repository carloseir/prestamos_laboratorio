prestamo: principal.o menus.o funciones_admin.o funciones_normal.o
	gcc -o prestamo principal.o menus.o funciones_admin.o funciones_normal.o -lnsl -lm -lz -lmysqlclient

principal.o: principal.c
	gcc -g -c principal.c

menus.o: menus.c
	gcc -g -c menus.c

funciones_admin.o: funciones_admin.c
	gcc -g -c funciones_admin.c

funciones_normal.o: funciones_normal.c
	gcc -g -c funciones_normal.c

clean:
	rm *.o
