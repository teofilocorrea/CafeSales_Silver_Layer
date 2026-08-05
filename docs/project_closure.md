# Project Closure — CafeSales Silver Layer

## 📋 Información del proyecto

| Campo | Detalle |
|---|---|
| **Proyecto** | CafeSales Silver Layer |
| **Fase** | 4 de 5 — Capa Silver |
| **Autor** | Teófilo Correa Rojas |
| **Fecha inicio** | Julio 2026 |
| **Fecha cierre** | Julio 2026 |
| **Estado** | ✅ Completado |

---

## 🎯 Objetivos — ¿Se cumplieron?

| Objetivo | Estado |
|---|---|
| Diagnosticar los problemas de calidad de Bronze | ✅ Completado |
| Diseñar la tabla limpia con tipos y constraints | ✅ Completado |
| Limpiar valores sucios (ERROR/UNKNOWN → NULL) | ✅ Completado |
| Convertir tipos de texto a número/fecha | ✅ Completado |
| Marcar registros incompletos con record_status | ✅ Completado |
| Validar la calidad final de los datos | ✅ Completado |

---

## 🧱 Lo que se construyó

### Tabla creada

| Tabla | Campos | Registros |
|---|---|---|
| `silver.sales` | 9 (8 negocio + record_status) | 10,000 |

### Las tres transformaciones del ETL

| Transformación | Técnica | Campos |
|---|---|---|
| Limpieza de texto | `CASE` | item, payment_method, location |
| Conversión de tipos | `CASE` + `CAST` | quantity, price_per_unit, total_spent, transaction_date |
| Marcado de registros | `CASE` | record_status (active/incomplete) |

### Scripts creados

| Carpeta | Scripts |
|---|---|
| `diagnosis/` | Conteo de NULL, ERROR, UNKNOWN, EMPTY |
| `create_tables/` | Creación de silver.sales |
| `cleaning/` | Limpieza texto, CAST numéricos, record_status, INSERT final |
| `validation/` | Conteo, comparación Bronze vs Silver, distribución record_status |

---

## 📊 Resultados de la limpieza — comparación Bronze vs Silver

La validación clave del proyecto: comparar los valores sucios de Bronze
contra los NULL resultantes en Silver. Los conteos coinciden exactamente,
lo que demuestra que ningún dato se perdió ni se inventó en el ETL.

| Campo | Sucios en Bronze | NULL en Silver | ¿Coincide? |
|---|---|---|---|
| item | 969 | 969 | ✅ |
| quantity | 479 | 479 | ✅ |
| price_per_unit | 533 | 533 | ✅ |
| total_spent | 502 | 502 | ✅ |
| payment_method | 3,178 | 3,178 | ✅ |
| location | 3,961 | 3,961 | ✅ |
| transaction_date | 460 | 460 | ✅ |

### Distribución de record_status

| Estado | Registros | Criterio |
|---|---|---|
| `active` | (completar: ~9,498) | Con monto válido (total_spent) |
| `incomplete` | (completar: 502) | Sin monto — coincide con los NULL de total_spent |

| Métrica | Resultado |
|---|---|
| Registros procesados | 10,000 |
| Registros cargados en Silver | 10,000 |
| Pérdida de registros | 0 |

---

## 📚 Lo que aprendí en esta fase

| Concepto | Descripción |
|---|---|
| `CASE` | Limpiar valores condicionalmente (ERROR/UNKNOWN → NULL) |
| `CAST` | Convertir texto a INTEGER/NUMERIC/DATE |
| Orden CASE → CAST | Limpiar primero (adentro), convertir después (afuera) |
| `FILTER` | Contar condiciones distintas en una sola consulta |
| `GROUP BY` + `HAVING` | Detectar duplicados para validar PRIMARY KEY |
| ETL en vuelo | Transformar durante el INSERT, no después |
| Emparejamiento por posición | INSERT y SELECT se conectan por orden, no por nombre |
| `record_status` | Marcar registros en vez de eliminarlos |

### Decisiones técnicas importantes

- La limpieza ocurre "en vuelo": el dato sucio nunca toca Silver
- Solo `transaction_id` es NOT NULL (validado sin duplicados ni nulos)
- Los CHECK conviven con NULL: rechazan inválidos, no faltantes
- Los registros sin monto se marcan `incomplete`, no se eliminan
- Bronze permanece intacto como respaldo del dato original

---

## 🔑 Lección más importante

```
El orden CASE → CAST no es negociable:

CAST('ERROR' AS INTEGER) → falla ❌
CASE limpia → CAST(NULL AS INTEGER) → NULL ✅

Primero se limpia lo que rompería la conversión,
luego se convierte con seguridad.
```

---

## 💼 Qué significa para la gestión de proyectos

```
La comparación Bronze vs Silver demuestra algo más
que una limpieza correcta: demuestra TRAZABILIDAD.

Poder decir "los 502 valores faltantes de total_spent
en el origen son exactamente los 502 NULL del destino"
es lo que hace auditable un proceso de datos.

Saber cuánto cuesta esta limpieza permite juzgar si el
estimado de un equipo técnico es realista o inflado.

Y marcar en vez de borrar permite reportar con honestidad:
"de 10,000 transacciones, ~9,498 son plenamente utilizables
y 502 quedaron marcadas para revisión" — sin perder datos
en silencio.
```

---

## 🔜 Próximas fases

| Fase | Proyecto | Enfoque |
|---|---|---|
| 1 | CafeSales_Database_Infrastructure | Infraestructura ✅ |
| 2 | CafeSales_STG_Layer | Datos crudos ✅ |
| 3 | CafeSales_Bronze_Layer | Auditoría ✅ |
| 4 | CafeSales_Silver_Layer | Limpieza + análisis exploratorio ✅ |
| 5 | CafeSales_Gold_Layer | Modelo dimensional + análisis de negocio |

---

## 👤 Autor

### Teófilo Correa Rojas

**Project Manager TI | Data Analytic**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)