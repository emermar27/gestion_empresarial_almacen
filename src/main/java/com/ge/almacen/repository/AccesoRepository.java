package com.ge.almacen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ge.almacen.model.Acceso;

@Repository
@Transactional
public interface AccesoRepository extends JpaRepository<Acceso, Long> {
	
	@Query("select a from Acceso a where upper(trim(a.desAcceso)) like %?1%")
	List<Acceso> buscarAccesoPorDes(String desc);

}
