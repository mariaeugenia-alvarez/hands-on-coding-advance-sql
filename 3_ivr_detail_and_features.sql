-- CREA LA TABLA ivr_detail, mediante un LEFT JOIN para asegurar que todas las llamadas se incluyan en el resultado (incluso las que no pasaron por un módulo o un paso específico)

CREATE TABLE keepcoding.ivr_detail AS(
  SELECT
    call.ivr_id AS calls_ivr_id,
    call.phone_number AS calls_phone_number,
    call.ivr_result AS calls_ivr_result,
    call.vdn_label AS calls_vdn_label,
    call.start_date AS calls_start_date,
  --Campo calculado
    CAST(FORMAT_DATE('%Y%m%d', DATE(call.start_date)) AS INT64) AS calls_start_date_id,
    call.end_date AS calls_end_date,
  --Campo calculado
    CAST(FORMAT_DATE('%Y%m%d', DATE(call.end_date)) AS INT64) AS calls_end_date_id,
    call.total_duration AS calls_total_duration,
    call.customer_segment AS calls_customer_segment,
    call.ivr_language AS calls_ivr_language,
    call.steps_module AS calls_steps_module,
    call.module_aggregation AS calls_module_aggregation,

    mod.module_sequece,
    mod.module_name,
    mod.module_duration,
    mod.module_result,

    stp.step_sequence,
    stp.step_name,
    stp.step_result,
    stp.step_description_error,
    stp.document_type,
    stp.document_identification,
    stp.customer_phone,
    stp.billing_account_id,

FROM keepcoding.ivr_calls call
LEFT JOIN keepcoding.ivr_modules mod
    ON call.ivr_id = mod.ivr_id
LEFT JOIN keepcoding.ivr_steps stp
    ON mod.ivr_id = stp.ivr_id 
    AND mod.module_sequece = stp.module_sequece
);

--4. Generar el campo vdn_aggregation para cada llamada
SELECT calls_ivr_id,
       MAX(CASE WHEN STARTS_WITH(calls_vdn_label, 'ATC') THEN 'FRONT'
                WHEN STARTS_WITH(calls_vdn_label, 'TECH') THEN 'TECH'
                WHEN STARTS_WITH(calls_vdn_label, 'ABSORPTION') THEN 'ABSORPTION'
                ELSE 'RESTO'
       END) AS vdn_aggregation
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
ORDER BY calls_ivr_id;

