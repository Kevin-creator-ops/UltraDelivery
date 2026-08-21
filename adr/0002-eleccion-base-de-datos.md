# ADR 0002: Autenticación centralizada mediante OAuth2

## Estado
Aceptado

## Contexto
EduCloud debe garantizar que solo usuarios autenticados accedan a clases en vivo, 
foros y evaluaciones, protegiendo datos académicos y personales conforme a 
regulaciones como GDPR y FERPA. Implementar un sistema de autenticación propio 
implicaría un alto costo de desarrollo y mantenimiento, además de mayor riesgo 
de vulnerabilidades de seguridad.

## Decisión
Se adoptará OAuth2 como protocolo de autenticación, delegando la验证 de identidad 
a proveedores externos confiables (Google, Microsoft). El sistema emitirá tokens 
JWT tras la autenticación exitosa, los cuales serán validados por el API Gateway 
en cada solicitud a los microservicios (foros, evaluaciones, streaming).

## Consecuencias

**Positivas:**
- Se reduce el riesgo de manejar contraseñas directamente, delegando esa 
  responsabilidad a proveedores especializados.
- Mejora la experiencia de usuario al permitir inicio de sesión único (SSO) 
  con cuentas ya existentes (Google/Microsoft).
- Facilita el cumplimiento de estándares de seguridad y regulaciones de 
  protección de datos.

**Negativas:**
- El sistema depende de la disponibilidad de los proveedores externos de 
  identidad (Google/Microsoft); una caída de estos afectaría el acceso.
- Requiere gestión adicional de expiración y renovación de tokens (JWT refresh).
- Implica configurar validación de tokens en cada microservicio o de forma 
  centralizada en el API Gateway.

## Relación con NFRs
Este ADR responde directamente a **NFR-03 (Seguridad)**.
