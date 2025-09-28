--Tablas Principales
-- Inserta datos en la tabla bootcamp
INSERT INTO bootcamp (nombre_bootcamp, descripcion) VALUES
('Desarrollo Web Full Stack', 'Bootcamp completo para aprender a desarrollar aplicaciones web de principio a fin.'),
('Ciencia de Datos', 'Aprende a analizar datos, crear modelos de Machine Learning y visualizar información.'),
('Ciberseguridad', 'Conviértete en un experto en seguridad informática, hacking ético y protección de sistemas.');

-- Inserta datos en la tabla modulo
INSERT INTO modulo (nombre_modulo, descripcion) VALUES
('Introducción a la Programación', 'Fundamentos de la lógica de programación y JavaScript.'),
('Bases de Datos SQL', 'Diseño y consulta de bases de datos relacionales con SQL.'),
('Python para Data Science', 'Uso de Python con librerías como Pandas, NumPy y Matplotlib.'),
('Seguridad en Redes', 'Principios de seguridad en redes, protocolos y firewalls.');

-- Inserta datos en la tabla profesor
INSERT INTO profesor (nombre, apellido, tipo_doc, numero_doc, email, telefono, fecha_incorporacion) VALUES
('Carlos', 'Sánchez', 'DNI', '12345678A', 'carlos.sanchez@profesores.com', '611223344', '2022-01-10'),
('Laura', 'Gómez', 'DNI', '87654321B', 'laura.gomez@profesores.com', '622334455', '2022-03-15'),
('Javier', 'Martínez', 'NIE', 'X1234567C', 'javier.martinez@profesores.com', '633445566', '2021-09-01');

-- Inserta datos en la tabla alumno
INSERT INTO alumno (nombre, apellido, tipo_doc, numero_doc, email, pais) VALUES
('Ana', 'Pérez', 'DNI', '11111111X', 'ana.perez@alumnos.com', 'España'),
('Luis', 'García', 'Pasaporte', 'A1234567', 'luis.garcia@alumnos.com', 'México'),
('Sofía', 'Rodríguez', 'DNI', '22222222Y', 'sofia.rodriguez@alumnos.com', 'Argentina'),
('David', 'Fernández', 'DNI', '33333333Z', 'david.fernandez@alumnos.com', 'España'),
('Elena', 'Moreno', 'Pasaporte', 'B7654321', 'elena.moreno@alumnos.com', 'Colombia');

-- Inserta datos en la tabla empresa_bolsa_talento
INSERT INTO empresa_bolsa_talento (nombre_empresa, persona_contacto, email_contacto) VALUES
('Tech Solutions S.L.', 'Marta Díaz', 'marta.diaz@techsolutions.com'),
('Data Insights Corp.', 'Pedro Jiménez', 'pedro.jimenez@datainsights.com'),
('SecureNet', 'Lucía Castillo', 'lucia.castillo@securenet.com');


--Tablas con dependencias
-- Insertar datos en la tabla edicion
INSERT INTO edicion (id_bootcamp, numero_edicion, fecha_inicio, fecha_fin) VALUES
(1, 1, '2023-01-15', '2023-07-15'), -- Full Stack, ed. 1 (finalizada)
(1, 2, '2023-09-01', '2024-03-01'), -- Full Stack, ed. 2 (en curso)
(2, 1, '2023-06-01', '2023-12-01'); -- Ciencia de Datos, ed. 1 (en curso)

-- Inserta datos en la tabla matricula 
INSERT INTO matricula (id_alumno, id_edicion, fecha_matricula) VALUES
(1, 1, '2022-12-10'), -- Ana Pérez en Full Stack ed. 1 -> id_matricula = 1
(2, 1, '2022-12-12'), -- Luis García en Full Stack ed. 1 -> id_matricula = 2
(3, 1, '2022-12-15'), -- Sofía Rodríguez en Full Stack ed. 1 -> id_matricula = 3
(4, 2, '2023-08-20'), -- David Fernández en Full Stack ed. 2 -> id_matricula = 4
(5, 3, '2023-05-25'); -- Elena Moreno en Ciencia de Datos ed. 1 -> id_matricula = 5

