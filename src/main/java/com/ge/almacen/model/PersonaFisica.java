package com.ge.almacen.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "persona_fisica")
@PrimaryKeyJoinColumn(name = "id")
public class PersonaFisica extends Persona {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "nro_dto", nullable = false)
	private String nroDto;
	
	@Column(name = "fecha_nto", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date fechaNto;

	public String getNroDto() {
		return nroDto;
	}

	public void setNroDto(String nroDto) {
		this.nroDto = nroDto;
	}

	public Date getFechaNto() {
		return fechaNto;
	}

	public void setFechaNto(Date fechaNto) {
		this.fechaNto = fechaNto;
	}
	
	

}
