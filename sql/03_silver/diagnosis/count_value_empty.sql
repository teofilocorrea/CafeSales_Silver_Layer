-- ============================================================
-- Script   : Diagnóstico — Conteo de valores EMPTY
-- Capa     : Silver (diagnóstico sobre Bronze)
-- Objetivo : Contar los valores EMPTY reales en cada columna
--            de bronze.sales antes de la limpieza
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 25 Julio 2026
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE TRIM(transaction_id) = '')   AS empty_transaction_id,
    COUNT(*) FILTER (WHERE TRIM(item) = '')             AS empty_item,
    COUNT(*) FILTER (WHERE TRIM(quantity) = '')         AS empty_quantity,
    COUNT(*) FILTER (WHERE TRIM(price_per_unit) = '')   AS empty_price_per_unit,
    COUNT(*) FILTER (WHERE TRIM(total_spent) = '')      AS empty_total_spent,
    COUNT(*) FILTER (WHERE TRIM(payment_method) = '')   AS empty_payment_method,
    COUNT(*) FILTER (WHERE TRIM(location) = '')         AS empty_location,
    COUNT(*) FILTER (WHERE TRIM(transaction_date) = '') AS empty_transaction_date
FROM bronze.sales;