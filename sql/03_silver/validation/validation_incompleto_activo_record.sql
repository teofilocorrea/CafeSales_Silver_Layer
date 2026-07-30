-- ============================================================
-- Script   : Ensayo — Marcado de registros (record_status)
-- Capa     : Silver (transformación desde Bronze)
-- Objetivo : Clasificar cada registro como 'active' o
--            'incomplete' según tenga monto (total_spent) válido
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 30 de julio 2026
-- ============================================================

SELECT transaction_id, total_spent,
    CASE
        WHEN total_spent IN ('ERROR', 'UNKNOWN') OR total_spent IS NULL
        THEN 'incomplete'
        ELSE 'active'
    END AS record_status
FROM bronze.sales;