-- ============================================================
-- Script   : Ensayo de limpieza — Campos de texto (CASE)
-- Capa     : Silver (transformación desde Bronze)
-- Objetivo : Convertir ERROR/UNKNOWN a NULL en columnas de texto.
--            Los campos de texto NO requieren CAST (texto → texto),
--            solo limpieza con CASE.
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 30 de julio 2026
-- ============================================================

-- ------------------------------------------------------------
-- VALIDACIÓN PREVIA — Longitud máxima de los campos de texto
-- ------------------------------------------------------------
-- Antes de definir el tamaño de los VARCHAR en silver.sales,
-- se verifica que ningún valor exceda el límite planeado.
-- Resultado obtenido:
--   max_item = 8, max_payment_method = 14, max_location = 8
-- Conclusión: VARCHAR(100) e VARCHAR(50) son suficientes.
-- ------------------------------------------------------------

SELECT
    MAX(LENGTH(item))           AS max_item,
    MAX(LENGTH(payment_method)) AS max_payment_method,
    MAX(LENGTH(location))       AS max_location
FROM bronze.sales;


-- ------------------------------------------------------------
-- ENSAYO — Limpieza de campos de texto con CASE
-- ------------------------------------------------------------

SELECT
    item,
    CASE WHEN item IN ('ERROR','UNKNOWN') THEN NULL ELSE item END AS item_limpio,

    payment_method,
    CASE WHEN payment_method IN ('ERROR','UNKNOWN') THEN NULL ELSE payment_method END AS payment_method_limpio,

    location,
    CASE WHEN location IN ('ERROR','UNKNOWN') THEN NULL ELSE location END AS location_limpio
FROM bronze.sales;