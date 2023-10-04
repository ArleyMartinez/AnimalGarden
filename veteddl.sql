-- F 5 --
DROP TABLE IF EXISTS tab_factura;

-- F 4 --
DROP TABLE IF EXISTS tab_historia_cli;
DROP TABLE IF EXISTS tab_login;
DROP TABLE IF EXISTS tab_mascota;

-- F 3 --
DROP TABLE IF EXISTS tab_cita_disponible;

-- F 2 --
DROP TABLE IF EXISTS tab_asig_cita;
DROP TABLE IF EXISTS tab_empleado;
DROP TABLE IF EXISTS tab_articulo;
DROP TABLE IF EXISTS tab_carnet_vacu;

-- F 1 --
DROP TABLE IF EXISTS tab_cliente;

-- Ent --
DROP TABLE IF EXISTS tab_veterinaria;
DROP TABLE IF EXISTS tab_tratamiento;
DROP TABLE IF EXISTS tab_fech_modif;
DROP TABLE IF EXISTS tab_vacuna;
DROP TABLE IF EXISTS tab_raza;
DROP TABLE IF EXISTS tab_tip_mascota;
DROP TABLE IF EXISTS tab_cat_mascota;
DROP TABLE IF EXISTS tab_cargo;
DROP TABLE IF EXISTS tab_permiso;
DROP TABLE IF EXISTS tab_menu;
DROP TABLE IF EXISTS tab_vista;
DROP TABLE IF EXISTS tab_categoria;
DROP TABLE IF EXISTS tab_proveedor;
DROP TABLE IF EXISTS tab_servicio;


CREATE TABLE tab_veterinaria
(
    nit         INTEGER NOT NULL,
    nombre      VARCHAR NOT NULL,
    direccion   VARCHAR NOT NULL,
    telefono    VARCHAR NOT NULL,
    correo      VARCHAR NOT NULL,
    PRIMARY KEY (nit)
);


CREATE TABLE tab_tratamiento
(
    id_tratamiento  VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    PRIMARY KEY (id_tratamiento)
);


CREATE TABLE tab_fech_modif
(
    fecha_mod       DATE NOT NULL,
    observaciones   VARCHAR NOT NULL,
    PRIMARY KEY (fecha_mod)
);


CREATE TABLE tab_vacuna
(
    id_vacuna   VARCHAR NOT NULL,
    nombre      VARCHAR NOT NULL,
    PRIMARY KEY (id_vacuna)
);


CREATE TABLE tab_raza
(
    id_raza     VARCHAR NOT NULL,
    nombre      VARCHAR NOT NULL,
    PRIMARY KEY (id_raza)
);


CREATE TABLE tab_tip_mascota
(
    id_tp_mascota   VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    PRIMARY KEY (id_tp_mascota)
);


CREATE TABLE tab_cat_mascota
(
    id_cat_animal   VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    PRIMARY KEY (id_cat_animal)
);


CREATE TABLE tab_cargo
(
    id_cargo    VARCHAR NOT NULL,
    nombre      VARCHAR NOT NULL,
    PRIMARY KEY (id_cargo)
);


CREATE TABLE tab_permiso
(
    id_permiso  VARCHAR NOT NULL,
    nombre      VARCHAR NOT NULL,
    PRIMARY KEY (id_permiso)
);


CREATE TABLE tab_menu
(
    id_menu  VARCHAR NOT NULL,
    nombre   VARCHAR NOT NULL,
    PRIMARY KEY (id_menu)
);


CREATE TABLE tab_vista
(
    id_vista    VARCHAR NOT NULL,
    nombre      VARCHAR NOT NULL,
    PRIMARY KEY (id_vista)
);


CREATE TABLE tab_categoria
(
    id_categoria    VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    PRIMARY KEY (id_categoria)
);


CREATE TABLE tab_proveedor
(
    id_proveedor    VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    telefono        VARCHAR NOT NULL,
    direccion       VARCHAR NOT NULL,
    correo          VARCHAR NOT NULL,
    PRIMARY KEY (id_proveedor)
);


CREATE TABLE tab_servicio
(
    id_servicio     VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    precio          INTEGER NOT NULL,
	PRIMARY KEY (id_servicio)
);



CREATE TABLE tab_articulo
(
    id_articulo     VARCHAR NOT NULL,
    id_proveedor    VARCHAR NOT NULL,
    id_categoria    VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    precio          FLOAT NOT NULL,
    PRIMARY KEY (id_articulo),
    FOREIGN KEY (id_proveedor) REFERENCES tab_proveedor,
    FOREIGN KEY (id_categoria) REFERENCES tab_categoria
);





