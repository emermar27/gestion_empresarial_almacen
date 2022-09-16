package com.ge.almacen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Calendar;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ge.almacen.controller.AccesoController;
import com.ge.almacen.model.Acceso;
import com.ge.almacen.repository.AccesoRepository;

@Profile("dev")/*PARA TRABAJAR CON ARCHIVO application-dev.properties*/
@SpringBootTest(classes = GestionEmpresarialAlmacenApplication.class)
public class GestionEmpresarialAlmacenApplicationTests {

	@Autowired
	private AccesoController accesoController;
	
	@Autowired
	private AccesoRepository accesoRepository;
	
	@Autowired
	private WebApplicationContext ewbApplicationContext;
	
	@Test
	public void testRestApiRegistrarAcceso() throws JsonProcessingException, Exception {
		
		DefaultMockMvcBuilder defaultMockMvcBuilder = MockMvcBuilders.webAppContextSetup(this.ewbApplicationContext);
		MockMvc mockMvc = defaultMockMvcBuilder.build();
		
		Acceso acceso = new Acceso();
		
		acceso.setDesAcceso("ROLE_COMPRADOR" + Calendar.getInstance().getTimeInMillis());
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.post("/guardarAcceso")
										.content(objectMapper.writeValueAsString(acceso))
										.accept(MediaType.APPLICATION_JSON)
										.contentType(MediaType.APPLICATION_JSON));
		
		System.out.println("Retorno de API" + resultActions.andReturn().getResponse().getContentAsString());
		
		Acceso objetoRetorno = objectMapper.readValue(resultActions.andReturn().getResponse().getContentAsString(),
				               Acceso.class);
		
