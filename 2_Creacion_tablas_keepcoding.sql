--Tablas Principales 
-- Crea la tabla bootcamp
CREATE TABLE bootcamp (
    id_bootcamp SERIAL PRIMARY KEY,
    nombre_bootcamp VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT
);

-- Crea la tabla modulo
CREATE TABLE modulo (
    id_modulo SERIAL PRIMARY KEY,
    nombre_modulo VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT
);

-- Crea la tabla profesor
CREATE TABLE profesor (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    DNI VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    fecha_incorporacion DATE, 
    profesor_activo BOOLEAN DEFAULT TRUE
);

-- Crea la tabla alumno
CREATE TABLE alumno (
    id_alumno SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    DNI VARCHAR(20) UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    pais VARCHAR(100),
    alumno_activo BOOLEAN DEFAULT TRUE
);

-- Crea la tabla empresa_bolsa_talento
CREATE TABLE empresa_bolsa_talento (
    id_empresa SERIAL PRIMARY KEY,
    nombre_empresa VARCHAR(255),
    persona_contacto VARCHAR(255),
    email_contacto VARCHAR(255) NOT NULL UNIQUE
);

--Tablas con dependencias
-- Crea la tabla edicion
CREATE TABLE edicion (
    id_edicion SERIAL PRIMARY KEY,
    id_bootcamp INT NOT NULL,
    numero_edicion INT NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_bootcamp) REFERENCES bootcamp(id_bootcamp),
    UNIQUE (id_bootcamp, numero_edicion),
    CHECK (fecha_inicio < fecha_fin)
);

-- Crea la tabla matricula 
CREATE TABLE matricula (
    id_matricula SERIAL PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_edicion INT NOT NULL,
    fecha_matricula DATE,
    UNIQUE (id_alumno, id_edicion),
    FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno),
    FOREIGN KEY (id_edicion) REFERENCES edicion(id_edicion)
);

-- Crea la tabla facturacion
CREATE TABLE facturacion (
    id_factura SERIAL PRIMARY KEY,
    id_matricula INT NOT NULL,
    numero_factura VARCHAR(50) NOT NULL UNIQUE,
    concepto VARCHAR(255) NOT NULL,
    importe_total DECIMAL(10, 2) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_pago DATE,
    estado_factura VARCHAR(50) CHECK (estado_factura IN ('pendiente', 'pagada', 'vencida', 'cancelada')),
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) 
);

-- Crea la tabla clase
CREATE TABLE clase (
    id_clase SERIAL PRIMARY KEY,
    id_edicion INT NOT NULL,
    id_modulo INT NOT NULL,
    id_profesor INT NOT NULL,
    fecha_clase DATE,
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (id_edicion) REFERENCES edicion(id_edicion),
    FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo),
    FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor),
    CHECK (hora_inicio < hora_fin)
);

-- Crea la tabla practica
CREATE TABLE practica (
    id_practica SERIAL PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_modulo INT NOT NULL,
    numero_intento INT DEFAULT 0 CHECK (numero_intento IN (0, 1, 2)),
    es_apto BOOLEAN, 
    fecha_entrega TIMESTAMP,
    UNIQUE (id_matricula, id_modulo, numero_intento),
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula),
    FOREIGN KEY (id_modulo) REFERENCES modulo(id_modulo)
);

-- Crea la tabla oferta_bolsa_talento
CREATE TABLE oferta_bolsa_talento (
    id_oferta SERIAL PRIMARY KEY,
    id_empresa INT NOT NULL,
    nombre_puesto VARCHAR(100),
    descripcion TEXT,
    fecha_publicacion DATE,
    estado_oferta VARCHAR(50) CHECK (estado_oferta IN ('abierta', 'cerrada','revision')),
    FOREIGN KEY (id_empresa) REFERENCES empresa_bolsa_talento(id_empresa)
);

-- Crea la tabla aplicacion_bolsa_talento
CREATE TABLE aplicacion_bolsa_talento (
    id_aplicacion SERIAL PRIMARY KEY,
    id_oferta INT NOT NULL,
    id_alumno INT NOT NULL,
    fecha_aplicacion DATE,
    estado_aplicacion VARCHAR(50) CHECK (estado_aplicacion IN ('aceptado', 'rechazado','revision')),
    FOREIGN KEY (id_oferta) REFERENCES oferta_bolsa_talento(id_oferta),
    FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno)
);
