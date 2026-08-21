# Requisitos No Funcionales (NFRs) - EduCloud

| # | NFR | Requisito no funcional |
|---|-----|------------------------|
| NFR-01 | Escalabilidad | El sistema debe soportar el crecimiento de usuarios y conexiones simultáneas sin afectar significativamente su funcionamiento, permitiendo ampliar horizontalmente los recursos cuando aumente la demanda (hasta 200,000 usuarios concurrentes). |
| NFR-02 | Disponibilidad | El sistema debe mantener una disponibilidad mínima del 99,95 % mensual, permitiendo que los usuarios accedan a las funcionalidades principales incluso ante fallos parciales de infraestructura. |
| NFR-03 | Seguridad | El sistema debe proteger la información de los usuarios y los datos académicos mediante autenticación segura (OAuth2), autorización por roles y cifrado de extremo a extremo de los datos sensibles, cumpliendo con GDPR y FERPA. |
| NFR-04 | Desempeño | El sistema debe responder de manera eficiente ante múltiples usuarios concurrentes, manteniendo una latencia inferior a 300 ms en el streaming de video y tiempos de respuesta inferiores a 2 segundos en las evaluaciones. |
| NFR-05 | Mantenibilidad | El sistema debe estar organizado de forma modular, con componentes (microservicios) independientes y responsabilidades claramente definidas, para facilitar la incorporación de nuevas funcionalidades y el mantenimiento del sistema. |
