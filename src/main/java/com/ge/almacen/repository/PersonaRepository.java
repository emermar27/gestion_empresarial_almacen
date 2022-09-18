package com.ge.almacen.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.ge.almacen.model.PersonaJuridica;

public interface PersonaRepository extends CrudRepository<PersonaJuridica, Long> {
	
	@Query(value = "select pj from PersonaJuridica pj where pj.nit = ?1")
	public PersonaJuridica buscarPersonaPorNit(String nit);
	
}
