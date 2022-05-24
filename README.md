<table>
<tr>
<td width="100px"><img src="https://github.com/OctavioBernalGH/BTC_Reus2022_UD16/blob/main/dou_logo.png" alt="Team DOU"/></td>
<td width="1000px"> <h2> Spring + JPA + H2 + Maven Ejercicio 1 Unidad 26 </h2> </td>

</tr>
</table>

[![Java](https://img.shields.io/badge/Java-FrontEnd-informational)]()
[![JBuilder](https://img.shields.io/badge/JBuilder-View-critical)]()
[![JUnit 5](https://img.shields.io/badge/JUnit%205-Testing-success)]()
[![GitHub](https://img.shields.io/badge/GitHub-Repository-lightgrey)]()
[![SQL](https://img.shields.io/badge/SQL-DataBase-yellowgreen)]()
[![Spring](https://img.shields.io/badge/Spring-infrastructure-brightgreen)]()
[![Maven](https://img.shields.io/badge/Maven-ProjectStructure-blueviolet)]()

Este ejercicio ha sido realizado por los miembros del equipo 1. Dicho equipo esta formado por:

[- Ixabel Justo Etxeberria](https://github.com/Kay-Nicte)<br>
[- J.Oriol López Bosch](https://github.com/mednologic)<br>
[- Octavio Bernal](https://github.com/OctavioBernalGH)<br>
[- David Dalmau](https://github.com/DavidDalmauDieguez)

<p align="justify">Se crea un proyecto Maven utilizando la tecnología spring, se definen como componentes los spring services, la base de datos H2 y JPA. Se crea la estructura de proyecto en capas definiendo los paquetes de controllers, dao, dto y services. Para proseguir se crean las entidades 'piezas', 'proveedores',  y 'suministra' con una relación de uno a muchos (one to many). Se definen las columnas y mediante anotaciones se mapea con los atributos de la entidad.</p>

A continuación se expondrá el desarrollo completo de la aplicación. A la hora de comenzar con un proyecto Spring es muy importante configurar el fichero application.propierties ubicado en la carpeta de resources. En este caso la configuración queda tal que así:

<p align="center">
  <img src="https://user-images.githubusercontent.com/103035621/170081139-436a265f-4dd0-4fe3-b1d8-379d39ab10c5.png">
</p>

El siguiente paso corresponde a la definición de la base de datos según el esquema entidad relación, para ello se ha creado un script de creación de base de datos con varias tuplas de datos de prueba. El fichero es denominado data.sql y está ubicado en la misma carpeta que el application.propierties. A continuación se puede observar el código generado:

```sql
drop database if exists UD26_Ejercicio_1;
create database if not exists UD26_Ejercicio_1;

use UD26_Ejercicio_1;

create table piezas
(
	id int auto_increment,
    nombre varchar(100),
    primary key (id)    
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
    foreign key (codigo_pieza) references piezas(id),
    foreign key (id_proveedor) references proveedores(id)
);

insert into suministra (codigo_pieza, id_proveedor, precio) values (1, 1, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (2, 2, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (3, 3, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (4, 4, 150);
insert into suministra (codigo_pieza, id_proveedor, precio) values (5, 5, 150);
```

El siguiente paso será crear las diferentes clases, cada clase representa una tabla y los atributos de cada clase representan las columnas de la base de datos, de esta manera mediante las diferentes anotaciones creamos un mapeo entre objeto-tabla.

Las principales anotaciones a la hora de mapear una clase con la tabla son:

@Entity --> Se va a crear una entidad.<br>
@Table(name = "nombre de la tabla") --> El nombre de la tabla corresponde a...<br>
@Id --> El siguiente atributo será la clave primaria.<br>
@GeneratedValue(strategy = GeneratedType.IDENTITY) --> La clave primaria se generará de forma auto incremental.<br>
@Column(name = "nombre_col") --> El nombre de la columna corresponde al atributo de abajo.<br>
private TipoVariable nombreCol;

A continuación se dejan tres spoilers con el código generado en las clases.

<details>
  
<summary>Código entidad Piezas</summary>
  
<br>
  
```java
package com.example.demo.dto;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="piezas")
public class Piezas {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)//busca ultimo valor y lo incrementa
	private Long id;
	
	@Column(name="nombre")
	private String nombre;

	// One to many
	@OneToMany
	@JoinColumn(name="id")
	private List<Suministra> suministra;

	//Constructores
	public Piezas() {

	}

	public Piezas(Long id, String nombre, List<Suministra> suministra) {
		this.id = id;
		this.nombre = nombre;
		this.suministra = suministra;
	}

	public Long getCodigo() {
		return id;
	}

	public void setCodigo(Long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setSuministra(List<Suministra> suministra) {
		this.suministra = suministra;
	}
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "Suministra")
	public List<Suministra> getSuministra() {
		return suministra;
	}
	
	@Override
	public String toString() {
		return "Piezas [codigo=" + id + ", nombre=" + nombre + ", suministra=" + suministra + "]";
	} 
}
  
```
  
</details>




<details>
  
<summary>Código entidad Proveedores</summary>
  
<br>
  
```java
package com.example.demo.dto;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="proveedores")
public class Proveedores {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)//busca ultimo valor y lo incrementa
	private Long id;

	@Column(name="nombre")
	private String nombre;

	// One to many
	@OneToMany
	@JoinColumn(name="id")
	private List<Suministra> suministra;
	
	//Constructores
	public Proveedores () {
		
	}

	public Proveedores(Long id, String nombre, List<Suministra> suministra) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.suministra = suministra;
	}

	// Getters y setters
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "Suministra")
	public List<Suministra> getSuministra() {
		return suministra;
	} 

	public void setSuministra(List<Suministra> suministra) {
		this.suministra = suministra;
	}

	
}
  
```
  
</details>




<details>
  
<summary>Código entidad Suministra</summary>
  
<br>
  
```java
package com.example.demo.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="suministra")
public class Suministra {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name="codigo_pieza")
	private Piezas piezas;
	
	@ManyToOne
	@JoinColumn(name="id_proveedor")
	private Proveedores proveedores;
	
	@Column(name="precio")
	private int precio;
	
	//Constructores
	public Suministra() {
		
	}

	/**
	 * @param id
	 * @param codigoPieza
	 * @param idProveedor
	 * @param precio
	 */
	public Suministra(Long id, Piezas piezas, Proveedores proveedores, int precio) {
		super();
		this.id = id;
		this.piezas = piezas;
		this.proveedores = proveedores;
		this.precio = precio;
	}

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the piezas
	 */
	public Piezas getPiezas() {
		return piezas;
	}

	/**
	 * @param piezas the piezas to set
	 */
	public void setPiezas(Piezas piezas) {
		this.piezas = piezas;
	}

	/**
	 * @return the proveedores
	 */
	public Proveedores getProveedores() {
		return proveedores;
	}

	/**
	 * @param proveedores the proveedores to set
	 */
	public void setProveedores(Proveedores proveedores) {
		this.proveedores = proveedores;
	}

	/**
	 * @return the precio
	 */
	public int getPrecio() {
		return precio;
	}

	/**
	 * @param precio the precio to set
	 */
	public void setPrecio(int precio) {
		this.precio = precio;
	}

}  
```
  
</details>
