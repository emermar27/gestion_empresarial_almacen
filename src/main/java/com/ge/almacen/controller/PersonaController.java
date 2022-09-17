package com.ge.almacen.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ge.almacen.ExeptionApi;
import com.ge.almacen.model.PersonaJuridica;

@RestController("/persona")
public class PersonaController {
	
	@ResponseBody
	@PostMapping()
	public ResponseEntity<PersonaJuridica> salvar(@RequestBody PersonaJuridica personaJuridica) throws ExeptionApi{
		
		if(personaJuridica == null) {
			throw new ExeptionApi("Objeto persona no puede ser NUll");
		}
		
		return new ResponseEntity<PersonaJuridica>(personaJuridica, HttpStatus.OK);
		
	}

}






















