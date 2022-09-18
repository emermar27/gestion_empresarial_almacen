package com.ge.almacen;

import java.util.Calendar;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

import com.ge.almacen.controller.PersonaController;
import com.ge.almacen.model.PersonaJuridica;
import junit.framework.TestCase;

@Profile("dev")/*PARA TRABAJAR CON ARCHIVO application-dev.properties*/
@SpringBootTest(classes = GestionEmpresarialAlmacenApplication.class)
public class TestePersona {
	
	@Autowired
	private PersonaController personaController;
	
	@Test
	public void testCrearPersonaFisica() throws ExeptionApi {
		
		PersonaJuridica personaJuridica = new PersonaJuridica();
		personaJuridica.setNombres("Ermelson");
		personaJuridica.setApellidos("Martinez Viveros");
		personaJuridica.setNit("" + Calendar.getInstance().getTimeInMillis());
		personaJuridica.setDigitoVerificacion("7");
		personaJuridica.setDes_empresa("FamilySoft");
		personaJuridica.setEmail("emermar27@hotmail.com");
		personaJuridica.setTelefono("3117397474");
		personaJuridica.setTipoPersona("12");
		
		personaController.salvar(personaJuridica);
		
		//personaController.salvar(null);
		
	}

}
