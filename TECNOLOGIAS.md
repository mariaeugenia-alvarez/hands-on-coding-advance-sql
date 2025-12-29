# Resumen de Tecnologías, Lenguajes y Frameworks

## 📋 Descripción General
Este repositorio contiene una práctica completa de SQL avanzado y Data Warehouse, enfocada en el modelado de datos y análisis de sistemas IVR (Interactive Voice Response) para atención al cliente.

---

## 💻 Lenguajes de Programación

### SQL (Structured Query Language)
- **Propósito**: Lenguaje principal utilizado en todo el proyecto
- **Uso**: Creación de esquemas, consultas complejas, análisis de datos y funciones personalizadas
- **Archivos**: Todos los archivos `.sql` del repositorio

---

## 🗄️ Sistemas de Bases de Datos

### 1. PostgreSQL
- **Versión**: Compatible con estándares modernos de PostgreSQL
- **Uso**: Modelado de sistema educativo (KeepCoding)
- **Características implementadas**:
  - Creación de tablas relacionales
  - Claves primarias y foráneas
  - Constraints y validaciones
  - Tipos de datos especializados (SERIAL, VARCHAR, TEXT, DATE, BOOLEAN)
  - Relaciones many-to-many
- **Archivos**:
  - `2_Creacion_tablas_keepcoding.sql`
  - `2b_Datos_ejemplo_keepcoding.sql`

### 2. Google BigQuery
- **Uso**: Análisis de big data y procesamiento de llamadas IVR
- **Características implementadas**:
  - Consultas analíticas a gran escala
  - Window Functions avanzadas
  - User Defined Functions (UDF)
  - Common Table Expressions (CTE)
  - Funciones específicas de BigQuery (FORMAT_DATE, CAST, IFNULL)
- **Archivos**:
  - `3_ivr_detail_and_features.sql`
  - `4_ivr_summary.sql`
  - `5_clean_function.sql`

---

## 🔧 Técnicas SQL Avanzadas

### Window Functions
- **Funciones utilizadas**:
  - `ROW_NUMBER()` - Numeración de filas para selección de registros únicos
  - `LEAD()` - Acceso a valores de filas siguientes
  - `LAG()` - Acceso a valores de filas anteriores
  - `PARTITION BY` - Agrupación de datos para cálculos por ventana
- **Uso**: Análisis temporal, ranking de llamadas, detección de patrones

### Common Table Expressions (CTE)
- **Implementación**: WITH clauses para modularizar consultas complejas
- **Beneficios**: Código más legible, reutilizable y mantenible
- **Ejemplos**: 
  - `ivr_calls_summary`
  - `customer_calls_info`

### User Defined Functions (UDF)
- **Función implementada**: `clean_integer()`
- **Propósito**: Limpieza y normalización de datos
- **Sintaxis**: BigQuery SQL UDF
- **Ejemplo**: Conversión de valores NULL a -999999

### Joins Complejos
- **Tipos utilizados**:
  - `LEFT JOIN` - Preservación de todas las llamadas
  - Joins múltiples entre 3+ tablas
  - Condiciones de join compuestas
- **Tablas relacionadas**: `ivr_calls`, `ivr_modules`, `ivr_steps`

### Lógica Condicional Avanzada
- **CASE WHEN**: Implementación de reglas de negocio complejas
- **Agregaciones condicionales**: Uso de MAX/MIN con CASE
- **Clasificaciones**: Categorización de VDN (FRONT/TECH/ABSORPTION/RESTO)

### Funciones Analíticas
- **QUALIFY**: Filtrado de resultados de window functions
- **Agregaciones con condiciones**: MAX, MIN, COUNT con lógica compleja
- **Funciones de fecha**: FORMAT_DATE, DATE, CAST para conversión temporal

---

## 📊 Herramientas de Modelado

