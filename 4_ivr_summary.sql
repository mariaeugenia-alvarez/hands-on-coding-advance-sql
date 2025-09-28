-- CREA LA TABLA ivr_summary a partir de ivr_detail y campos calculados. 
-- Un registro por llamada con la información de los puntos 4-11.

CREATE TABLE keepcoding.ivr_summary AS(
  WITH 
  ivr_calls_summary AS(
    SELECT
      calls_ivr_id AS ivr_id,
      MAX(calls_phone_number) AS phone_number,
      MAX(calls_ivr_result) AS ivr_result,
      MAX(CASE WHEN STARTS_WITH(calls_vdn_label, 'ATC') THEN 'FRONT'
              WHEN STARTS_WITH(calls_vdn_label, 'TECH') THEN 'TECH'
              WHEN STARTS_WITH(calls_vdn_label, 'ABSORPTION') THEN 'ABSORPTION'
              ELSE 'RESTO'
          END) AS vdn_aggregation,
      MAX(calls_start_date) AS start_date,
      MAX(calls_end_date) AS end_date,
      MAX(calls_total_duration) AS total_duration,
      MAX(calls_customer_segment) AS customer_segment,
      MAX(calls_ivr_language) AS ivr_language,
      MAX(calls_steps_module) AS steps_module,
      MAX(calls_module_aggregation) AS module_aggregation,
      MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1
          ELSE 0
          END) AS masiva_lg,
      MAX(CASE WHEN (step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK') THEN 1 
          ELSE 0 
          END) AS info_by_phone_lg,
      MAX(CASE WHEN (step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK') THEN 1 
          ELSE 0 
          END) AS info_by_dni_lg
  FROM keepcoding.ivr_detail
  GROUP BY calls_ivr_id
  ),   

  customer_calls_info AS (
    SELECT calls_ivr_id,
      document_type,
      document_identification,
      customer_phone,
      billing_account_id
      FROM keepcoding.ivr_detail
      QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY 
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
          CASE 
              WHEN customer_phone IS NOT NULL AND customer_phone NOT IN ('UNKNOWN') THEN 1
              WHEN customer_phone IS NOT NULL THEN 2
              ELSE 3
          END,
          CASE 
              WHEN billing_account_id IS NOT NULL AND billing_account_id NOT IN ('UNKNOWN') THEN 1
              WHEN billing_account_id IS NOT NULL THEN 2
              ELSE 3
          END,
          document_type,
          document_identification, 
          customer_phone,
          billing_account_id) = 1
  ),

  lead_lag_call AS(
      SELECT calls_ivr_id,
             calls_phone_number,
             calls_start_date,
             TIMESTAMP_ADD(calls_start_date, INTERVAL 24 HOUR) AS upp_limit_date,
             TIMESTAMP_ADD(calls_start_date, INTERVAL -24 HOUR) AS inf_limit_date,
             LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC) as next_call_date,
             LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC) as previous_call_date
      FROM keepcoding.ivr_detail
      GROUP BY calls_ivr_id, calls_phone_number, calls_start_date
  ),

  status_repeat_calls AS(
    SELECT calls_ivr_id,
           MAX(calls_phone_number) AS phone_number,
           MAX(CASE WHEN next_call_date BETWEEN calls_start_date AND upp_limit_date THEN 1 ELSE 0 END) AS cause_recall_phone_24H,
           MAX(CASE WHEN previous_call_date BETWEEN inf_limit_date AND calls_start_date THEN 1 ELSE 0 END) AS repeated_phone_24H
    FROM lead_lag_call
    GROUP BY calls_ivr_id
  )

SELECT
  ics.ivr_id,
  ics.phone_number,
  ics.ivr_result,
  ics.vdn_aggregation,
  ics.start_date,
  ics.end_date,
  ics.total_duration,
  ics.customer_segment,
  ics.ivr_language,
  ics.steps_module,
  ics.module_aggregation,
  ics.masiva_lg,
  ics.info_by_phone_lg,
  ics.info_by_dni_lg,
  cci.document_type,
  cci.document_identification,
  cci.customer_phone,
  cci.billing_account_id,
  src.cause_recall_phone_24H,
  src.repeated_phone_24H

FROM ivr_calls_summary ics
LEFT JOIN customer_calls_info cci ON ics.ivr_id = cci.calls_ivr_id
LEFT JOIN status_repeat_calls src ON ics.ivr_id = src.calls_ivr_id
);