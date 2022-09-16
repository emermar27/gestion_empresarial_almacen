package com.ge.almacen.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
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

import com.ge.almacen.enums.EstadoCuentaPagar;

@Entity
@Table(name = "cuenta_pagar")
@SequenceGenerator(name = "seq_cuenta_pagar", sequenceName = "seq_cuenta_pagar", allocationSize = 1, initialValue = 1)
public class CuentaPagar implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cuenta_pagar")
	private Long id;
	
	@Column(name = "des_cuenta_pagar", nullable = false)
	private String desCuentaRecibir;
	
	@Column(name = "valor_total", nullable = false)
	private BigDecimal valorTotal;
	
	@Column(name = "valor_descuento")
	private BigDecimal valorDescuento;
	
	@Enumerated(EnumType.STRING)
	@Column(name = "estado_cuenta_pagar", nullable = false)
	private EstadoCuentaPagar estadoCuentaPagar;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_vencimiento", nullable = false)
	private Date fechaVencimiento;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_pago")
	private Date fechaPago;
	
	@ManyToOne(targetEntity = Persona.class)
	@JoinColumn(name = "persona_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "persona_fk"))
	private Persona persona;
	
	@ManyToOne(targetEntity = Persona.class)
	@JoinColumn(name = "persona_proveedor_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "persona_proveedor_fk"))
	private Persona personaProveedor;
	
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

	public String getDesCuentaRecibir() {
		return desCuentaRecibir;
	}

	public void setDesCuentaRecibir(String desCuentaRecibir) {
		this.desCuentaRecibir = desCuentaRecibir;
	}

	public BigDecimal getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}

	public BigDecimal getValorDescuento() {
		return valorDescuento;
	}

	public void setValorDescuento(BigDecimal valorDescuento) {
		this.valorDescuento = valorDescuento;
	}

	public EstadoCuentaPagar getEstadoCuentaPagar() {
		return estadoCuentaPagar;
	}

	public void setEstadoCuentaPagar(EstadoCuentaPagar estadoCuentaPagar) {
		this.estadoCuentaPagar = estadoCuentaPagar;
	}

	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}

	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}

	public Date getFechaPago() {
		return fechaPago;
	}

	public void setFechaPago(Date fechaPago) {
		this.fechaPago = fechaPago;
	}

	public Persona getPersona() {
		return persona;
	}

	public void setPersona(Persona persona) {
		this.persona = persona;
	}

	public Persona getPersonaProveedor() {
		return personaProveedor;
	}

	public void setPersonaProveedor(Persona personaProveedor) {
		this.personaProveedor = personaProveedor;
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
		CuentaPagar other = (CuentaPagar) obj;
		return Objects.equals(id, other.id);
	}
	
	

}












