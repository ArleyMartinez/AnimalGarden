------------------------------------
--  Script DDL para Animal Garden --
--  Autores:                      --
--  Cristian Camilo Rodriguez     --
--  Arley Santiago Martinez       --
--  Alejandro Garay               --
------------------------------------


DROP TABLE IF EXISTS tab_Factura;
DROP TABLE IF EXISTS tab_CarnetVacunacion;
DROP TABLE IF EXISTS tab_HistoriaClinica;
DROP TABLE IF EXISTS tab_Mascota;
DROP TABLE IF EXISTS tab_AsignacionCita;
DROP TABLE IF EXISTS tab_CitaDisponible;
DROP TABLE IF EXISTS tab_ObservacionxTratamiento;
DROP TABLE IF EXISTS tab_Persona;
DROP TABLE IF EXISTS tab_VistaxCargo;
DROP TABLE IF EXISTS tab_MenuxCargo;
DROP TABLE IF EXISTS tab_PermisoxCargo;
DROP TABLE IF EXISTS tab_Articulo;
DROP TABLE IF EXISTS tab_Login;
DROP TABLE IF EXISTS tab_Observacion;
DROP TABLE IF EXISTS tab_Tratamiento;
DROP TABLE IF EXISTS tab_Vacuna;
DROP TABLE IF EXISTS tab_Raza;
DROP TABLE IF EXISTS tab_TipoMascota;
DROP TABLE IF EXISTS tab_Vista;
DROP TABLE IF EXISTS tab_Menu;
DROP TABLE IF EXISTS tab_Permiso;
DROP TABLE IF EXISTS tab_Cargo;
DROP TABLE IF EXISTS tab_Categoria;
DROP TABLE IF EXISTS tab_Proveedor;
DROP TABLE IF EXISTS tab_Servicio;
DROP TABLE IF EXISTS tab_Veterinaria;


CREATE TABLE tab_Veterinaria(
    nit               VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    direccion         VARCHAR,
    telefono          VARCHAR,
    correo            VARCHAR,
    PRIMARY KEY(nit)
);

CREATE TABLE tab_Servicio(
    id_servicio       VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    precio            FLOAT,
    PRIMARY KEY(id_servicio)
);

CREATE TABLE tab_Proveedor(
    id_proveedor      VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    telefono          VARCHAR,
    direccion         VARCHAR,
    correo            VARCHAR,
    PRIMARY KEY(id_proveedor)
);

CREATE TABLE tab_Categoria(
    id_categoria      VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_categoria)
);

CREATE TABLE tab_Cargo(
    id_cargo          VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_cargo)
);

CREATE TABLE tab_Permiso(
    id_permiso        VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_permiso)
);

CREATE TABLE tab_Menu(
    id_menu           VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_menu)
);

CREATE TABLE tab_Vista(
    id_vista          VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_vista)
);

CREATE TABLE tab_TipoMascota(
    id_tipomascota    VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_tipomascota)
);

CREATE TABLE tab_Raza(
    id_raza           VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_raza)
);

CREATE TABLE tab_Vacuna(
    registro_invima   VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    precio            INTEGER,
    PRIMARY KEY(registro_invima)
);

CREATE TABLE tab_Tratamiento(
    id_tratamiento    VARCHAR     NOT NULL,
    nombre            VARCHAR     NOT NULL,
    PRIMARY KEY(id_tratamiento)
);

CREATE TABLE tab_Observacion(
    id_observacion      VARCHAR     NOT NULL,
    veterinario         VARCHAR     NOT NULL,
    fecha               DATE        NOT NULL,
    observacion         TEXT,
    PRIMARY KEY(id_observacion)
);

CREATE TABLE tab_Login(
    id_usuario        VARCHAR     NOT NULL,
    nit               VARCHAR     NOT NULL,
    contrasena        VARCHAR     NOT NULL,
    PRIMARY KEY(id_usuario),
    FOREIGN KEY(nit) REFERENCES tab_Veterinaria(nit)
);

CREATE TABLE tab_Articulo(
    id_articulo                 VARCHAR     NOT NULL,    
    id_proveedor                VARCHAR     NOT NULL,
    id_categoria                VARCHAR     NOT NULL,
    nombre                      VARCHAR     NOT NULL,
    precio                      FLOAT,
    PRIMARY KEY(id_articulo),
    FOREIGN KEY(id_proveedor)   REFERENCES tab_Proveedor(id_proveedor),
    FOREIGN KEY(id_categoria)   REFERENCES tab_Categoria(id_categoria)
);

CREATE TABLE tab_PermisoxCargo(
    id_permisoxcargo             VARCHAR     NOT NULL,
    id_cargo                     VARCHAR     NOT NULL,
    id_permiso                   VARCHAR     NOT NULL,
    PRIMARY KEY(id_permisoxcargo),
    FOREIGN KEY(id_cargo)        REFERENCES tab_Cargo(id_cargo),
    FOREIGN KEY(id_permiso)      REFERENCES tab_Permiso(id_permiso)
);

CREATE TABLE tab_MenuxCargo(
    id_menuxcargo                VARCHAR     NOT NULL,
    id_cargo                     VARCHAR     NOT NULL,
    id_menu                      VARCHAR     NOT NULL,
    PRIMARY KEY(id_menuxcargo),
    FOREIGN KEY(id_cargo)        REFERENCES tab_Cargo(id_cargo),
    FOREIGN KEY(id_menu)         REFERENCES tab_Menu(id_menu)
);

