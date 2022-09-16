--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 9.5.25

-- Started on 2022-09-08 14:59:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 238 (class 1255 OID 34082)
-- Name: validaidpersona(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validaidpersona() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE existe integer;

BEGIN

	existe = (SELECT COUNT(1) FROM persona_fisica WHERE id = NEW.persona_id);
	IF (existe <= 0) THEN
		existe = (select COUNT(1) FROM persona_juridica WHERE id = NEW.persona_id);
		IF (existe <= 0) THEN
			RAISE EXCEPTION 'No fue encontrada el Id de Persona';
		end IF;
	end if;
	
	RETURN new;
end;
$$;


ALTER FUNCTION public.validaidpersona() OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 34083)
-- Name: validaidpersonacuentapagar(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validaidpersonacuentapagar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE existe integer;

BEGIN

	existe = (SELECT COUNT(1) FROM persona_fisica WHERE id = NEW.persona_proveedor_id);
	IF (existe <= 0) THEN
		existe = (select COUNT(1) FROM persona_juridica WHERE id = NEW.persona_proveedor_id);
		IF (existe <= 0) THEN
			RAISE EXCEPTION 'No fue encontrada el Id de Persona';
		end IF;
	end if;
	
	RETURN new;
end;
$$;


ALTER FUNCTION public.validaidpersonacuentapagar() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 34084)
-- Name: acceso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acceso (
    id bigint NOT NULL,
    des_acceso character varying(255) NOT NULL
);


ALTER TABLE public.acceso OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 34087)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id bigint NOT NULL,
    des_categoria character varying(255) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 34090)
-- Name: cuenta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_pagar (
    id bigint NOT NULL,
    des_cuenta_pagar character varying(255) NOT NULL,
    estado_cuenta_pagar character varying(255) NOT NULL,
    fecha_pago date,
    fecha_vencimiento date NOT NULL,
    valor_descuento numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    persona_id bigint NOT NULL,
    persona_proveedor_id bigint NOT NULL
);


ALTER TABLE public.cuenta_pagar OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 34096)
-- Name: cuenta_recibir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_recibir (
    id bigint NOT NULL,
    des_cuenta_recibir character varying(255) NOT NULL,
    estado_cuenta_recibir character varying(255) NOT NULL,
    fecha_pago date,
    fecha_vencimiento date NOT NULL,
    valor_descuento numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    persona_id bigint NOT NULL
);


ALTER TABLE public.cuenta_recibir OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 34102)
-- Name: cupon_descuento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cupon_descuento (
    id bigint NOT NULL,
    codigo_cupon character varying(255) NOT NULL,
    valido_hasta date NOT NULL,
    valor_porcentaje_dto numeric(19,2),
    valor_real_dto numeric(19,2)
);


ALTER TABLE public.cupon_descuento OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 34105)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    des_departamento character varying(255) NOT NULL
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 34111)
-- Name: direccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direccion (
    id bigint NOT NULL,
    barrio character varying(255) NOT NULL,
    ciudad character varying(255) NOT NULL,
    direccion character varying(255) NOT NULL,
    tipo_direccion character varying(255) NOT NULL,
    departamento_id bigint NOT NULL,
    municipio_id bigint NOT NULL,
    persona_id bigint NOT NULL
);


ALTER TABLE public.direccion OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 34117)
-- Name: estado_rastreo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_rastreo (
    id bigint NOT NULL,
    centro_distribucion character varying(255),
    ciudad character varying(255),
    departamento character varying(255),
    municipio character varying(255),
    observacion character varying(255),
    status character varying(255),
    venta_compra_tv_id bigint NOT NULL
);


ALTER TABLE public.estado_rastreo OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 34123)
-- Name: evaluacion_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluacion_producto (
    id bigint NOT NULL,
    des_evaluacion character varying(255) NOT NULL,
    nota integer NOT NULL,
    persona_id bigint NOT NULL,
    producto_id bigint NOT NULL
);


ALTER TABLE public.evaluacion_producto OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 34126)
-- Name: factura_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_compra (
    id bigint NOT NULL,
    descripcion_obs character varying(255) NOT NULL,
    fecha_compra date,
    numero_factura character varying(255) NOT NULL,
    serie_factura character varying(255) NOT NULL,
    valor_descuento numeric(19,2),
    valor_icms numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    cuenta_pagar_id bigint NOT NULL,
    persona_id bigint NOT NULL
);


ALTER TABLE public.factura_compra OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 34132)
-- Name: factura_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_venta (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text,
    serie character varying(255) NOT NULL,
    tipo character varying(255),
    xml text,
    venta_compra_tv_id bigint NOT NULL
);


