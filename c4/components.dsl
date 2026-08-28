workspace "UltraDelivery" "Diagrama de componentes - Servicio de Ingesta de Telemetría" {

    model {
        repartidor = person "Repartidor" "Emite ubicación GPS en tiempo real"

        ultraDelivery = softwareSystem "UltraDelivery" "Plataforma de logística de delivery" {

            apiGateway = container "API Gateway" "Enruta las peticiones a los microservicios" "Kong / NGINX"
            broker = container "Message Broker" "Almacena en buffer los eventos de telemetría" "Kafka"
            baseEspacial = container "Base de Datos Espacial" "Almacena e indexa ubicaciones geográficas" "PostgreSQL + PostGIS"
            cacheGeo = container "Cache Geoespacial" "Últimas posiciones conocidas" "Redis"

            servicioIngesta = container "Servicio de Ingesta de Telemetría" "Recibe y procesa los pings GPS" "Node.js / Go" {
                receptorPings = component "Receptor de Pings GPS" "Recibe las conexiones y valida el formato de los pings entrantes" "REST/WebSocket Handler"
                validador = component "Validador de Telemetría" "Valida integridad y autenticidad de los datos GPS recibidos" "Middleware"
                controladorBackpressure = component "Controlador de Backpressure" "Regula el flujo de ingesta para evitar la saturación del buffer, aplicando límites y colas de espera" "Rate Limiter"
                publicadorEventos = component "Publicador de Eventos" "Publica los pings validados como eventos hacia el Message Broker" "Kafka Producer"
                indexadorEspacial = component "Indexador Espacial" "Calcula el geohash/celda espacial de cada ubicación antes de persistir" "Geo Processor"
                monitorSaturacion = component "Monitor de Saturación" "Supervisa el nivel de ocupación del buffer y genera alertas o activa degradación controlada" "Health Monitor"
            }
        }

        repartidor -> apiGateway "Envía ping GPS" "HTTPS/WebSocket"
        apiGateway -> receptorPings "Enruta ping GPS"

        receptorPings -> validador "Envía ping para validación"
        validador -> controladorBackpressure "Solicita permiso de ingesta"
        controladorBackpressure -> monitorSaturacion "Consulta nivel de saturación del buffer"
        controladorBackpressure -> indexadorEspacial "Envía ping aceptado"
        indexadorEspacial -> publicadorEventos "Envía ping con índice espacial calculado"
        publicadorEventos -> broker "Publica evento de telemetría" "Kafka Protocol"

        monitorSaturacion -> cacheGeo "Consulta métricas de carga reciente"
        indexadorEspacial -> baseEspacial "Consulta esquema de indexación" "SQL (opcional, batch)"
    }

    views {
        component servicioIngesta {
            include *
            autoLayout
        }
    }

}