-- F4 --

CREATE TABLE tab_login
(
    id_usuario VARCHAR NOT NULL,
    nit        INTEGER NOT NULL,
    id_permiso VARCHAR NOT NULL,
    id_menu    VARCHAR NOT NULL,
    id_vista   VARCHAR NOT NULL,
    usuario    VARCHAR NOT NULL,
    contrasena VARCHAR NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (nit) REFERENCES tab_veterinaria,
    FOREIGN KEY (id_permiso) REFERENCES tab_permiso,
    FOREIGN KEY (id_menu) REFERENCES tab_menu,
    FOREIGN KEY (id_vista) REFERENCES tab_vista
);

--F1  esta debe estar por debajo del LOGIN, en conclusion: PRIMERO SE CREA EL LOGIN Y LUEGO SE REFERENCIA EL USUARIO--

CREATE TABLE tab_cliente
(
    dni_cte         INTEGER NOT NULL,
    id_usuario      VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    telefono        VARCHAR NOT NULL,
    direccion       VARCHAR NOT NULL,
    correo          VARCHAR NOT NULL,
    PRIMARY KEY (dni_cte),
    FOREIGN KEY (id_usuario) REFERENCES tab_login
);


CREATE TABLE tab_empleado
(
    dni_emp         INTEGER NOT NULL,
    id_usuario      VARCHAR NOT NULL,
    id_cargo        VARCHAR NOT NULL,
    nombre          VARCHAR NOT NULL,
    telefono        VARCHAR NOT NULL,
    direccion       VARCHAR NOT NULL,
    PRIMARY KEY (dni_emp),
    FOREIGN KEY (id_usuario) REFERENCES tab_login,
    FOREIGN KEY (id_cargo) REFERENCES tab_cargo
);


-- F3  ESTA MONDA TIENE SEDE Y NO ESTA REFERENCIADA A NINGUN LADO MK--

CREATE TABLE tab_cita_disponible
(
    id_cita_disp    VARCHAR NOT NULL,
    id_servicio     VARCHAR NOT NULL,
    dni_emp         INTEGER NOT NULL,
    --id_sede         VARCHAR NOT NULL,
    estado          BOOLEAN NOT NULL,
    fecha           DATE NOT NULL,
    hora            TIME NOT NULL,
    PRIMARY KEY (id_cita_disp),
    FOREIGN KEY (id_servicio) REFERENCES tab_servicio,
    FOREIGN KEY (dni_emp) REFERENCES tab_empleado
);

-- F2 LO MISMO QUE LA F1 DEBE ESTAR POR DEBAJO DE CITA DISPO PARA PODER HACER LA REFERENCIA DE LLAVES--

CREATE TABLE tab_asig_cita
(
    id_cita         VARCHAR NOT NULL,
    id_cita_disp    VARCHAR NOT NULL,
    dni_cte         INTEGER NOT NULL,
    PRIMARY KEY (id_cita),
    FOREIGN KEY (id_cita_disp) REFERENCES tab_cita_disponible,
    FOREIGN KEY (dni_cte) REFERENCES tab_cliente
);

CREATE TABLE tab_mascota
(
    id_mascota     VARCHAR NOT NULL,
    dni_cte        INTEGER NOT NULL,
    id_tp_mascota  VARCHAR NOT NULL,
    id_raza        VARCHAR NOT NULL,
    id_cat_animal  VARCHAR NOT NULL,
    nombre         VARCHAR NOT NULL,
    peso           INTEGER NOT NULL,
    PRIMARY KEY (id_mascota),
    FOREIGN KEY (dni_cte) REFERENCES tab_cliente,
    FOREIGN KEY (id_tp_mascota) REFERENCES tab_tip_mascota,
    FOREIGN KEY (id_raza) REFERENCES tab_raza,
    FOREIGN KEY (id_cat_animal) REFERENCES tab_cat_mascota
);


CREATE TABLE tab_historia_cli
(
    id_historia    VARCHAR NOT NULL,
    id_mascota     VARCHAR NOT NULL,
    dni_emp        INTEGER NOT NULL,
    id_tratamiento VARCHAR NOT NULL,
    fecha_mod      DATE NOT NULL,
    PRIMARY KEY (id_historia),
    FOREIGN KEY (id_mascota) REFERENCES tab_mascota,
    FOREIGN KEY (dni_emp) REFERENCES tab_empleado
	,
    FOREIGN KEY (id_tratamiento) REFERENCES tab_tratamiento,
    FOREIGN KEY (fecha_mod) REFERENCES tab_fech_modif
);


