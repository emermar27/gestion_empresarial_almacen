package com.ge.almacen.enums;

public enum EstadoCuentaPagar {
	
	//COBRANZA, VENCIDA, ABIERTA esto se guarda en BD
	COBRANZA("Cobranza"),
	VENCIDA("Vencida"),
	ABIERTA("Abierta");
	
	private String descripcion;
	
	private EstadoCuentaPagar(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
	
	@Override
	public String toString() {
		return this.descripcion;
	}

}
