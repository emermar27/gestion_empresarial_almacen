package com.ge.almacen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EntityScan(basePackages = "com.ge.almacen.model")
@ComponentScan(basePackages = {"com.*"})
@EnableJpaRepositories(basePackages = {"com.ge.almacen.repository"})
@EnableTransactionManagement
public class GestionEmpresarialAlmacenApplication {

	public static void main(String[] args) {
		
		//System.out.println(new BCryptPasswordEncoder().encode("123"));		
		SpringApplication.run(GestionEmpresarialAlmacenApplication.class, args);
		//generaContrasena();
	}
	
	private static void generaContrasena() {
		System.out.println(new BCryptPasswordEncoder().encode("123"));
	}

}
