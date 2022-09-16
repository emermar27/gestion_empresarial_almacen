package com.ge.almacen.enums;

public enum TipoDireccion {
	
	COBRANZA("Cobranza"),
	ENTREGA("Entrega"),
	RECIDENCIA("Recidencia");
	
	private String descripcion;
	
	private TipoDireccion(String descripcion) {
		this.descripcion= descripcion;
	}
	
	public String getDescripcion() {
		return descripcion;
	}
	
	@Override
	public String toString() {
		return this.descripcion;
	}

}
















