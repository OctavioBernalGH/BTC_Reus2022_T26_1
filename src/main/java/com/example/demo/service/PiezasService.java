package com.example.demo.service;

import java.util.List;

import com.example.demo.dto.Piezas;


public interface PiezasService {
	public List<Piezas> listarPiezas();
	
	public Piezas crearPiezas(Piezas piezas);

	public Piezas modificarPiezas(Piezas piezas);

	public void eliminarPiezas(Long id);

	public Piezas buscarPiezas(Long id);
	
}
