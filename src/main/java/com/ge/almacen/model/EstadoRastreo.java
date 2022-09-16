package com.ge.almacen.model;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "estado_rastreo")
@SequenceGenerator(name = "seq_estado_rastreo", sequenceName = "seq_estado_rastreo", allocationSize = 1, initialValue = 1)
public class EstadoRastreo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_estado_rastreo")
	private Long id;
	
	private String centroDistribucion;
	
	private String ciudad;
	
	private String departamento;
	
	private String municipio;
	
	private String status;
	
	private String observacion;
	
	@ManyToOne
	@JoinColumn(name = "venta_compra_tv_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "venta_compra_tv_fk"))
	private VentaCompraTiendaVirtual ventaCompraTiendaVirtual;
	
	@ManyToOne(targetEntity = Persona.class)
	@JoinColumn(name = "empresa_id", nullable = false, 
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "empresa_fk"))
	private Persona empresa;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getCentroDistribucion() {
		return centroDistribucion;
	}

	public void setCentroDistribucion(String centroDistribucion) {
		this.centroDistribucion = centroDistribucion;
	}

	public String getCiudad() {
		return ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}

	public String getDepartamento() {
		return departamento;
	}

	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}

	public String getMunicipio() {
		return municipio;
	}

	public void setMunicipio(String municipio) {
		this.municipio = municipio;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public VentaCompraTiendaVirtual getVentaCompraTiendaVirtual() {
		return ventaCompraTiendaVirtual;
	}

	public void setVentaCompraTiendaVirtual(VentaCompraTiendaVirtual ventaCompraTiendaVirtual) {
		this.ventaCompraTiendaVirtual = ventaCompraTiendaVirtual;
	}
	
	public Persona getEmpresa() {
		return empresa;
	}

	public void setEmpresa(Persona empresa) {
		this.empresa = empresa;
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
		EstadoRastreo other = (EstadoRastreo) obj;
		return Objects.equals(id, other.id);
	}
	
	

}