ALTER TABLE public.factura_venta OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 34138)
-- Name: forma_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pago (
    id bigint NOT NULL,
    des_forma_pago character varying(255) NOT NULL
);


ALTER TABLE public.forma_pago OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 34141)
-- Name: imagen_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagen_producto (
    id bigint NOT NULL,
    imagen_miniatura text NOT NULL,
    imagen_original text NOT NULL,
    producto_id bigint NOT NULL
);


ALTER TABLE public.imagen_producto OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 34147)
-- Name: item_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venta (
    id bigint NOT NULL,
    cantidad double precision NOT NULL,
    producto_id bigint NOT NULL,
    venta_compra_tv_id bigint NOT NULL
);


ALTER TABLE public.item_venta OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 34150)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca (
    id bigint NOT NULL,
    des_marca character varying(255) NOT NULL
);


ALTER TABLE public.marca OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 34153)
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipio (
    id bigint NOT NULL,
    cod_municipio character varying(255) NOT NULL,
    des_municipio character varying(255) NOT NULL
);


ALTER TABLE public.municipio OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 34159)
-- Name: nota_item_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_item_producto (
    id bigint NOT NULL,
    cantidad double precision NOT NULL,
    factura_compra_id bigint NOT NULL,
    producto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_producto OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 34162)
-- Name: persona_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona_fisica (
    id bigint NOT NULL,
    apellidos character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    nombres character varying(255) NOT NULL,
    telefono character varying(255) NOT NULL,
    fecha_nto date NOT NULL,
    nro_dto character varying(255) NOT NULL
);


ALTER TABLE public.persona_fisica OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 34168)
-- Name: persona_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona_juridica (
    id bigint NOT NULL,
    apellidos character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    nombres character varying(255) NOT NULL,
    telefono character varying(255) NOT NULL,
    des_empresa character varying(255) NOT NULL,
    digito_verificacion character varying(255) NOT NULL,
    nit character varying(255) NOT NULL
);


ALTER TABLE public.persona_juridica OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 34174)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    id bigint NOT NULL,
    activo boolean NOT NULL,
    alerta_cantidad_stop boolean,
    altura double precision NOT NULL,
    cantidad_alerta_stop integer,
    cantidad_clique integer,
    cantidad_stop integer NOT NULL,
    des_producto text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nombre_producto character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidad double precision NOT NULL,
    tipo_unidad character varying(255) NOT NULL,
    valor_venta numeric(19,2) NOT NULL,
    categoria_id bigint NOT NULL,
    marca_id bigint NOT NULL
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 34180)
-- Name: seq_acceso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_acceso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acceso OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 34182)
-- Name: seq_categoria; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoria
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 34184)
-- Name: seq_cuenta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cuenta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cuenta_pagar OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 34186)
-- Name: seq_cuenta_recibir; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cuenta_recibir
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cuenta_recibir OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 34188)
-- Name: seq_cupon_descuento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cupon_descuento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cupon_descuento OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 34190)
-- Name: seq_departamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_departamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_departamento OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 34192)
-- Name: seq_direccion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_direccion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_direccion OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 34194)
-- Name: seq_estado_rastreo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_estado_rastreo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_estado_rastreo OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 34196)
-- Name: seq_evaluacion_producto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_evaluacion_producto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_evaluacion_producto OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 34198)
-- Name: seq_factura_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_factura_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_factura_compra OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 34200)
-- Name: seq_factura_venta; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_factura_venta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_factura_venta OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 34202)
-- Name: seq_forma_pago; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_forma_pago
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forma_pago OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 34204)
-- Name: seq_imagen_producto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_imagen_producto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagen_producto OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 34206)
-- Name: seq_item_venta; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_item_venta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venta OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 34208)
-- Name: seq_marca; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_marca
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 34210)
-- Name: seq_municipio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_municipio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_municipio OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 34212)
-- Name: seq_nota_item_producto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_item_producto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_producto OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 34214)
-- Name: seq_persona; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_persona
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_persona OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 34216)
-- Name: seq_producto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_producto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_producto OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 34218)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 34220)
-- Name: seq_venta_compra_tv; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_venta_compra_tv
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_venta_compra_tv OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 34222)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    contrasena character varying(255) NOT NULL,
    fecha_actual_password date NOT NULL,
    login character varying(255) NOT NULL,
    persona_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 34228)
-- Name: usuarios_acceso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_acceso (
    usuario_id bigint NOT NULL,
    acceso_id bigint NOT NULL
);


