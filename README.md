# hands-on-coding-advance-sql
Solución completa de la práctica de SQL avanzado y Data Warehouse, implementando desde el modelado de datos hasta análisis avanzado de llamadas (Interactive Voice Response) para atención al cliente.

## Descripción del Proyecto

La práctica se divide en:
1. **Modelado de datos** para un sistema educativo (KeepCoding)
2. **Análisis de sistema IVR** con procesamiento avanzado de llamadas
3. **Implementación de métricas de negocio** y funciones de limpieza

El objetivo es desarrollar habilidades en SQL avanzado, diseño de bases de datos y análisis de datos empresariales.

## Estructura del Proyecto

Cada ejercicio se entrega como archivo `.sql` independiente:
- **Ejercicios 1-2**: Modelado PostgreSQL
- **Ejercicios 3-11**: Análisis IVR incremental 
- **Ejercicio 12**: Tabla resumen consolidada
- **Ejercicio 13**: Función de utilidad

### Análisis y Documentación
- **`1_Diagrama_entidad_relacion_keepcoding.pdf`** - **Ejercicio 1**: Diagrama ER del modelo de datos KeepCoding.

### Configuración de Base de Datos (PostgreSQL)
- **`2_Creacion_tablas_keepcoding.sql`** - **Ejercicio 2**: Esquema completo para PostgreSQL con datos ejemplo para testing.

### Análisis IVR (BigQuery)
- **`3_ivr_detail_and_features.sql`** - **Ejercicios 3-11**: Tabla detallada IVR con características calculadas:
  - **Ejercicio 3**: Tabla base `ivr_detail` con JOIN de `ivr_calls`, `ivr_modules`, `ivr_steps`
  - **Ejercicio 4**: Campo `vdn_aggregation` (FRONT/TECH/ABSORPTION/RESTO)
  - **Ejercicio 5**: Campos `document_type` y `document_identification`
  - **Ejercicio 6**: Campo `customer_phone`
  - **Ejercicio 7**: Campo `billing_account_id`
  - **Ejercicio 8**: Flag `masiva_lg` (módulo AVERIA_MASIVA)
  - **Ejercicio 9**: Flag `info_by_phone_lg` (identificación por teléfono)
  - **Ejercicio 10**: Flag `info_by_dni_lg` (identificación por DNI)
  - **Ejercicio 11**: Campos `repeated_phone_24H` y `cause_recall_phone_24H`

- **`4_ivr_summary.sql`** - **Ejercicio 12**: Tabla resumen con un registro por llamada
- **`5_clean_function.sql`** - **Ejercicio 13**: Función de limpieza `clean_integer`


## Funcionalidades Técnicas

### **Tabla `ivr_detail` (Ejercicio 3)**
**Campos principales:**
- `calls_ivr_id`, `calls_phone_number`, `calls_ivr_result`
- `calls_start_date_id`, `calls_end_date_id` (formato YYYYMMDD)
- `module_sequence`, `module_name`, `step_sequence`, `step_name`
- `document_type`, `document_identification`, `customer_phone`, `billing_account_id`

### **Tabla `ivr_summary` (Ejercicio 12)**
**Un registro por llamada con todos los indicadores:**
- Campos base de la llamada (`ivr_id`, `phone_number`, `start_date`, etc.)
- Todos los campos calculados de los ejercicios 4-11
- Métricas agregadas (`total_duration`, `steps_module`, `module_aggregation`)


## Resultados y Métricas

### **KPIs Implementados**
- **Tasa de identificación de clientes** por método (teléfono, DNI, facturación)
- **Análisis de llamadas masivas** y su impacto en la duración
- **Patrones de rellamada** en ventanas temporales de 24H
- **Efectividad del sistema IVR** por categoría VDN
- **Distribución de llamadas** por módulos y pasos

### **Casos de Uso Empresariales**
- **Customer Service**: Optimización de flujos de identificación
- **Business Intelligence**: Análisis de comportamiento de usuarios
- **Operaciones**: Monitoreo de incidencias masivas
- **Calidad**: Medición de efectividad del sistema IVR

## Tecnologías y Técnicas Utilizadas

### **Bases de Datos**
- **PostgreSQL** - Sistema educativo y modelado relacional
- **BigQuery** - Análisis de big data y funciones avanzadas

### **Técnicas SQL Avanzadas**
- **Window Functions** - Análisis temporal y ranking
- **Common Table Expressions (CTE)** - Modularización de consultas
- **User Defined Functions (UDF)** - Funciones personalizadas
- **Analytical Functions** - `LEAD`, `LAG`, `ROW_NUMBER`
- **Complex JOINs** - Relaciones entre múltiples tablas
- **Conditional Logic** - `CASE WHEN` para reglas de negocio

---

