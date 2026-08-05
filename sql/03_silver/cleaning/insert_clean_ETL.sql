-- ============================================================
-- Script   : INSERT limpio — Bronze → Silver (ETL completo)
-- Capa     : Silver (transformación desde Bronze)
-- Objetivo : Cargar los 10,000 registros en silver.sales
--            aplicando las tres transformaciones en un solo
--            paso (ETL en vuelo):
--              1. Limpieza de texto      (CASE → NULL)
--              2. Conversión de tipos    (CAST a INTEGER/NUMERIC/DATE)
--              3. Marcado de registros   (record_status)
-- Origen   : bronze.sales
-- Destino  : silver.sales
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 30 de julio 2026
-- ============================================================
-- Notas:
--   * La transformación ocurre "en vuelo": los datos sucios
--     nunca tocan Silver. Se limpian y convierten en el SELECT
--     antes de insertarse.
--   * record_status se calcula según total_spent: si falta el
--     monto (ERROR/UNKNOWN/NULL), el registro se marca como
--     'incomplete'; de lo contrario, 'active'.
--   * Bronze permanece intacto como respaldo del dato original.
-- ============================================================

INSERT INTO silver.sales (transaction_id, item, payment_method, location, record_status, quantity, price_per_unit, total_spent, transaction_date)

SELECT
    transaction_id,
    CASE WHEN item IN ('ERROR', 'UNKNOWN') THEN NULL ELSE item END,
    CASE WHEN payment_method IN ('ERROR', 'UNKNOWN') THEN NULL ELSE payment_method END,
    CASE WHEN location IN ('ERROR', 'UNKNOWN') THEN NULL ELSE location END,
    CASE WHEN total_spent IN ('ERROR', 'UNKNOWN') OR total_spent IS NULL THEN 'incomplete' ELSE 'active' END,

    CAST (CASE WHEN quantity IN ('ERROR', 'UNKNOWN') THEN NULL ELSE quantity END AS INTEGER),
    CAST (CASE WHEN price_per_unit IN ('ERROR', 'UNKNOWN') THEN NULL ELSE price_per_unit END AS NUMERIC(10,2)),
    CAST (CASE WHEN total_spent IN ('ERROR', 'UNKNOWN') THEN NULL ELSE total_spent END AS NUMERIC(10,2)),
    CAST (CASE WHEN transaction_date IN ('ERROR', 'UNKNOWN') THEN NULL ELSE transaction_date END AS DATE)

FROM bronze.sales;