ALTER TABLE public.usuarios_acceso OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 34231)
-- Name: venta_compra_tv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta_compra_tv (
    id bigint NOT NULL,
    dia_entrega integer,
    fecha_entrega date,
    fecha_venta date,
    valor_descuento numeric(19,2),
    valor_flete numeric(19,2),
    valor_total numeric(19,2),
    cupon_descuento_id bigint,
    direccion_cobro_id bigint NOT NULL,
    direccion_entrega_id bigint NOT NULL,
    factura_venta_id bigint NOT NULL,
    forma_pago_id bigint NOT NULL,
    persona_id bigint NOT NULL
);


ALTER TABLE public.venta_compra_tv OWNER TO postgres;

--
-- TOC entry 2320 (class 0 OID 34084)
-- Dependencies: 181
-- Data for Name: acceso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2321 (class 0 OID 34087)
-- Dependencies: 182
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2322 (class 0 OID 34090)
-- Dependencies: 183
-- Data for Name: cuenta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cuenta_pagar VALUES (1, 'DE ENERO', 'ACTIVA', NULL, '2022-12-31', 0.00, 5000.00, 1, 1);


--
-- TOC entry 2323 (class 0 OID 34096)
-- Dependencies: 184
-- Data for Name: cuenta_recibir; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2324 (class 0 OID 34102)
-- Dependencies: 185
-- Data for Name: cupon_descuento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2325 (class 0 OID 34105)
-- Dependencies: 186
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2326 (class 0 OID 34111)
-- Dependencies: 187
-- Data for Name: direccion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2327 (class 0 OID 34117)
-- Dependencies: 188
-- Data for Name: estado_rastreo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2328 (class 0 OID 34123)
-- Dependencies: 189
-- Data for Name: evaluacion_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2329 (class 0 OID 34126)
-- Dependencies: 190
-- Data for Name: factura_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2330 (class 0 OID 34132)
-- Dependencies: 191
-- Data for Name: factura_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2331 (class 0 OID 34138)
-- Dependencies: 192
-- Data for Name: forma_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2332 (class 0 OID 34141)
-- Dependencies: 193
-- Data for Name: imagen_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2333 (class 0 OID 34147)
-- Dependencies: 194
-- Data for Name: item_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2334 (class 0 OID 34150)
-- Dependencies: 195
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2335 (class 0 OID 34153)
-- Dependencies: 196
-- Data for Name: municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2336 (class 0 OID 34159)
-- Dependencies: 197
-- Data for Name: nota_item_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2337 (class 0 OID 34162)
-- Dependencies: 198
-- Data for Name: persona_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.persona_fisica VALUES (1, 'MARTINEZ TOBAR', 'emermar27@hotmail.com', 'JUAN JOSE', '3117397474', '1973-11-27', '4616818');


--
-- TOC entry 2338 (class 0 OID 34168)
-- Dependencies: 199
-- Data for Name: persona_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.persona_juridica VALUES (1, 'MARTINEZ VIVEROS', 'emermar27@hotmail.com', 'ERMELSON', '3117397474', 'EMPRESA PRUEBA', '7', '4616818');


--
-- TOC entry 2339 (class 0 OID 34174)
-- Dependencies: 200
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 201
-- Name: seq_acceso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_acceso', 1, false);


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 202
-- Name: seq_categoria; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categoria', 1, false);


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 203
-- Name: seq_cuenta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cuenta_pagar', 1, false);


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 204
-- Name: seq_cuenta_recibir; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cuenta_recibir', 1, false);


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 205
-- Name: seq_cupon_descuento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cupon_descuento', 1, false);


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 206
-- Name: seq_departamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_departamento', 1, false);


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 207
-- Name: seq_direccion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_direccion', 1, false);


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 208
-- Name: seq_estado_rastreo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_estado_rastreo', 1, false);


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 209
-- Name: seq_evaluacion_producto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_evaluacion_producto', 1, false);


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_factura_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_factura_compra', 1, false);


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 211
-- Name: seq_factura_venta; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_factura_venta', 1, false);


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 212
-- Name: seq_forma_pago; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_forma_pago', 1, false);


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 213
-- Name: seq_imagen_producto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_imagen_producto', 1, false);


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 214
-- Name: seq_item_venta; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_item_venta', 1, false);


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_marca; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_marca', 1, false);


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 216
-- Name: seq_municipio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_municipio', 1, false);


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 217
-- Name: seq_nota_item_producto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_item_producto', 1, false);


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 218
-- Name: seq_persona; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_persona', 1, false);


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 219
-- Name: seq_producto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_producto', 1, false);


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 220
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 221
-- Name: seq_venta_compra_tv; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_venta_compra_tv', 1, false);


