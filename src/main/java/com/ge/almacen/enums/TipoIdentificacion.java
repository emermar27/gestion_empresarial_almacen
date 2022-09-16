package com.ge.almacen.enums;

public enum TipoIdentificacion {
	
	TI("Tarjeta de Indentidad"),
	CC("Cedula");
	
	private String descripcion;
	
	private TipoIdentificacion(String descripcion) {
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
