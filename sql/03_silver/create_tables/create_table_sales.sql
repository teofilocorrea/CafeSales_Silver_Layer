-- ============================================================
-- Tabla: silver.sales
-- Descripción: Datos de ventas limpios y validados. Los valores
--              sucios (ERROR, UNKNOWN, NULL) se convierten a NULL
--              explícito. transaction_id es PK (validado sin
--              duplicados ni nulos en el diagnóstico).
-- Autor: Teofilo Correa Rojas
-- Fecha: 25 de julio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS silver.sales (

    transaction_id   VARCHAR(50),
    item             VARCHAR(100),
    quantity         INTEGER,
    price_per_unit   NUMERIC(10,2),
    total_spent      NUMERIC(10,2),
    payment_method   VARCHAR(50),
    location         VARCHAR(50),
    transaction_date DATE,

    -- Constraints
    CONSTRAINT pk_sales                 PRIMARY KEY (transaction_id),
    CONSTRAINT chk_sales_quantity       CHECK (quantity > 0),
    CONSTRAINT chk_sales_price_per_unit CHECK (price_per_unit > 0),
    CONSTRAINT chk_sales_total_spent    CHECK (total_spent > 0)

);