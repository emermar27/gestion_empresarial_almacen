package com.ge.almacen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ge.almacen.ExeptionApi;
import com.ge.almacen.model.Acceso;
import com.ge.almacen.repository.AccesoRepository;
import com.ge.almacen.service.AccesoService;

@Controller
@RestController
@RequestMapping
public class AccesoController {
	
	@Autowired
	private AccesoService accesoService;
	
	@Autowired
	private AccesoRepository accesoRepository;
	
	@ResponseBody /*Poder dar un retorno a la API*/
	@PostMapping(value = "**/guardarAcceso") /*Mapear la URL para recibir JSON*/
	public ResponseEntity<Acceso> guardar(@RequestBody Acceso acceso) throws ExeptionApi { /*Recibir el JSON y convertir para objeto*/
		
		if(acceso.getId() == null) {
			List<Acceso> accesos = accesoService.buscarAccesoPorDesc(acceso.getDesAcceso().toUpperCase());
			if(!accesos.isEmpty()) {
				throw new ExeptionApi("Ya existe un Acceso con esa descripcion: " + acceso.getDesAcceso());
			}
		}
		
		Acceso guardar = accesoService.guardar(acceso);
		
		return new ResponseEntity<Acceso>(guardar, HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar un retorno a la API*/
	@PostMapping(value = "**/eliminarAcceso") /*Mapear la URL para recibir JSON*/
	public ResponseEntity<?> eliminar(@RequestBody Acceso acceso) { /*Recibir el JSON y convertir para objeto*/
		
		accesoService.eliminar(acceso);
		
		return new ResponseEntity("Registro eliminado correctamente", HttpStatus.OK);
		
	}


	@ResponseBody /*Poder dar un retorno a la API*/
	@DeleteMapping(value = "**/eliminarAccesoPorId/{id}") /*Mapear la URL para recibir JSON*/
	public ResponseEntity<?> eliminar(@PathVariable("id") Long id) { /*Recibir el JSON y convertir para objeto*/
		
		accesoService.eliminarPorId(id);
		
		return new ResponseEntity("Registro eliminado correctamente", HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar un retorno a la API*/
	@GetMapping(value = "**/buscarAccesoPorId/{id}")
	public ResponseEntity<Acceso> buscarPorId(@PathVariable("id") Long id) throws ExeptionApi {
		
		Acceso acceso = accesoRepository.findById(id).orElse(null);
		
		//Acceso acceso = accesoService.buscarPorId(id);
		
		if(acceso == null) {
			throw new ExeptionApi("Registro con ID: " + id + " no encontrado" );
		}
				
		return new ResponseEntity<Acceso>(acceso, HttpStatus.OK);
		
		
	}
	
	@ResponseBody /*Poder dar un retorno a la API*/
	@GetMapping(value = "**/buscarAccesoPorDes/{desc}")
	public ResponseEntity<List<Acceso>> buscarPorId(@PathVariable("desc") String desc) {
		
		List<Acceso> acceso = accesoService.buscarAccesoPorDesc(desc.toUpperCase());
		
		return new ResponseEntity<List<Acceso>>(acceso, HttpStatus.OK);
	}

}

















