-- ============================================================
-- Script   : Ensayo de limpieza — Campos numéricos y fecha
-- Capa     : Silver (transformación desde Bronze)
-- Objetivo : Limpiar ERROR/UNKNOWN a NULL y convertir tipos
--            (INTEGER, NUMERIC, DATE) mediante CASE + CAST
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 29 de julio 2026
-- ============================================================
SELECT quantity,
    CAST(
         CASE WHEN quantity
         IN ('ERROR','UNKNOWN')
         THEN NULL ELSE quantity END AS INTEGER
        ) AS quantity_limpio,

    price_per_unit,
    CAST(
         CASE WHEN price_per_unit
         IN ('ERROR','UNKNOWN')
         THEN NULL ELSE price_per_unit END AS NUMERIC(10,2)
        ) AS price_per_unit_limpio,

    total_spent,
    CAST(
         CASE WHEN total_spent
         IN ('ERROR','UNKNOWN')
         THEN NULL ELSE total_spent END AS NUMERIC(10,2)
        ) AS total_spent_limpio,

     transaction_date,
    CAST(
         CASE WHEN transaction_date
         IN ('ERROR','UNKNOWN')
         THEN NULL ELSE transaction_date END AS DATE
        ) AS transaction_date_limpio
FROM bronze.sales;