CREATE TABLE tab_VistaxCargo(
    id_vistaxcargo          VARCHAR     NOT NULL,
    id_vista                VARCHAR     NOT NULL,
    id_cargo                VARCHAR     NOT NULL,
    PRIMARY KEY(id_vistaxcargo),
    FOREIGN KEY(id_vista)   REFERENCES tab_Vista(id_vista),
    FOREIGN KEY(id_cargo)   REFERENCES tab_Cargo(id_cargo)
);

CREATE TABLE tab_Persona(
    dni                             VARCHAR     NOT NULL,
    id_permisoxcargo                VARCHAR     NOT NULL,
    id_menuxcargo                   VARCHAR     NOT NULL,
    id_vistaxcargo                  VARCHAR     NOT NULL,
    id_usuario                      VARCHAR     NOT NULL,
    nombre                          VARCHAR,
    telefono                        VARCHAR,
    direccion                       VARCHAR,
    correo                          VARCHAR,
    PRIMARY KEY(dni),
    FOREIGN KEY(id_permisoxcargo)   REFERENCES tab_PermisoxCargo(id_permisoxcargo),
    FOREIGN KEY(id_menuxcargo)      REFERENCES tab_MenuxCargo(id_menuxcargo),
    FOREIGN KEY(id_vistaxcargo)     REFERENCES tab_VistaxCargo(id_vistaxcargo),
    FOREIGN KEY(id_usuario)         REFERENCES tab_Login(id_usuario)
);

CREATE TABLE tab_ObservacionxTratamiento(
    id_observacionxtratamiento       VARCHAR     NOT NULL,
    dni                              VARCHAR     NOT NULL,
    id_tratamiento                   VARCHAR     NOT NULL,
    id_observacion                   VARCHAR     NOT NULL,
    PRIMARY KEY(id_observacionxtratamiento),
    FOREIGN KEY(dni) REFERENCES tab_Persona(dni),
    FOREIGN KEY(id_tratamiento)      REFERENCES tab_Tratamiento(id_tratamiento),
    FOREIGN KEY(id_observacion)      REFERENCES tab_Observacion(id_observacion)
);

CREATE TABLE tab_CitaDisponible(
    id_citadisponible               VARCHAR     NOT NULL,
    id_servicio                     VARCHAR     NOT NULL,
    dni                             VARCHAR     NOT NULL,
    estado                          BOOLEAN,
    fecha                           DATE,
    hora                            TIME,
    PRIMARY KEY(id_citadisponible),
    FOREIGN KEY(id_servicio)        REFERENCES tab_Servicio(id_servicio),
    FOREIGN KEY(dni)                REFERENCES tab_Persona(dni)
);

CREATE TABLE tab_AsignacionCita(
    id_cita                         VARCHAR     NOT NULL,
    id_citadisponible               VARCHAR     NOT NULL,
    dni                             VARCHAR     NOT NULL,
    PRIMARY KEY(id_cita),
    FOREIGN KEY(id_citadisponible) REFERENCES tab_CitaDisponible(id_citadisponible),
    FOREIGN KEY(dni) REFERENCES tab_Persona(dni)
);

CREATE TABLE tab_Mascota(
    id_mascota                      VARCHAR     NOT NULL,
    dni                             VARCHAR     NOT NULL,
    id_tipomascota                  VARCHAR     NOT NULL,
    id_raza                         VARCHAR     NOT NULL,
    nombre                          VARCHAR,
    sexo                            VARCHAR,
    edad                            INT,
    PRIMARY KEY(id_mascota),
    FOREIGN KEY(dni)                REFERENCES tab_Persona(dni),
    FOREIGN KEY(id_tipomascota)     REFERENCES tab_TipoMascota(id_tipomascota),
    FOREIGN KEY(id_raza)            REFERENCES tab_Raza(id_raza)
);

CREATE TABLE tab_HistoriaClinica(
    id_historiaclinica              VARCHAR     NOT NULL,
    id_mascota                      VARCHAR     NOT NULL,
    id_observacion                  VARCHAR     NOT NULL,
    PRIMARY KEY(id_historiaclinica),
    FOREIGN KEY(id_mascota)         REFERENCES tab_Mascota(id_mascota),
    FOREIGN KEY(id_observacion)     REFERENCES tab_Observacion(id_observacion)
);

CREATE TABLE tab_CarnetVacunacion(
    id_carnet                       VARCHAR     NOT NULL,
    id_mascota                      VARCHAR     NOT NULL,
    registro_invima                 VARCHAR     NOT NULL,
    fecha                           DATE,
    PRIMARY KEY(id_carnet),
    FOREIGN KEY(id_mascota)         REFERENCES tab_Mascota(id_mascota),
    FOREIGN KEY(registro_invima)    REFERENCES tab_Vacuna(registro_invima)
);

CREATE TABLE tab_Factura(
    id_factura                    VARCHAR     NOT NULL,
    nit                           VARCHAR     NOT NULL,
    dni                           VARCHAR     NOT NULL,
    id_mascota                    VARCHAR     NOT NULL,
    id_servicio                   VARCHAR     NOT NULL,
    id_articulo                   VARCHAR     NOT NULL,
    fecha                         DATE,
    importe_total                 FLOAT,
    PRIMARY KEY(id_factura),
    FOREIGN KEY(nit)              REFERENCES tab_Veterinaria(nit),
    FOREIGN KEY(dni)              REFERENCES tab_Persona(dni),
    FOREIGN KEY(id_mascota)       REFERENCES tab_Mascota(id_mascota),
    FOREIGN KEY(id_servicio)      REFERENCES tab_Servicio(id_servicio),
    FOREIGN KEY(id_articulo)      REFERENCES tab_Articulo(id_articulo)
);




