# ADR 0001: Elección de arquitectura base para EduUCloud

## Estado
Aceptado

## Contexto
EduUCloud es una plataforma educativa en la nube que necesita soportar múltiples 
usuarios concurrentes (estudiantes y administradores), ser escalable y fácil de 
mantener por el equipo de desarrollo.

## Decisión
Se decide adoptar una arquitectura de tres capas: aplicación web (frontend), 
API (backend) y base de datos, siguiendo el modelo C4 para su documentación.
Esto permite separar responsabilidades y escalar cada componente de forma independiente.

## Consecuencias
**Positivas:**
- Separación clara de responsabilidades.
- Facilita el escalado independiente de cada capa.
- Documentación clara mediante diagramas C4.

**Negativas:**
- Mayor complejidad inicial de despliegue al tener múltiples componentes.
- Requiere coordinación entre equipos si el proyecto crece.
