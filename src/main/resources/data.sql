drop database if exists UD26_Ejercicio_1;
create database if not exists UD26_Ejercicio_1;

use UD26_Ejercicio_1;

create table piezas
(
	codigo int auto_increment,
    nombre varchar(100),
    primary key (codigo)    
);

insert into piezas (nombre) values ('tornillo');
insert into piezas (nombre) values ('tuerca');
insert into piezas (nombre) values ('martillo');
insert into piezas (nombre) values ('puerta');
insert into piezas (nombre) values ('lechuga');

create table proveedores
(
	id int auto_increment,
    nombre varchar(100),
	primary key (id)
);

insert into proveedores (nombre) values ('Paco vendedor');
insert into proveedores (nombre) values ('Manolo vendedor');
insert into proveedores (nombre) values ('Maria vendedor');
insert into proveedores (nombre) values ('Cristina vendedor');
insert into proveedores (nombre) values ('Manuela vendedor');

create table suministra
(
	id int auto_increment,
	codigo_pieza int,
    id_proveedor int,
    precio int,
    primary key (id),
    foreign key (codigo_pieza) references piezas(codigo),
    foreign key (id_proveedor) references proveedores(id)
);

insert into suministra (codigo_pieza, id_proveedor, precio) values (1, 1, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (2, 2, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (3, 3, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (4, 4, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (5, 5, 150);