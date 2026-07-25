-- ============================================================
-- Script   : Diagnóstico — Conteo de valores NULL
-- Capa     : Silver (diagnóstico sobre Bronze)
-- Objetivo : Contar los valores NULL reales en cada columna
--            de bronze.sales antes de la limpieza
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 24 Julio 2026
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL)   AS null_transaction_id,
    COUNT(*) FILTER (WHERE item IS NULL)             AS null_item,
    COUNT(*) FILTER (WHERE quantity IS NULL)         AS null_quantity,
    COUNT(*) FILTER (WHERE price_per_unit IS NULL)   AS null_price_per_unit,
    COUNT(*) FILTER (WHERE total_spent IS NULL)      AS null_total_spent,
    COUNT(*) FILTER (WHERE payment_method IS NULL)   AS null_payment_method,
    COUNT(*) FILTER (WHERE location IS NULL)         AS null_location,
    COUNT(*) FILTER (WHERE transaction_date IS NULL) AS null_transaction_date
FROM bronze.sales;