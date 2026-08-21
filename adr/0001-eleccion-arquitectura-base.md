# ADR 0001: Uso de WebRTC con arquitectura SFU para streaming

## Estado
Aceptado

## Contexto
EduCloud debe soportar hasta 50,000 conexiones simultáneas de video y mantener 
una latencia inferior a 300 ms durante las clases en vivo. Una arquitectura 
tradicional basada únicamente en servidores de streaming centralizados podría 
generar problemas de escalabilidad y latencia ante picos de hasta 200,000 
usuarios simultáneos.

## Decisión
Se utilizará WebRTC con arquitectura SFU (Selective Forwarding Unit) para 
gestionar las clases en vivo. Los clientes enviarán sus flujos multimedia al 
servidor SFU, el cual distribuirá los streams a los participantes sin necesidad 
de recomponer el video completo. La infraestructura SFU podrá escalar 
horizontalmente mediante múltiples instancias y balanceadores de carga.

## Consecuencias

**Positivas:**
- Menor uso de CPU y ancho de banda en el servidor comparado con un modelo MCU 
  (Multipoint Control Unit), ya que no se recodifica el video.
- Permite escalar horizontalmente agregando más instancias SFU según la demanda.
- Latencia baja al reenviar los streams directamente sin procesamiento pesado.

**Negativas:**
- Mayor consumo de ancho de banda en el cliente si hay muchos participantes 
  en la misma sesión (cada uno recibe múltiples streams).
- Requiere un mecanismo de balanceo y descubrimiento de instancias SFU 
  disponibles (mayor complejidad operativa).
- Necesita monitoreo constante para detectar degradación de calidad de video 
  bajo carga alta.

## Relación con NFRs
Este ADR responde directamente a **NFR-01 (Escalabilidad)** y **NFR-04 (Desempeño)**.
