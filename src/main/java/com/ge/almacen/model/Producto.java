package com.ge.almacen.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@Table(name = "producto")
@SequenceGenerator(name = "seq_producto", sequenceName = "seq_producto", allocationSize = 1, initialValue = 1)
public class Producto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_producto")
	private Long id;
	
	@Column(name = "tipo_unidad", nullable = false)
	private String tipoUnidad;
	
	@Column(name = "nombre_producto", nullable = false)
	private String nombreProducto;
	
	@Column(nullable = false)
	private Boolean activo = Boolean.TRUE;
	
	@Column(name = "des_producto", columnDefinition = "text", length = 2000, nullable = false)
	private String desProducto;
	
	/*ASOCICAIR NOTO_ITEM_PRODUCTO*/
	
	@Column(nullable = false)
	private Double peso;
	
	@Column(nullable = false)
	private Double largura;
	
	@Column(nullable = false)
	private Double altura;
	
	@Column(nullable = false)
	private Double profundidad;
	
	@Column(nullable = false)
	private BigDecimal valorVenta = BigDecimal.ZERO;
	
	@Column(nullable = false)
	private Integer cantidadStop = 0;
	
	private Integer cantidadAlertaStop = 0;
	
	private String linkYoutube;
	
	private Boolean alertaCantidadStop = Boolean.FALSE;
	
	private Integer cantidadClique = 0;
	
	@ManyToOne
	@JoinColumn(name = "marca_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "marca_fk"))
	private Marca marca;
	
	@ManyToOne
	@JoinColumn(name = "categoria_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "categoria_fk"))
	private Categoria categoria;
	
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

	public String getTipoUnidad() {
		return tipoUnidad;
	}

	public void setTipoUnidad(String tipoUnidad) {
		this.tipoUnidad = tipoUnidad;
	}

	public String getNombreProducto() {
		return nombreProducto;
	}

	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}

	public Boolean getActivo() {
		return activo;
	}

	public void setActivo(Boolean activo) {
		this.activo = activo;
	}

	public String getDesProducto() {
		return desProducto;
	}

	public void setDesProducto(String desProducto) {
		this.desProducto = desProducto;
	}

	public Double getPeso() {
		return peso;
	}

	public void setPeso(Double peso) {
		this.peso = peso;
	}

	public Double getLargura() {
		return largura;
	}

	public void setLargura(Double largura) {
		this.largura = largura;
	}

	public Double getAltura() {
		return altura;
	}

	public void setAltura(Double altura) {
		this.altura = altura;
	}

	public Double getProfundidad() {
		return profundidad;
	}

	public void setProfundidad(Double profundidad) {
		this.profundidad = profundidad;
	}

	public BigDecimal getValorVenta() {
		return valorVenta;
	}

	public void setValorVenta(BigDecimal valorVenta) {
		this.valorVenta = valorVenta;
	}

	public Integer getCantidadStop() {
		return cantidadStop;
	}

	public void setCantidadStop(Integer cantidadStop) {
		this.cantidadStop = cantidadStop;
	}

	public Integer getCantidadAlertaStop() {
		return cantidadAlertaStop;
	}

	public void setCantidadAlertaStop(Integer cantidadAlertaStop) {
		this.cantidadAlertaStop = cantidadAlertaStop;
	}

	public String getLinkYoutube() {
		return linkYoutube;
	}

	public void setLinkYoutube(String linkYoutube) {
		this.linkYoutube = linkYoutube;
	}

	public Boolean getAlertaCantidadStop() {
		return alertaCantidadStop;
	}

	public void setAlertaCantidadStop(Boolean alertaCantidadStop) {
		this.alertaCantidadStop = alertaCantidadStop;
	}

	public Integer getCantidadClique() {
		return cantidadClique;
	}

	public void setCantidadClique(Integer cantidadClique) {
		this.cantidadClique = cantidadClique;
	}
	
	public Marca getMarca() {
		return marca;
	}

	public void setMarca(Marca marca) {
		this.marca = marca;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
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
		Producto other = (Producto) obj;
		return Objects.equals(id, other.id);
	}
	
}

























