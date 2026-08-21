# Requisitos No Funcionales (NFRs) - EduUCloud

## 1. Disponibilidad
El sistema debe estar disponible al menos el 99.5% del tiempo mensual, 
permitiendo mantenimientos programados fuera de horario de mayor uso.

## 2. Rendimiento
- Las peticiones a la API deben responder en menos de 300ms bajo condiciones normales de carga.
- La carga inicial de la aplicación web no debe superar los 3 segundos.

## 3. Escalabilidad
El sistema debe soportar al menos 1,000 usuarios concurrentes sin degradación 
significativa del rendimiento, con posibilidad de escalar horizontalmente 
el backend y la base de datos.

## 4. Seguridad
- Autenticación mediante OAuth2 / JWT.
- Contraseñas almacenadas con hash seguro (bcrypt o similar).
- Comunicación cifrada mediante HTTPS en todos los endpoints.
- Control de acceso basado en roles (estudiante, profesor, administrador).

## 5. Usabilidad
La interfaz debe ser accesible y responsive, funcionando correctamente 
en dispositivos móviles y de escritorio, siguiendo pautas básicas de 
accesibilidad (WCAG 2.1 nivel AA).

## 6. Mantenibilidad
El código debe seguir estándares de estilo definidos por el equipo y 
contar con documentación técnica actualizada (incluyendo diagramas C4 y ADRs).

## 7. Portabilidad
El sistema debe poder desplegarse en distintos entornos en la nube 
(contenedores Docker) sin dependencias específicas de un único proveedor.
