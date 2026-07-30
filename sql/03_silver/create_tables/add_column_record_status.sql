-- ============================================================
-- Script   : Agregar columna record_status a silver.sales
-- Capa     : Silver
-- Objetivo : Añadir la columna de clasificación de registros
--            (active/incomplete) definida en la Tarea #11
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 30 de julio 2026
-- ============================================================

ALTER TABLE silver.sales
ADD COLUMN record_status VARCHAR(20);