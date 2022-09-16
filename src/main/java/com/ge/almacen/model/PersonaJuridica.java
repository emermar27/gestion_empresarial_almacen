package com.ge.almacen.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "persona_juridica")
@PrimaryKeyJoinColumn(name = "id")
public class PersonaJuridica extends Persona {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "nit", nullable = false)
	private String nit;
	
	@Column(name = "digito_verificacion", nullable = false)
	private String digitoVerificacion;
	
	@Column(name = "des_empresa", nullable = false)
	private String des_empresa;

	public String getNit() {
		return nit;
	}

	public void setNit(String nit) {
		this.nit = nit;
	}

	public String getDigitoVerificacion() {
		return digitoVerificacion;
	}

	public void setDigitoVerificacion(String digitoVerificacion) {
		this.digitoVerificacion = digitoVerificacion;
	}

	public String getDes_empresa() {
		return des_empresa;
	}

	public void setDes_empresa(String des_empresa) {
		this.des_empresa = des_empresa;
	}
	
	

}
