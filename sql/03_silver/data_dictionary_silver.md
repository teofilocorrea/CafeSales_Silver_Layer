# Diccionario de Datos — Silver Layer

## Propósito de la capa
La capa Silver contiene los datos **limpios y validados**. Los valores
sucios detectados en el diagnóstico (`ERROR`, `UNKNOWN`, nulos) se
convierten a NULL explícito, los tipos de texto se transforman a sus
tipos reales (INTEGER, NUMERIC, DATE) y se aplican constraints de
integridad.

## Reglas clave de esta capa
- Los valores sucios se convierten a NULL explícito (no se inventan datos)
- Cada campo recibe su tipo de dato definitivo
- `transaction_id` es PRIMARY KEY (validado sin nulos ni duplicados)
- Los campos numéricos llevan CHECK para rechazar valores no positivos
- Los CHECK permiten NULL: rechazan valores inválidos, no faltantes

---

## Tabla: silver.sales

### Descripción
Almacena las transacciones de venta de la cafetería, ya limpias y
tipadas. Cada registro representa una transacción individual.

### Campos

| Campo | Tipo | Constraint | ¿Qué guarda? |
|---|---|---|---|
| `transaction_id` | VARCHAR(50) | PRIMARY KEY | Identificador único de la transacción |
| `item` | VARCHAR(100) | — (permite NULL) | Nombre del producto comprado |
| `quantity` | INTEGER | CHECK > 0 | Cantidad de unidades compradas |
| `price_per_unit` | NUMERIC(10,2) | CHECK > 0 | Precio de una unidad |
| `total_spent` | NUMERIC(10,2) | CHECK > 0 | Monto total de la transacción |
| `payment_method` | VARCHAR(50) | — (permite NULL) | Método de pago utilizado |
| `location` | VARCHAR(50) | — (permite NULL) | Ubicación de la venta |
| `transaction_date` | DATE | — (permite NULL) | Fecha de la transacción |

---

## Constraints

| Constraint | Tipo | Campo | Regla |
|---|---|---|---|
| `pk_sales` | PRIMARY KEY | transaction_id | Único y no nulo |
| `chk_sales_quantity` | CHECK | quantity | quantity > 0 |
| `chk_sales_price_per_unit` | CHECK | price_per_unit | price_per_unit > 0 |
| `chk_sales_total_spent` | CHECK | total_spent | total_spent > 0 |

---

## Transformación de tipos (Bronze → Silver)

| Campo | Tipo en Bronze | Tipo en Silver |
|---|---|---|
| `transaction_id` | TEXT | VARCHAR(50) |
| `item` | TEXT | VARCHAR(100) |
| `quantity` | TEXT | INTEGER |
| `price_per_unit` | TEXT | NUMERIC(10,2) |
| `total_spent` | TEXT | NUMERIC(10,2) |
| `payment_method` | TEXT | VARCHAR(50) |
| `location` | TEXT | VARCHAR(50) |
| `transaction_date` | TEXT | DATE |

---

## Por qué solo transaction_id es NOT NULL

El diagnóstico de calidad determinó qué campos podían llevar
restricciones estrictas:

| Campo | Resultado del diagnóstico | Decisión |
|---|---|---|
| `transaction_id` | 0 problemas, 0 duplicados | PRIMARY KEY (NOT NULL implícito) |
| Resto de campos | Contienen valores sucios → NULL | Permiten NULL |

Forzar NOT NULL en un campo con datos sucios convertidos a NULL
provocaría el rechazo de esos registros. Como la decisión del proyecto
es preservar los registros y marcarlos, los campos deben permitir NULL.

---

## Convivencia de CHECK y NULL

Los CHECK de campos numéricos rechazan valores no positivos, pero
permiten NULL, porque un CHECK solo evalúa valores que existen:

```
CHECK (quantity > 0)

quantity = 5 → cumple ✅
quantity = -2 → rechazado ❌
quantity = NULL → permitido ✅ (CHECK no evalúa NULL)
```
Esto permite que la tabla sea estricta con los valores inválidos y a
la vez tolerante con los faltantes.

---

## Convención de nombres para constraints

| Tipo | Prefijo | Ejemplo |
|---|---|---|
| PRIMARY KEY | `pk_` | `pk_sales` |
| CHECK | `chk_` | `chk_sales_quantity` |