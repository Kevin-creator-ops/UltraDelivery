# Requisitos No Funcionales (NFRs) - UltraDelivery

| # | NFR | Requisito no funcional |
|---|-----|------------------------|
| NFR-01 | Escalabilidad | El sistema debe soportar picos de hasta 150,000 pings/seg de GPS y 80,000 conexiones simultáneas de repartidores, permitiendo escalar horizontalmente el pipeline de ingesta sin degradar el servicio. |
| NFR-02 | Desempeño | El sistema debe procesar e indexar espacialmente la ubicación de los repartidores en menos de 500 ms, garantizando que las consultas de ubicación reflejen la posición actual con mínima latencia. |
| NFR-03 | Disponibilidad | El sistema debe mantener una disponibilidad mínima del 99,9 % mensual, tolerando fallos parciales del pipeline de ingesta sin interrumpir el servicio de tracking en tiempo real. |
| NFR-04 | Confiabilidad / Resiliencia | El sistema debe evitar la pérdida de datos de telemetría ante picos de carga, mediante mecanismos de buffering, backpressure y degradación controlada que prevengan la saturación del buffer de ingesta. |
| NFR-05 | Mantenibilidad | El sistema debe estar organizado en componentes modulares e independientes (ingesta, indexación espacial, asignación de pedidos, notificaciones), facilitando el mantenimiento y la incorporación de nuevas funcionalidades. |
