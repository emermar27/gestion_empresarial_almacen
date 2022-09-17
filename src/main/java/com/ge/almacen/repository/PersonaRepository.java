package com.ge.almacen.repository;

import org.springframework.data.repository.CrudRepository;

import com.ge.almacen.model.Persona;

public interface PersonaRepository extends CrudRepository<Persona, Long> {
	
}
