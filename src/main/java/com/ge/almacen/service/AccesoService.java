package com.ge.almacen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ge.almacen.model.Acceso;
import com.ge.almacen.repository.AccesoRepository;

@Service
public class AccesoService {
	
	@Autowired
	private AccesoRepository accesoRepository;
	
	public Acceso guardar(Acceso acceso) {
		return accesoRepository.save(acceso);
	}
	
	public void eliminar(Acceso acceso) {
		accesoRepository.deleteById(acceso.getId());
	}
	
	public void eliminarPorId(Long id) {
		accesoRepository.deleteById(id);
	}
	
	public Acceso buscarPorId(Long id) {
		return accesoRepository.findById(id).get();
	}
	
	public List<Acceso> buscarAccesoPorDesc(String desc) {
		return accesoRepository.buscarAccesoPorDes(desc);
	}

}
