-- Inserta datos en la tabla oferta_bolsa_talento
INSERT INTO oferta_bolsa_talento (id_empresa, nombre_puesto, descripcion, fecha_publicacion, estado_oferta) VALUES
(1, 'Desarrollador Junior Frontend', 'Buscamos un desarrollador con conocimientos en React y CSS.', '2023-07-20', 'abierta'),
(2, 'Data Analyst', 'Analista de datos para el equipo de marketing. Se requiere SQL y Python.', '2023-08-01', 'abierta'),
(1, 'Desarrollador Backend', 'Desarrollador con experiencia en Node.js y bases de datos NoSQL.', '2023-05-10', 'cerrada');

-- Inserta datos en la tabla facturacion
INSERT INTO facturacion (id_matricula, numero_factura, concepto, importe_total, fecha_emision, fecha_vencimiento, fecha_pago, estado_factura) VALUES
(1, 'F2022-001', 'Matrícula Bootcamp Full Stack Ed. 1', 6000.00, '2022-12-10', '2023-01-10', '2023-01-05', 'pagada'),
(2, 'F2022-002', 'Matrícula Bootcamp Full Stack Ed. 1', 6000.00, '2022-12-12', '2023-01-12', '2023-01-10', 'pagada'),
(3, 'F2022-003', 'Matrícula Bootcamp Full Stack Ed. 1', 6000.00, '2022-12-15', '2023-01-15', NULL, 'vencida'),
(4, 'F2023-004', 'Matrícula Bootcamp Full Stack Ed. 2', 6500.00, '2023-08-20', '2023-09-20', NULL, 'pendiente'),
(5, 'F2023-005', 'Matrícula Ciencia de Datos Ed. 1', 7000.00, '2023-05-25', '2023-06-25', '2023-06-20', 'pagada');

-- Insertar datos en la tabla clase 
INSERT INTO clase (id_edicion, id_modulo, id_profesor, fecha_clase, hora_inicio, hora_fin) VALUES
(1, 1, 1, '2023-01-20', '09:00:00', '13:00:00'), -- Full Stack ed.1, Intro Prog con Carlos
(1, 2, 2, '2023-03-10', '09:00:00', '13:00:00'), -- Full Stack ed.1, SQL con Laura
(2, 1, 1, '2023-09-15', '09:00:00', '13:00:00'), -- Full Stack ed.2, Intro Prog con Carlos
(3, 2, 2, '2023-07-05', '10:00:00', '14:00:00'), -- Ciencia de Datos ed.1, SQL con Laura
(3, 3, 3, '2023-08-22', '10:00:00', '14:00:00'); -- Ciencia de Datos ed.1, Python con Javier


-- Inserta datos en la tabla practica (sino hay fila significa que el alumno no ha presentado la práctica)
INSERT INTO practica (id_matricula, id_modulo, numero_intento, es_apto, fecha_entrega) VALUES
(1, 1, 1, TRUE, '2023-02-15 10:30:00'), -- Intro Prog
(1, 2, 1, TRUE, '2023-04-01 18:00:00'); -- SQL
(2, 1, 1, FALSE, '2023-02-16 11:00:00'), -- Intro Prog (intento 1, suspenso)
(2, 1, 2, TRUE, '2023-02-28 09:00:00');  -- Intro Prog (intento 2, apto)

-- Inserta datos en la tabla aplicacion_bolsa_talento 
INSERT INTO aplicacion_bolsa_talento (id_oferta, id_alumno, fecha_aplicacion, estado_aplicacion) VALUES
(1, 1, '2023-07-22', 'aceptado'),    -- Ana (alumno 1) aplica a Dev Junior (oferta 1)
(1, 2, '2023-07-23', 'revision'),    -- Luis (alumno 2) aplica a Dev Junior (oferta 1)
(2, 1, '2023-08-05', 'rechazado'),   -- Ana (alumno 1) aplica Data Analyst (oferta 2)
(2, 5, '2023-08-10', 'revision');    -- Elena (alumno 5) aplica a Data Analyst (oferta 2)