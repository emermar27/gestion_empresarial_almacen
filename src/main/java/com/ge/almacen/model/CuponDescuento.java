package com.ge.almacen.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "cupon_descuento")
@SequenceGenerator(name = "seq_cupon_descuento", sequenceName = "seq_cupon_descuento",  allocationSize = 1, initialValue = 1)
public class CuponDescuento implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cupon_descuento")
	private Long id;
	
	@Column(name = "codigo_cupon", nullable = false)
	private String codigoCupon;
	
	@Column(name = "valido_hasta", nullable = false)
	@Temporal(TemporalType.DATE)
	private Date validoHasta;
	
	@Column(name = "valor_porcentaje_dto")
	private BigDecimal valorPorcentajeDto;
	
	@Column(name = "valor_real_dto")
	private BigDecimal valorRealDto;
	
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

	public String getCodigoCupon() {
		return codigoCupon;
	}

	public void setCodigoCupon(String codigoCupon) {
		this.codigoCupon = codigoCupon;
	}

	public Date getValidoHasta() {
		return validoHasta;
	}

	public void setValidoHasta(Date validoHasta) {
		this.validoHasta = validoHasta;
	}

	public BigDecimal getValorPorcentajeDto() {
		return valorPorcentajeDto;
	}

	public void setValorPorcentajeDto(BigDecimal valorPorcentajeDto) {
		this.valorPorcentajeDto = valorPorcentajeDto;
	}

	public BigDecimal getValorRealDto() {
		return valorRealDto;
	}

	public void setValorRealDto(BigDecimal valorRealDto) {
		this.valorRealDto = valorRealDto;
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
		CuponDescuento other = (CuponDescuento) obj;
		return Objects.equals(id, other.id);
	}
	
	

}
