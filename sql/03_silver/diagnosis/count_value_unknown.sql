-- ============================================================
-- Script   : Diagnóstico — Conteo de valores UNKNOWN
-- Capa     : Silver (diagnóstico sobre Bronze)
-- Objetivo : Contar los valores UNKNOWN reales en cada columna
--            de bronze.sales antes de la limpieza
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 25 Julio 2026
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE transaction_id = 'UNKNOWN')   AS unknown_transaction_id,
    COUNT(*) FILTER (WHERE item = 'UNKNOWN')             AS unknown_item,
    COUNT(*) FILTER (WHERE quantity = 'UNKNOWN')         AS unknown_quantity,
    COUNT(*) FILTER (WHERE price_per_unit = 'UNKNOWN')   AS unknown_price_per_unit,
    COUNT(*) FILTER (WHERE total_spent = 'UNKNOWN')      AS unknown_total_spent,
    COUNT(*) FILTER (WHERE payment_method = 'UNKNOWN')   AS unknown_payment_method,
    COUNT(*) FILTER (WHERE location = 'UNKNOWN')         AS unknown_location,
    COUNT(*) FILTER (WHERE transaction_date = 'UNKNOWN') AS unknown_transaction_date
FROM bronze.sales;