--
-- TOC entry 2361 (class 0 OID 34222)
-- Dependencies: 222
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2362 (class 0 OID 34228)
-- Dependencies: 223
-- Data for Name: usuarios_acceso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2363 (class 0 OID 34231)
-- Dependencies: 224
-- Data for Name: venta_compra_tv; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2125 (class 2606 OID 34235)
-- Name: acceso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acceso
    ADD CONSTRAINT acceso_pkey PRIMARY KEY (id);


--
-- TOC entry 2127 (class 2606 OID 34237)
-- Name: categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 2129 (class 2606 OID 34239)
-- Name: cuenta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_pagar
    ADD CONSTRAINT cuenta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 2131 (class 2606 OID 34241)
-- Name: cuenta_recibir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_recibir
    ADD CONSTRAINT cuenta_recibir_pkey PRIMARY KEY (id);


--
-- TOC entry 2133 (class 2606 OID 34243)
-- Name: cupon_descuento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cupon_descuento
    ADD CONSTRAINT cupon_descuento_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 34245)
-- Name: departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2137 (class 2606 OID 34247)
-- Name: direccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_pkey PRIMARY KEY (id);


--
-- TOC entry 2139 (class 2606 OID 34249)
-- Name: estado_rastreo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_rastreo
    ADD CONSTRAINT estado_rastreo_pkey PRIMARY KEY (id);


--
-- TOC entry 2141 (class 2606 OID 34251)
-- Name: evaluacion_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion_producto
    ADD CONSTRAINT evaluacion_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 34253)
-- Name: factura_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_compra
    ADD CONSTRAINT factura_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2145 (class 2606 OID 34255)
-- Name: factura_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta
    ADD CONSTRAINT factura_venta_pkey PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 34257)
-- Name: forma_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pago
    ADD CONSTRAINT forma_pago_pkey PRIMARY KEY (id);


--
-- TOC entry 2149 (class 2606 OID 34259)
-- Name: imagen_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagen_producto
    ADD CONSTRAINT imagen_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2151 (class 2606 OID 34261)
-- Name: item_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venta
    ADD CONSTRAINT item_venta_pkey PRIMARY KEY (id);


--
-- TOC entry 2153 (class 2606 OID 34263)
-- Name: marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (id);


--
-- TOC entry 2155 (class 2606 OID 34265)
-- Name: municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_pkey PRIMARY KEY (id);


--
-- TOC entry 2157 (class 2606 OID 34267)
-- Name: nota_item_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_producto
    ADD CONSTRAINT nota_item_producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2159 (class 2606 OID 34269)
-- Name: persona_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona_fisica
    ADD CONSTRAINT persona_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 2161 (class 2606 OID 34271)
-- Name: persona_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona_juridica
    ADD CONSTRAINT persona_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 2163 (class 2606 OID 34273)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);


--
-- TOC entry 2167 (class 2606 OID 34277)
-- Name: unique_acceso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acceso
    ADD CONSTRAINT unique_acceso_user UNIQUE (usuario_id, acceso_id);


--
-- TOC entry 2165 (class 2606 OID 34279)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2169 (class 2606 OID 34281)
-- Name: venta_compra_tv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_compra_tv
    ADD CONSTRAINT venta_compra_tv_pkey PRIMARY KEY (id);


--
-- TOC entry 2190 (class 2620 OID 34282)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.cuenta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2194 (class 2620 OID 34283)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.cuenta_recibir FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2196 (class 2620 OID 34284)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.direccion FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2198 (class 2620 OID 34285)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.evaluacion_producto FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2200 (class 2620 OID 34286)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.factura_compra FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2202 (class 2620 OID 34287)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2204 (class 2620 OID 34288)
-- Name: validaidpersonainsertar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertar BEFORE INSERT ON public.venta_compra_tv FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2191 (class 2620 OID 34289)
-- Name: validaidpersonainsertarcuentapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonainsertarcuentapagar BEFORE INSERT ON public.cuenta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validaidpersonacuentapagar();


--
-- TOC entry 2192 (class 2620 OID 34290)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.cuenta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2195 (class 2620 OID 34291)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.cuenta_recibir FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2197 (class 2620 OID 34292)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.direccion FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2199 (class 2620 OID 34293)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.evaluacion_producto FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2201 (class 2620 OID 34294)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.factura_compra FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2203 (class 2620 OID 34295)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2205 (class 2620 OID 34296)
-- Name: validaidpersonaupdate; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdate BEFORE UPDATE ON public.venta_compra_tv FOR EACH ROW EXECUTE PROCEDURE public.validaidpersona();


--
-- TOC entry 2193 (class 2620 OID 34297)
-- Name: validaidpersonaupdatecuentapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validaidpersonaupdatecuentapagar BEFORE UPDATE ON public.cuenta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validaidpersonacuentapagar();


