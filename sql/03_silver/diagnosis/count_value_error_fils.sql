-- ============================================================
-- Script   : Diagnóstico — Conteo de valores ERROR
-- Capa     : Silver (diagnóstico sobre Bronze)
-- Objetivo : Contar los valores ERROR reales en cada columna
--            de bronze.sales antes de la limpieza
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 25 Julio 2026
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE transaction_id = 'ERROR')   AS error_transaction_id,
    COUNT(*) FILTER (WHERE item = 'ERROR')             AS error_item,
    COUNT(*) FILTER (WHERE quantity = 'ERROR')         AS error_quantity,
    COUNT(*) FILTER (WHERE price_per_unit = 'ERROR')   AS error_price_per_unit,
    COUNT(*) FILTER (WHERE total_spent = 'ERROR')      AS error_total_spent,
    COUNT(*) FILTER (WHERE payment_method = 'ERROR')   AS error_payment_method,
    COUNT(*) FILTER (WHERE location = 'ERROR')         AS error_location,
    COUNT(*) FILTER (WHERE transaction_date = 'ERROR') AS error_transaction_date
FROM bronze.sales;