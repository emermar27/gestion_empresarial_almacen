package com.ge.almacen.repository;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ge.almacen.model.Usuario;

@Repository
public interface UsuarioRepository extends CrudRepository<Usuario, Long> {
	
	@Query(value = "select u from Usuario u where u.login = ?1")
	Usuario buscarPorLogin(String login);
	
	@Query(value = "select u from Usuario u where u.persona.id = ?1 or u.login = ?2")
	Usuario buscarPorIdEmail(Long id, String email);
	
	@Query(value = "select constraint_name from information_schema.constraint_column_usage where table_name = 'usuarios_acesso' and column_name = 'acceso_id' and constraint_name <> 'unique_acceso_user';", nativeQuery = true)
	String consultaConstraintAcceso();

	@Transactional
	@Modifying
	@Query(nativeQuery = true, value = "insert into usuarios_acceso(usuario_id, acceso_id) values (?1, (select id from acceso where des_acceso = 'ROLE_USER'))")
	void insertarAccesoUserPj(Long id);

}




















