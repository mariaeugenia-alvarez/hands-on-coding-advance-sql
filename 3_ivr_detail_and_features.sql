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


--5. Generar los campos document_type y document_identification
SELECT calls_ivr_id,
       document_type,
       document_identification
FROM keepcoding.ivr_detail
QUALIFY ROW_NUMBER() OVER(
    PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY 
        CASE 
            WHEN document_type IS NOT NULL AND document_type NOT IN ('UNKNOWN', 'DESCONOCIDO') THEN 1
            WHEN document_type IS NOT NULL THEN 2
            ELSE 3
        END,
        CASE 
            WHEN document_identification IS NOT NULL AND document_identification NOT IN ('UNKNOWN') THEN 1
            WHEN document_identification IS NOT NULL THEN 2
            ELSE 3
        END,
        document_type,
        document_identification
) = 1;


--6. Generar el campo customer_phone
SELECT calls_ivr_id,
       customer_phone
FROM keepcoding.ivr_detail
QUALIFY ROW_NUMBER() OVER(
    PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY 
        CASE 
            WHEN customer_phone IS NOT NULL AND customer_phone NOT IN ('UNKNOWN') THEN 1
            WHEN customer_phone IS NOT NULL THEN 2
            ELSE 3
        END,
        customer_phone
) = 1;


--7. Generar el campo billing_account_id
SELECT calls_ivr_id,
       billing_account_id
FROM keepcoding.ivr_detail
QUALIFY ROW_NUMBER() OVER(
    PARTITION BY CAST(calls_ivr_id AS STRING)
    ORDER BY 
        CASE 
            WHEN billing_account_id IS NOT NULL AND billing_account_id NOT IN ('UNKNOWN') THEN 1
            WHEN billing_account_id IS NOT NULL THEN 2
            ELSE 3
        END,
        billing_account_id
) = 1;


--8. Generar el campo masiva_lg
SELECT calls_ivr_id,
       MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) AS masiva_lg
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
ORDER BY calls_ivr_id;


--9 y 10. Generar los campos info_by_phone_lg e info_by_dni_lg
SELECT calls_ivr_id,
       MAX(CASE WHEN (step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK') THEN 1 ELSE 0 END) AS info_by_phone_lg,
       MAX(CASE WHEN (step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK') THEN 1 ELSE 0 END) AS info_by_dni_lg
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
ORDER BY calls_ivr_id;


--11. Generar los campos repeated_phone_24H, cause_recall_phone_24H
WITH status_call AS(
    SELECT calls_ivr_id,
           calls_phone_number,
           calls_start_date,
           TIMESTAMP_ADD(calls_start_date, INTERVAL 24 HOUR) AS upp_limit_date,
           TIMESTAMP_ADD(calls_start_date, INTERVAL -24 HOUR) AS inf_limit_date,
           LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC) as next_call_date,
           LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC) as previous_call_date
    FROM keepcoding.ivr_detail
    GROUP BY calls_ivr_id, calls_phone_number, calls_start_date
)
SELECT calls_ivr_id,
       MAX(calls_phone_number) AS calls_phone_number,
       MAX(CASE WHEN next_call_date BETWEEN calls_start_date AND upp_limit_date THEN 1 ELSE 0 END) AS cause_recall_phone_24H,
       MAX(CASE WHEN previous_call_date BETWEEN inf_limit_date AND calls_start_date THEN 1 ELSE 0 END) AS repeated_phone_24H
FROM status_call
GROUP BY calls_ivr_id
ORDER BY calls_ivr_id;