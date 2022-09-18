package com.ge.almacen.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ge.almacen.ExeptionApi;
import com.ge.almacen.model.PersonaJuridica;
import com.ge.almacen.repository.PersonaRepository;
import com.ge.almacen.service.PersonaUserService;

@RestController
public class PersonaController {
	
	@Autowired
	private PersonaRepository personaRepository;
	
	@Autowired
	private PersonaUserService personaUserService;
	
	@ResponseBody
	@PostMapping(value = "/salvarPersona")
	public ResponseEntity<PersonaJuridica> salvar(@RequestBody PersonaJuridica personaJuridica) throws ExeptionApi{
		
		if(personaJuridica == null) {
			throw new ExeptionApi("Objeto persona no puede ser NUll");
		}
		if(personaJuridica.getId() == null && personaRepository.buscarPersonaPorNit(personaJuridica.getNit()) != null) {
			throw new ExeptionApi("Ya existe un registro con el Nit: " + personaJuridica.getNit());
		}
		
		personaJuridica = personaUserService.salvar(personaJuridica);
		
		return new ResponseEntity<PersonaJuridica>(personaJuridica, HttpStatus.OK);
		
	}

}






















