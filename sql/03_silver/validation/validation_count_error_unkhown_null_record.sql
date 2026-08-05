-- ============================================================
-- Script   : Validación — Comparación Bronze vs Silver
-- Capa     : Silver (validación post-carga)
-- Objetivo : Contar los valores sucios (ERROR/UNKNOWN/NULL) en
--            Bronze para compararlos con los NULL de Silver y
--            confirmar que la limpieza fue exacta y sin pérdida
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 04 de agosto 2026
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE item IS NULL) AS null_item,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE price_per_unit IS NULL) AS null_price_per_unit,
    COUNT(*) FILTER (WHERE total_spent IS NULL) AS null_total_spent,
    COUNT(*) FILTER (WHERE payment_method IS NULL) AS null_payment_method,
    COUNT(*) FILTER (WHERE location IS NULL) AS null_location,
    COUNT(*) FILTER (WHERE transaction_date IS NULL) AS null_transaction_date
FROM silver.sales;

SELECT
    COUNT(*) FILTER (WHERE item IN ('ERROR','UNKNOWN') OR item IS NULL) AS sucios_item,
    COUNT(*) FILTER ( WHERE quantity IN ('ERROR', 'UNKNOWN') OR quantity IS NULL ) AS null_quantity,
    COUNT(*) FILTER ( WHERE price_per_unit IN ('ERROR', 'UNKNOWN') OR price_per_unit IS NULL ) AS null_price_per_unit,
    COUNT(*) FILTER ( WHERE total_spent IN ('ERROR', 'UNKNOWN') OR total_spent IS NULL ) AS null_total_spent,
    COUNT(*) FILTER ( WHERE payment_method IN ('ERROR', 'UNKNOWN') OR payment_method IS NULL ) AS null_payment_method,
    COUNT(*) FILTER ( WHERE location IN ('ERROR', 'UNKNOWN') OR location IS NULL ) AS null_location,
    COUNT(*) FILTER ( WHERE transaction_date IN ('ERROR', 'UNKNOWN') OR transaction_date IS NULL ) null_transaction_date
FROM bronze.sales;