package com.ge.almacen.model;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
@Table(name = "acceso")
@SequenceGenerator(name = "seq_acceso", sequenceName = "seq_acceso", allocationSize = 1, initialValue = 1)
public class Acceso implements GrantedAuthority {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_acceso")
	private Long id;
	
	@Column(name="des_acceso", nullable = false)
	private String desAcceso;

	@JsonIgnore
	@Override
	public String getAuthority() {
		return this.desAcceso;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDesAcceso() {
		return desAcceso;
	}

	public void setDesAcceso(String desAcceso) {
		this.desAcceso = desAcceso;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Acceso other = (Acceso) obj;
		return Objects.equals(id, other.id);
	}
	
}