### Diagramas Entidad-Relación (ER)
- **Herramienta**: Software de modelado de bases de datos
- **Formato**: PDF
- **Contenido**: Modelo completo del sistema educativo KeepCoding
- **Archivo**: `1_Diagrama_entidad_relacion_keepcoding.pdf`
- **Elementos modelados**:
  - Entidades: Bootcamp, Módulo, Profesor, Alumno, Empresa
  - Relaciones: Ediciones, Imparticiones, Matrículas, Bolsa de Talento
  - Cardinalidades y restricciones

---

## 🎯 Funcionalidades y Casos de Uso

### Análisis de Datos
- **KPIs Implementados**:
  - Tasa de identificación de clientes (por teléfono, DNI, facturación)
  - Análisis de llamadas masivas y su impacto
  - Patrones de rellamada en ventanas de 24 horas
  - Efectividad del sistema IVR por categoría
  - Distribución de llamadas por módulos y pasos

### Business Intelligence
- **Métricas de negocio**: Cálculo de indicadores clave de rendimiento
- **Agregaciones temporales**: Análisis por fecha (formato YYYYMMDD)
- **Segmentación de clientes**: Análisis por segmento de cliente
- **Análisis de comportamiento**: Patrones de uso del sistema IVR

---

## 📁 Estructura del Proyecto

### Organización de Archivos
```
├── 1_Diagrama_entidad_relacion_keepcoding.pdf    (Ejercicio 1: Modelado)
├── 2_Creacion_tablas_keepcoding.sql              (Ejercicio 2: DDL PostgreSQL)
├── 2b_Datos_ejemplo_keepcoding.sql               (Datos de prueba)
├── 3_ivr_detail_and_features.sql                 (Ejercicios 3-11: Análisis IVR)
├── 4_ivr_summary.sql                             (Ejercicio 12: Tabla resumen)
├── 5_clean_function.sql                          (Ejercicio 13: UDF)
└── README.md                                      (Documentación completa)
```

### Convenciones de Código
- **Nomenclatura**: Snake_case para columnas y tablas
- **Idioma**: Español e inglés mezclados (español para nombres de negocio, inglés para técnicos)
- **Comentarios**: Descriptivos en español explicando cada ejercicio
- **Formato**: SQL formateado con indentación clara

---

## 🎓 Habilidades Técnicas Demostradas

### Diseño de Bases de Datos
- Modelado conceptual (ER)
- Modelado lógico (tablas relacionales)
- Normalización de datos
- Diseño de claves y constraints

### SQL Avanzado
- Consultas complejas multi-tabla
- Optimización de queries
- Funciones de ventana
- Subconsultas y CTEs
- User Defined Functions

### Data Warehouse
- Tablas de hechos y dimensiones
- Agregaciones y métricas de negocio
- Procesamiento de datos a gran escala
- Modelado dimensional

### Análisis de Datos
- Cálculo de KPIs
- Análisis temporal
- Detección de patrones
- Agregaciones complejas

---

## 🚀 Tecnologías de Ecosistema

### Control de Versiones
- **Git**: Control de versiones del código SQL y documentación
- **GitHub**: Plataforma de hosting del repositorio

### Documentación
- **Markdown**: Formato de documentación (README.md)
- **PDF**: Documentación de diagramas técnicos

---

## 📝 Resumen Ejecutivo

Este repositorio demuestra competencias avanzadas en:

1. **Lenguajes**: SQL (100% del código)
2. **Bases de Datos**: PostgreSQL y Google BigQuery
3. **Técnicas**: Window Functions, CTEs, UDFs, Joins complejos
4. **Modelado**: Diagramas ER y modelado relacional
5. **Análisis**: KPIs, métricas de negocio y Business Intelligence
6. **Documentación**: Markdown y diagramas técnicos

El proyecto está completamente desarrollado en SQL, utilizando dos motores de bases de datos diferentes (PostgreSQL para modelado transaccional y BigQuery para análisis de big data), con implementación de técnicas avanzadas de SQL y análisis de datos empresariales.

---

**Autor**: María Eugenia Álvarez  
**Proyecto**: Práctica SQL Avanzado y Data Warehouse  
**Institución**: KeepCoding
