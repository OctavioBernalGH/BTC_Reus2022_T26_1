package com.example.demo.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.dto.Proveedores;

@Repository
//Repositorio de funcion es de base de datos
public interface ProveedoresDAO extends JpaRepository<Proveedores,Long>{

}