--
-- TOC entry 2183 (class 2606 OID 34298)
-- Name: acceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acceso
    ADD CONSTRAINT acceso_fk FOREIGN KEY (acceso_id) REFERENCES public.acceso(id);


--
-- TOC entry 2181 (class 2606 OID 34303)
-- Name: categoria_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT categoria_fk FOREIGN KEY (categoria_id) REFERENCES public.categoria(id);


--
-- TOC entry 2174 (class 2606 OID 34308)
-- Name: cuenta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_compra
    ADD CONSTRAINT cuenta_pagar_fk FOREIGN KEY (cuenta_pagar_id) REFERENCES public.cuenta_pagar(id);


--
-- TOC entry 2185 (class 2606 OID 34313)
-- Name: cupon_descuento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_compra_tv
    ADD CONSTRAINT cupon_descuento_fk FOREIGN KEY (cupon_descuento_id) REFERENCES public.cupon_descuento(id);


--
-- TOC entry 2170 (class 2606 OID 34318)
-- Name: departamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT departamento_fk FOREIGN KEY (departamento_id) REFERENCES public.departamento(id);


--
-- TOC entry 2186 (class 2606 OID 34323)
-- Name: direccion_cobro_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_compra_tv
    ADD CONSTRAINT direccion_cobro_fk FOREIGN KEY (direccion_cobro_id) REFERENCES public.direccion(id);


--
-- TOC entry 2187 (class 2606 OID 34328)
-- Name: direccion_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_compra_tv
    ADD CONSTRAINT direccion_entrega_fk FOREIGN KEY (direccion_entrega_id) REFERENCES public.direccion(id);


--
-- TOC entry 2179 (class 2606 OID 34333)
-- Name: factura_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_producto
    ADD CONSTRAINT factura_compra_fk FOREIGN KEY (factura_compra_id) REFERENCES public.factura_compra(id);


--
-- TOC entry 2188 (class 2606 OID 34338)
-- Name: factura_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_compra_tv
    ADD CONSTRAINT factura_venta_fk FOREIGN KEY (factura_venta_id) REFERENCES public.factura_venta(id);


--
-- TOC entry 2189 (class 2606 OID 34343)
-- Name: forma_pago_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_compra_tv
    ADD CONSTRAINT forma_pago_fk FOREIGN KEY (forma_pago_id) REFERENCES public.forma_pago(id);


--
-- TOC entry 2182 (class 2606 OID 34348)
-- Name: marca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT marca_fk FOREIGN KEY (marca_id) REFERENCES public.marca(id);


--
-- TOC entry 2171 (class 2606 OID 34353)
-- Name: municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT municipio_fk FOREIGN KEY (municipio_id) REFERENCES public.municipio(id);


--
-- TOC entry 2173 (class 2606 OID 34358)
-- Name: producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion_producto
    ADD CONSTRAINT producto_fk FOREIGN KEY (producto_id) REFERENCES public.producto(id);


--
-- TOC entry 2176 (class 2606 OID 34363)
-- Name: producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagen_producto
    ADD CONSTRAINT producto_fk FOREIGN KEY (producto_id) REFERENCES public.producto(id);


--
-- TOC entry 2177 (class 2606 OID 34368)
-- Name: producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venta
    ADD CONSTRAINT producto_fk FOREIGN KEY (producto_id) REFERENCES public.producto(id);


--
-- TOC entry 2180 (class 2606 OID 34373)
-- Name: producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_producto
    ADD CONSTRAINT producto_fk FOREIGN KEY (producto_id) REFERENCES public.producto(id);


--
-- TOC entry 2184 (class 2606 OID 34378)
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_acceso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 2172 (class 2606 OID 34383)
-- Name: venta_compra_tv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_rastreo
    ADD CONSTRAINT venta_compra_tv_fk FOREIGN KEY (venta_compra_tv_id) REFERENCES public.venta_compra_tv(id);


--
-- TOC entry 2175 (class 2606 OID 34388)
-- Name: venta_compra_tv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_venta
    ADD CONSTRAINT venta_compra_tv_fk FOREIGN KEY (venta_compra_tv_id) REFERENCES public.venta_compra_tv(id);


--
-- TOC entry 2178 (class 2606 OID 34393)
-- Name: venta_compra_tv_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venta
    ADD CONSTRAINT venta_compra_tv_fk FOREIGN KEY (venta_compra_tv_id) REFERENCES public.venta_compra_tv(id);


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2022-09-08 14:59:11

--
-- PostgreSQL database dump complete
--

