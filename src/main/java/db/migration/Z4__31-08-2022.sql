INSERT INTO public.persona_juridica(
            id, apellidos, email, nombres, telefono, des_empresa, digito_verificacion, 
            nit)
    VALUES (1, 'MARTINEZ VIVEROS', 'emermar27@hotmail.com', 'ERMELSON', '3117397474', 'EMPRESA PRUEBA', '7', 
            '4616818');


INSERT INTO public.cuenta_pagar(
            id, des_cuenta_pagar, estado_cuenta_pagar, fecha_pago, fecha_vencimiento, 
            valor_descuento, valor_total, persona_id, persona_proveedor_id)
    VALUES (1, 'DE ENERO', 'ACTIVA', NULL, '2022-12-31', 0, 5000, 1, 1);

CREAR LLAVE FORANEA

alter table venta_compra_tv  add constraint empresa_fk foreign key (empresa_id)
  references persona_juridica (id)

CREAR CAMPO UNICO

alter table usuario add constraint login_unique unique (login)

alter table acceso add constraint acceso_unique unique (des_acceso)

