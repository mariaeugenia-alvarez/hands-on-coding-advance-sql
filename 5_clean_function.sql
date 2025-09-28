CREATE OR REPLACE FUNCTION keepcoding.clean_integer(value_int INT64)
RETURNS INT64
AS (
  IFNULL(value_int, -999999)
);


--Para probar que la función funciona, sobre la tabla customer cambie la edad a NULL en un customer_id y luego llame a la funcion
UPDATE `keepcoding.customer`
SET age = NULL
WHERE customer_id = 1234;

SELECT
  customer_id,
  age,
  keepcoding.clean_integer(age) AS cleaned_value
FROM
  `keepcoding.customer`;