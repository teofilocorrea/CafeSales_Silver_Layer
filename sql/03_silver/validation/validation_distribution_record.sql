-- ============================================================
-- Script   : Validación — Distribución de record_status
-- Capa     : Silver (validación post-carga)
-- Objetivo : Verificar cuántos registros quedaron marcados como
--            'active' (con monto) e 'incomplete' (sin monto)
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 04 de agosto 2026
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE record_status = 'incomplete') AS incomplete,
    COUNT(*) FILTER (WHERE record_status = 'active')     AS active
FROM silver.sales;