workspace "UltraDelivery" "Diagrama de contenedores - Plataforma de logística de delivery" {

    model {
        cliente = person "Cliente" "Realiza pedidos y hace seguimiento en tiempo real"
        repartidor = person "Repartidor" "Entrega pedidos y emite telemetría GPS en tiempo real"
        operador = person "Operador Logístico" "Supervisa la operación y gestiona incidencias"

        ultraDelivery = softwareSystem "UltraDelivery" "Plataforma de logística de delivery" {
            appCliente = container "App Cliente" "Permite realizar pedidos y ver tracking en tiempo real" "React Native"
            appRepartidor = container "App Repartidor" "Envía la ubicación GPS y recibe pedidos asignados" "React Native / Kotlin"
            apiGateway = container "API Gateway" "Enruta las peticiones a los microservicios" "Kong / NGINX"

            servicioIngesta = container "Servicio de Ingesta de Telemetría" "Recibe y procesa los pings GPS de los repartidores" "Node.js / Go"
            broker = container "Message Broker" "Almacena en buffer los eventos de telemetría para desacoplar ingesta y procesamiento" "Kafka"
            procesadorStream = container "Procesador de Streaming" "Consume eventos del broker y actualiza posiciones" "Kafka Streams / Flink"

            servicioAsignacion = container "Servicio de Asignación" "Asigna pedidos a repartidores disponibles según ubicación" "Java / Spring Boot"
            servicioPedidos = container "Servicio de Pedidos" "Gestiona el ciclo de vida de los pedidos" "Node.js"
            servicioNotificaciones = container "Servicio de Notificaciones" "Envía notificaciones push a clientes y repartidores" "Node.js"

            baseEspacial = container "Base de Datos Espacial" "Almacena e indexa las ubicaciones geográficas para consultas rápidas" "PostgreSQL + PostGIS"
            baseOperacional = container "Base de Datos Operacional" "Almacena pedidos, usuarios y repartidores" "PostgreSQL"
            cacheGeo = container "Cache Geoespacial" "Almacena las últimas posiciones conocidas para consultas de baja latencia" "Redis (Redis Geo)"
        }

        cliente -> appCliente "Usa" "HTTPS"
        repartidor -> appRepartidor "Usa" "HTTPS"
        operador -> apiGateway "Consulta métricas y alertas" "HTTPS"

        appCliente -> apiGateway "Realiza peticiones" "HTTPS/JSON"
        appRepartidor -> apiGateway "Envía pings GPS y consulta pedidos" "HTTPS/JSON"

        apiGateway -> servicioIngesta "Enruta telemetría GPS"
        apiGateway -> servicioPedidos "Enruta gestión de pedidos"
        apiGateway -> servicioAsignacion "Enruta solicitudes de asignación"

        servicioIngesta -> broker "Publica eventos de ubicación" "Kafka Protocol"
        broker -> procesadorStream "Consume eventos" "Kafka Protocol"
        procesadorStream -> baseEspacial "Indexa ubicaciones" "SQL"
        procesadorStream -> cacheGeo "Actualiza última posición conocida" "Redis Protocol"

        servicioAsignacion -> cacheGeo "Consulta repartidores cercanos" "Redis Protocol"
        servicioAsignacion -> baseOperacional "Lee/escribe asignaciones" "SQL"
        servicioPedidos -> baseOperacional "Lee/escribe pedidos" "SQL"
        servicioAsignacion -> servicioNotificaciones "Notifica asignación de pedido"
        servicioPedidos -> servicioNotificaciones "Notifica estado del pedido"
        servicioNotificaciones -> appCliente "Envía notificación push"
        servicioNotificaciones -> appRepartidor "Envía notificación push"
    }

    views {
        container ultraDelivery {
            include *
            autoLayout
        }
    }

}
