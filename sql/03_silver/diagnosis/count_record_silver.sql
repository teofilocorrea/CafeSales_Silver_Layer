-- ============================================================
-- Script   : Validación — Conteo de registros en Silver
-- Capa     : Silver (validación post-carga)
-- Objetivo : Confirmar que los 10,000 registros de Bronze
--            se cargaron correctamente en silver.sales
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 04 de Agosto 2026
-- ============================================================

SELECT COUNT(*) AS total_registro_silver
FROM silver.sales;

-- Resultado esperado: 10000