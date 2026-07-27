-- ============================================================
-- Script   : Prueba de limpieza — Campos de texto (CASE)
-- Capa     : Silver (transformación desde Bronze)
-- Objetivo : Convertir ERROR/UNKNOWN a NULL en columnas de texto
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 26 de julio 2026
-- ============================================================

SELECT
    item,
    CASE WHEN item IN ('ERROR','UNKNOWN') THEN NULL ELSE item END AS item_limpio,

    payment_method,
    CASE WHEN payment_method IN ('ERROR','UNKNOWN') THEN NULL ELSE payment_method END AS payment_method_limpio,

    location,
    CASE WHEN location IN ('ERROR','UNKNOWN') THEN NULL ELSE location END AS location_limpio
FROM bronze.sales;