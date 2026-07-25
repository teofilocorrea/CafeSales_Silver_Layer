# Data Quality Report — CafeSales

## Propósito
Este reporte documenta el diagnóstico de calidad realizado sobre
`bronze.sales` (10,000 registros) antes de la limpieza en la capa
Silver. Cuantifica cada tipo de problema por columna para guiar las
decisiones de limpieza y diseño.

---

## Metodología
Se ejecutaron cuatro diagnósticos independientes sobre cada una de
las 8 columnas, contando:

- Valores `NULL` reales
- Valores de texto `'ERROR'`
- Valores de texto `'UNKNOWN'`
- Campos vacíos o con solo espacios (`TRIM = ''`)

---

## Resultados por columna

| Columna | NULL | ERROR | UNKNOWN | EMPTY | Total problemático |
|---|---|---|---|---|---|
| transaction_id | 0 | 0 | 0 | 0 | 0 |
| item | 333 | 292 | 344 | 0 | 969 |
| quantity | 138 | 170 | 171 | 0 | 479 |
| price_per_unit | 179 | 190 | 164 | 0 | 533 |
| total_spent | 173 | 164 | 165 | 0 | 502 |
| payment_method | 2.579 | 306 | 293 | 0 | 3.178 |
| location | 3.265 | 358 | 338 | 0 | 3.961 |
| transaction_date | 159 | 142 | 159 | 0 | 460 |

---

## Hallazgos clave

### 1. transaction_id no tiene problemas de calidad
Las cuatro validaciones dieron 0. Esto habilita a `transaction_id`
como PRIMARY KEY en la capa Silver.

### 2. No existen campos vacíos
La suciedad se manifiesta como NULL o como texto explícito
(`ERROR`, `UNKNOWN`), no como cadenas vacías. La limpieza se centrará
en `NULLIF` y `CASE`, no en `TRIM`.

### 3. location y payment_method son las columnas más afectadas
Concentran la mayor cantidad de valores faltantes, principalmente
como NULL (3.265 y 2.579 respectivamente). Un porcentaje relevante
de transacciones no registra ubicación ni método de pago.

---

## Decisiones de limpieza derivadas

| Problema | Decisión |
|---|---|
| `ERROR`, `UNKNOWN`, NULL | Convertir todo a NULL explícito |
| Registros muy incompletos | Marcar con `record_status`, no eliminar |
| transaction_id | Usar como PRIMARY KEY (está limpio) |
| Conversión de tipos | Limpiar a NULL primero, luego CAST |

---

## Implicación para la gestión del proyecto

De 10,000 registros, ninguno se descarta: los problemas se hacen
explícitos (NULL) y trazables (`record_status`). Esto permite reportar
con precisión cuántos registros son plenamente utilizables y cuántos
requieren tratamiento, en lugar de perder datos de forma silenciosa.

Las columnas `location` y `payment_method`, al concentrar la mayoría
de los faltantes, son las que más impactan la completitud de cualquier
análisis posterior y deben señalarse a los interesados.