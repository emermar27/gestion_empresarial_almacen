package com.ge.almacen.model;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

@Entity
@SequenceGenerator(name = "seq_imagen_producto", sequenceName = "seq_imagen_producto", allocationSize = 1, initialValue = 1)
public class ImagenProducto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_imagen_producto")
	private Long id;
	
	@Column(columnDefinition = "text", nullable = false)
	private String imagenOriginal;
	
	@Column(columnDefinition = "text", nullable = false)
	private String imagenMiniatura;
	
	@ManyToOne
	@JoinColumn(name = "producto_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "producto_fk"))
	private Producto producto;
	
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

	public String getImagenOriginal() {
		return imagenOriginal;
	}

	public void setImagenOriginal(String imagenOriginal) {
		this.imagenOriginal = imagenOriginal;
	}

	public String getImagenMiniatura() {
		return imagenMiniatura;
	}

	public void setImagenMiniatura(String imagenMiniatura) {
		this.imagenMiniatura = imagenMiniatura;
	}

	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
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
		ImagenProducto other = (ImagenProducto) obj;
		return Objects.equals(id, other.id);
	}
	
	

}



