CREATE TABLE tab_carnet_vacu
(
    reg_invima VARCHAR NOT NULL,
    id_mascota VARCHAR NOT NULL,
    id_vacuna  VARCHAR NOT NULL,
    fecha      DATE NOT NULL,
    precio     FLOAT NOT NULL,
    PRIMARY KEY (reg_invima),
    FOREIGN KEY (id_mascota) REFERENCES tab_mascota,
    FOREIGN KEY (id_vacuna) REFERENCES tab_vacuna
);
-- F5 --

CREATE TABLE tab_factura
(
    id_factura  VARCHAR NOT NULL,
    nit         INTEGER NOT NULL,
    dni_cte     INTEGER NOT NULL,
    id_mascota  VARCHAR NOT NULL,
    id_servicio VARCHAR NOT NULL,
    id_articulo VARCHAR NOT NULL,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (nit) REFERENCES tab_veterinaria,
    FOREIGN KEY (dni_cte) REFERENCES tab_cliente,
    FOREIGN KEY (id_mascota) REFERENCES tab_mascota,
    FOREIGN KEY (id_servicio) REFERENCES tab_servicio,
    FOREIGN KEY (id_articulo) REFERENCES tab_articulo
);


-- Tabla de Auditoría para tab_login

CREATE TABLE tab_borrados
(
    id_consec                   INTEGER         NOT NULL, -- Codígo de la tabla Borrados (Llave Primaria)
    nombre_tabla                VARCHAR         NOT NULL, --
    usuario_insert              VARCHAR         NOT NULL    DEFAULT CURRENT_USER,
    fecha_insert                TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_consec)
);




-- Función de auditoría adaptada
CREATE OR REPLACE FUNCTION fun_act_tabla() RETURNS "trigger" AS
$$
   
    DECLARE id_consec tab_borrados.id_consec%TYPE;
    BEGIN
        IF TG_OP = 'INSERT' THEN
           NEW.Usuario_Inserta = CURRENT_USER;
           NEW.Fecha_Inserta = CURRENT_TIMESTAMP;
           RETURN NEW;
        END IF;
        IF TG_OP = 'UPDATE' THEN
           NEW.Usuario_Update = CURRENT_USER;
           NEW.Fecha_Update = CURRENT_TIMESTAMP;
           RETURN NEW;
        END IF;
        IF TG_OP = 'DELETE' THEN
            SELECT MAX(a.id_consec) INTO id_consec FROM tab_borrados a;
            IF id_consec IS NULL THEN
                id_consec = 1;
            ELSE
                id_consec = id_consec + 1;
            END IF;
            INSERT INTO tab_borrados VALUES(id_consec,TG_RELNAME,CURRENT_USER,CURRENT_TIMESTAMP);
            RETURN OLD;  
        END IF;
    END;
$$
LANGUAGE PLPGSQL;


-- Desencadenadores para tablas específicas

-- Ejemplo para la tabla tab_ciudades
CREATE OR REPLACE TRIGGER tri_del_tabla_login AFTER DELETE ON tab_login
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_login BEFORE INSERT OR UPDATE ON tab_login
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_vehi AFTER DELETE ON tab_vehi
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_vehi BEFORE INSERT OR UPDATE ON tab_vehi
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_precioxhora AFTER DELETE ON tab_precioxhora
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_precioxhora BEFORE INSERT OR UPDATE ON tab_precioxhora
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_mensualida AFTER DELETE ON tab_mensualidad
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_mensualida BEFORE INSERT OR UPDATE ON tab_mensualidad
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_clien AFTER DELETE ON tab_clien
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_clien BEFORE INSERT OR UPDATE ON tab_clien
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_gerente AFTER DELETE ON tab_gerente
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_gerente BEFORE INSERT OR UPDATE ON tab_gerente
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_parq AFTER DELETE ON tab_parq
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_parq BEFORE INSERT OR UPDATE ON tab_parq
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_reserva AFTER DELETE ON tab_reserva
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_reserva BEFORE INSERT OR UPDATE ON tab_reserva
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_timereal AFTER DELETE ON tab_puestos
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_timereal BEFORE INSERT OR UPDATE ON tab_puestos
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_del_tabla_coment AFTER DELETE ON tab_coment
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

CREATE OR REPLACE TRIGGER tri_act_tabla_coment BEFORE INSERT OR UPDATE ON tab_coment
FOR EACH ROW EXECUTE PROCEDURE fun_act_tabla();

-- Repite el proceso para otras tablas según sea necesario