		assertEquals(acceso.getDesAcceso(), objetoRetorno.getDesAcceso());
		
	}
	
	@Test
	public void testRestApiEliminarAcceso() throws JsonProcessingException, Exception {
		
		DefaultMockMvcBuilder defaultMockMvcBuilder = MockMvcBuilders.webAppContextSetup(this.ewbApplicationContext);
		MockMvc mockMvc = defaultMockMvcBuilder.build();
		
		Acceso acceso = new Acceso();
		
		acceso.setDesAcceso("ROLE_ELIMINAR");
		
		acceso = accesoRepository.save(acceso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.post("/eliminarAcceso")
										.content(objectMapper.writeValueAsString(acceso))
										.accept(MediaType.APPLICATION_JSON)
										.contentType(MediaType.APPLICATION_JSON));
		
		System.out.println("Retorno de API: " + resultActions.andReturn().getResponse().getContentAsString());
		System.out.println("Status de retorno: " + resultActions.andReturn().getResponse().getStatus());
		
		assertEquals("Registro eliminado correctamente", resultActions.andReturn().getResponse().getContentAsString());
		assertEquals(200, resultActions.andReturn().getResponse().getStatus());
		
	}
	
	@Test
	public void testRestApiEliminarAccesoPorId() throws JsonProcessingException, Exception {
		
		DefaultMockMvcBuilder defaultMockMvcBuilder = MockMvcBuilders.webAppContextSetup(this.ewbApplicationContext);
		MockMvc mockMvc = defaultMockMvcBuilder.build();
		
		Acceso acceso = new Acceso();
		
		acceso.setDesAcceso("ROLE_ELIMINAR_POR_ID");
		
		acceso = accesoRepository.save(acceso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.delete("/eliminarAccesoPorId/" + acceso.getId())
										.content(objectMapper.writeValueAsString(acceso))
										.accept(MediaType.APPLICATION_JSON)
										.contentType(MediaType.APPLICATION_JSON));
		
		System.out.println("Retorno de API: " + resultActions.andReturn().getResponse().getContentAsString());
		System.out.println("Status de retorno: " + resultActions.andReturn().getResponse().getStatus());
		
		assertEquals("Registro eliminado correctamente", resultActions.andReturn().getResponse().getContentAsString());
		assertEquals(200, resultActions.andReturn().getResponse().getStatus());
		
	}
	
	@Test
	public void testRestApiBuscarAccesoPorId() throws JsonProcessingException, Exception {
		
		DefaultMockMvcBuilder defaultMockMvcBuilder = MockMvcBuilders.webAppContextSetup(this.ewbApplicationContext);
		MockMvc mockMvc = defaultMockMvcBuilder.build();
		
		Acceso acceso = new Acceso();
		
		acceso.setDesAcceso("ROLE_BUSCAR_POR_ID");
		
		acceso = accesoRepository.save(acceso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.get("/buscarAccesoPorId/" + acceso.getId())
										.content(objectMapper.writeValueAsString(acceso))
										.accept(MediaType.APPLICATION_JSON)
										.contentType(MediaType.APPLICATION_JSON));
		
		assertEquals(200, resultActions.andReturn().getResponse().getStatus());
		
		Acceso accesoRetornado = objectMapper.readValue(resultActions.andReturn().getResponse().getContentAsString(), Acceso.class);
		
		assertEquals(acceso.getDesAcceso(), accesoRetornado.getDesAcceso());
		
	}
	
	@Test
	public void testRestApiBuscarAccesoPorDesc() throws JsonProcessingException, Exception {
		
		DefaultMockMvcBuilder defaultMockMvcBuilder = MockMvcBuilders.webAppContextSetup(this.ewbApplicationContext);
		MockMvc mockMvc = defaultMockMvcBuilder.build();
		
		Acceso acceso = new Acceso();
		
		acceso.setDesAcceso("ROLE_BUSCAR_POR_DES");
		
		acceso = accesoRepository.save(acceso);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.get("/buscarAccesoPorDes/POR_DES")
										.content(objectMapper.writeValueAsString(acceso))
										.accept(MediaType.APPLICATION_JSON)
										.contentType(MediaType.APPLICATION_JSON));
		
		assertEquals(200, resultActions.andReturn().getResponse().getStatus());
		
		List<Acceso> accesoRetornadoList = objectMapper.readValue(resultActions.andReturn().getResponse().getContentAsString(), 
				new TypeReference<List<Acceso>>() {});
		
		assertEquals(acceso.getDesAcceso(), accesoRetornadoList.get(0).getDesAcceso());
		
		accesoRepository.deleteById(acceso.getId());
		
	}
	
	@Test
	public void testCadastraAcesso() throws ExeptionApi {
		
		String descacesso = "ROLE_ADMIN" + Calendar.getInstance().getTimeInMillis();
		
		Acceso acesso = new Acceso();
		
		acesso.setDesAcceso(descacesso);
		
		assertEquals(true, acesso.getId() == null);

		/*Gravou no banco de dados*/
		acesso = accesoController.guardar(acesso).getBody();
		
		assertEquals(true, acesso.getId() > 0);
		
		/*Validar dados salvos da forma correta*/
		assertEquals(descacesso, acesso.getDesAcceso());
		
		/*Teste de carregamento*/
		
		Acceso acesso2 = accesoRepository.findById(acesso.getId()).get();
		
		assertEquals(acesso.getId(), acesso2.getId());
		
		/*Teste de delete*/
		
		accesoRepository.deleteById(acesso2.getId());
		
		accesoRepository.flush(); /*Roda esse SQL de delete no banco de dados*/
		
		Acceso acesso3 = accesoRepository.findById(acesso2.getId()).orElse(null);
		
		assertEquals(true, acesso3 == null);
		
		/*Teste de query*/
		
		acesso = new Acceso();
		
		acesso.setDesAcceso("ROLE_ALUNO");
		
		acesso = accesoController.guardar(acesso).getBody();
		
		List<Acceso> acessos = accesoRepository.buscarAccesoPorDes("ALUNO".trim().toUpperCase());
		
		assertEquals(1, acessos.size());
		
		accesoRepository.deleteById(acesso.getId());
		
	}
}
































