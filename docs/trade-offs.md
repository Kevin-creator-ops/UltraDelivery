# Trade-offs — UltraDelivery

## ¿Qué atributos de calidad se reflejan en este nivel?
- **Escalabilidad**: pipeline de ingesta desacoplado (Kafka) y escalado horizontal automático (Kubernetes HPA).
- **Desempeño**: uso de caché en memoria (Redis Geo) para consultas de baja latencia.
- **Disponibilidad**: backpressure y degradación controlada para evitar caídas totales.
- **Confiabilidad/Resiliencia**: buffer de eventos tolerante a fallos, procesamiento asíncrono.
- **Mantenibilidad**: arquitectura de microservicios con responsabilidades claramente separadas.

## Trade-offs identificados en los ADRs
1. **Consistencia vs. Desempeño (ADR 003):** usar Redis como caché de posición implica que los datos pueden estar ligeramente desactualizados (consistencia eventual) a cambio de latencia mínima en las consultas.
2. **Latencia vs. Resiliencia (ADR 001):** procesar los pings de forma asíncrona vía Kafka añade latencia frente a una escritura directa, pero evita la pérdida de datos y la saturación del sistema.
3. **Costo vs. Elasticidad (ADR 004):** el autoescalado reduce costos en horas valle, pero el tiempo de arranque de nuevas instancias puede no ser suficientemente rápido ante picos muy súbitos.
4. **Precisión vs. Disponibilidad (ADR 005):** ante saturación extrema, se sacrifica la frecuencia/precisión de las actualizaciones de ubicación para mantener el servicio disponible, en lugar de rechazar conexiones.
