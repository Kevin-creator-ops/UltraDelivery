# ADR 0002: Elección de base de datos para EduUCloud

## Estado
Aceptado

## Contexto
La plataforma necesita almacenar información estructurada de usuarios, cursos, 
calificaciones y contenidos educativos, con relaciones claras entre entidades 
(estudiantes, cursos, profesores, evaluaciones).

## Decisión
Se decide utilizar PostgreSQL como sistema de gestión de base de datos, 
por ser un motor relacional robusto, de código abierto, con buen soporte 
para integridad referencial, transacciones ACID y amplia compatibilidad 
con frameworks backend como Node.js y Spring Boot.

## Consecuencias
**Positivas:**
- Integridad de datos garantizada mediante relaciones y restricciones.
- Comunidad amplia y buena documentación.
- Sin costos de licencia.

**Negativas:**
- Requiere gestión de escalabilidad horizontal si el volumen de datos crece mucho.
- Curva de aprendizaje para quienes no tengan experiencia previa con SQL.
