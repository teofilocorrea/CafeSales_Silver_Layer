# Silver Layer — CafeSales

## ¿Qué es esta capa?

La capa Silver es el **corazón de la serie de Data Cleaning**. Toma los
datos crudos y sucios de Bronze y los convierte en datos **limpios,
tipados y validados**, listos para el análisis. Es donde ocurre la
transformación real del proyecto.

---

## 📋 Reglas de esta capa

- Los valores sucios (`ERROR`, `UNKNOWN`, nulos) se convierten a **NULL explícito**
- Cada campo recibe su **tipo de dato definitivo** (INTEGER, NUMERIC, DATE)
- `transaction_id` es **PRIMARY KEY** (validado sin nulos ni duplicados)
- Los campos numéricos llevan **CHECK** para rechazar valores no positivos
- Los registros incompletos se **marcan** con `record_status`, no se eliminan
- La limpieza ocurre **en vuelo** (durante el ETL), no dentro de Silver

---

## 🔄 El proceso ETL — limpieza en vuelo

La transformación ocurre en el SELECT que alimenta el INSERT. Los datos
sucios **nunca tocan Silver**: se limpian y convierten en el camino.

```
bronze.sales (sucio, texto)
↓
SELECT con CASE + CAST (transforma en vuelo)
↓
INSERT INTO silver.sales
↓
silver.sales (limpio, tipado)
```

### Las tres transformaciones

| Transformación | Técnica | Campos |
|---|---|---|
| Limpieza de texto | `CASE` | item, payment_method, location |
| Conversión de tipos | `CASE` + `CAST` | quantity, price_per_unit, total_spent, transaction_date |
| Marcado de registros | `CASE` | record_status |

---

## 📊 Tabla

| Tabla | Descripción | Registros |
|---|---|---|
| `silver.sales` | Transacciones limpias y tipadas | 10,000 |

### Campos

| Campo | Tipo | Constraint |
|---|---|---|
| `transaction_id` | VARCHAR(50) | PRIMARY KEY |
| `item` | VARCHAR(100) | permite NULL |
| `quantity` | INTEGER | CHECK > 0 |
| `price_per_unit` | NUMERIC(10,2) | CHECK > 0 |
| `total_spent` | NUMERIC(10,2) | CHECK > 0 |
| `payment_method` | VARCHAR(50) | permite NULL |
| `location` | VARCHAR(50) | permite NULL |
| `transaction_date` | DATE | permite NULL |
| `record_status` | VARCHAR(20) | 'active' / 'incomplete' |

---

## 💡 Decisiones clave

### Por qué la limpieza es "en vuelo"

Como `silver.sales` tiene tipos reales (INTEGER, DATE), no se puede copiar
el dato sucio y limpiarlo después: un `'ERROR'` sería rechazado por una
columna INTEGER. Por eso la transformación ocurre **antes** de que el dato
entre, en el SELECT del ETL.

### Por qué el orden CASE → CAST importa

```
CAST('ERROR' AS INTEGER) → falla ❌
CASE limpia primero → CAST(NULL AS INTEGER) → NULL ✅
```

El `CASE` (limpieza) va **adentro**, el `CAST` (conversión) va **afuera**.

### Por qué se marca en vez de borrar

Los registros sin monto (`total_spent`) se marcan como `'incomplete'` en
lugar de eliminarse. Así ningún dato se pierde de forma silenciosa: los
registros problemáticos quedan identificados y auditables.

---

## 🔍 Estructura de trabajo

```
03_silver/
├── diagnosis/ ← MIDE los problemas (antes de limpiar)
│ ├── 01_count_nulls.sql
│ ├── 02_count_errors.sql
│ ├── 03_count_unknowns.sql
│ └── 04_count_empty.sql
├── create_tables/ ← define la tabla limpia
│ └── 01_create_silver_sales.sql
├── cleaning/ ← TRANSFORMA (con sus ensayos)
│ ├── 01_clean_text_fields.sql
│ ├── 02_cast_numeric_fields.sql
│ ├── 03_mark_record_status.sql
│ └── 04_insert_silver.sql
├── validation/ ← COMPRUEBA el resultado final
│ ├── 01_validate_counts.sql
│ ├── 02_validate_quality.sql
│ └── 03_validate_record_status.sql
├── README.md
└── data_dictionary_silver.md

diagnosis/ → mide problemas
cleaning/ → transforma
validation/ → comprueba resultado
```

---

## 📖 Diccionario de Datos

📄 [data_dictionary_silver.md](data_dictionary_silver.md)

---

## ✅ Resultados de la limpieza

| Métrica | Resultado |
|---|---|
| Registros procesados | 10,000 |
| Registros cargados en Silver | 10,000 |
| Valores sucios convertidos a NULL | (según diagnóstico) |
| Registros marcados `incomplete` | (según validación) |
| Pérdida de registros | 0 |

---

## 🔗 Capas relacionadas

| Capa | Descripción |
|---|---|
| ⬆️ Bronze | Origen — datos crudos con auditoría |
| ➡️ **Silver** | Estás aquí — datos limpios y validados |
| ⬇️ Gold | Modelo dimensional y análisis de negocio |