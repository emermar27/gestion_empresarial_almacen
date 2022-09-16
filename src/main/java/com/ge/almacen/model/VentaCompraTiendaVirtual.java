package com.ge.almacen.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Objects;

import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "venta_compra_tv")
@SequenceGenerator(name = "seq_venta_compra_tv", sequenceName = "seq_venta_compra_tv", allocationSize = 1, initialValue = 1)
public class VentaCompraTiendaVirtual implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_venta_compra_tv")
	private Long id;
	
	@ManyToOne(targetEntity = Persona.class)
	@JoinColumn(name = "persona_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "persona_fk"))
	private Persona persona;
	
	@ManyToOne
	@JoinColumn(name = "direccion_entrega_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "direccion_entrega_fk"))
	private Direccion direccionEntrega;
	
	@ManyToOne
	@JoinColumn(name = "direccion_cobro_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "direccion_cobro_fk"))
	private Direccion direccionCobro;
	
	private BigDecimal valorTotal;
	
	private BigDecimal valorDescuento;
	
	@ManyToOne
	@JoinColumn(name = "forma_pago_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "forma_pago_fk"))
	private FormaPago formaPago;
	
	@OneToOne
	@JoinColumn(name = "factura_venta_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "factura_venta_fk"))
	private FacturaVenta facturaVenta;
	
	@ManyToOne
	@JoinColumn(name = "cupon_descuento_id", foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "cupon_descuento_fk"))
	private CuponDescuento cuponDescuento;
	
	private BigDecimal valorFlete;
	
	private Integer diaEntrega;
	
	@Temporal(TemporalType.DATE)
	private Date fechaEntrega;
	
	@Temporal(TemporalType.DATE)
	private Date fechaVenta;
	
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

	public Persona getPersona() {
		return persona;
	}

	public void setPersona(Persona persona) {
		this.persona = persona;
	}

	public Direccion getDireccionEntrega() {
		return direccionEntrega;
	}

	public void setDireccionEntrega(Direccion direccionEntrega) {
		this.direccionEntrega = direccionEntrega;
	}

	public Direccion getDireccionCobro() {
		return direccionCobro;
	}

	public void setDireccionCobro(Direccion direccionCobro) {
		this.direccionCobro = direccionCobro;
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

	public FormaPago getFormaPago() {
		return formaPago;
	}

	public void setFormaPago(FormaPago formaPago) {
		this.formaPago = formaPago;
	}

	public FacturaVenta getFacturaVenta() {
		return facturaVenta;
	}

	public void setFacturaVenta(FacturaVenta facturaVenta) {
		this.facturaVenta = facturaVenta;
	}

	public CuponDescuento getCuponDescuento() {
		return cuponDescuento;
	}

	public void setCuponDescuento(CuponDescuento cuponDescuento) {
		this.cuponDescuento = cuponDescuento;
	}

	public BigDecimal getValorFlete() {
		return valorFlete;
	}

	public void setValorFlete(BigDecimal valorFlete) {
		this.valorFlete = valorFlete;
	}

	public Integer getDiaEntrega() {
		return diaEntrega;
	}

	public void setDiaEntrega(Integer diaEntrega) {
		this.diaEntrega = diaEntrega;
	}

	public Date getFechaEntrega() {
		return fechaEntrega;
	}

	public void setFechaEntrega(Date fechaEntrega) {
		this.fechaEntrega = fechaEntrega;
	}

	public Date getFechaVenta() {
		return fechaVenta;
	}

	public void setFechaVenta(Date fechaVenta) {
		this.fechaVenta = fechaVenta;
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
		VentaCompraTiendaVirtual other = (VentaCompraTiendaVirtual) obj;
		return Objects.equals(id, other.id);
	}

	
	
}






























