workspace "UltraDelivery" "Arquitectura de UltraDelivery - Logística" {

    model {

        repartidor = person "Repartidor" {
            description "Usuario que envía su ubicación GPS y recibe notificaciones."
        }

        cliente = person "Cliente" {
            description "Usuario que consulta la ubicación y estado de sus pedidos."
        }

        operador = person "Operador Logístico" {
            description "Usuario encargado de gestionar pedidos y operaciones logísticas."
        }

        ultradelivery = softwareSystem "UltraDelivery" {

            gateway = container "API Gateway" {
                description "Recibe las conexiones de repartidores, clientes y operadores y distribuye las solicitudes."
                technology "API Gateway / Load Balancer"
            }

            ingestion = container "Servicio de Ingesta de Telemetría" {
                description "Recibe y valida hasta 150.000 pings GPS por segundo y permite escalamiento horizontal."
                technology "Servicio escalable"
            }

            buffer = container "Buffer de Telemetría" {
                description "Almacena temporalmente los eventos GPS para absorber picos de carga y aplicar backpressure."
                technology "Apache Kafka"
            }

            processor = container "Procesador de Telemetría" {
                description "Procesa los eventos GPS en tiempo real y los entrega al servicio de indexación espacial."
                technology "Streaming Processor"
            }

            spatial = container "Servicio de Indexación Espacial" {
                description "Actualiza la posición de los repartidores y realiza consultas espaciales de baja latencia."
                technology "Servicio de geolocalización"
            }

            cache = container "Cache de Ubicaciones" {
                description "Mantiene en memoria la última ubicación conocida de cada repartidor."
                technology "Redis"
            }

            geoDb = container "Base de Datos Geoespacial" {
                description "Almacena las posiciones e información espacial de los repartidores."
                technology "PostgreSQL + PostGIS"
            }

            orders = container "Servicio de Asignación de Pedidos" {
                description "Gestiona pedidos y asigna repartidores disponibles."
                technology "Servicio independiente"
            }

            notifications = container "Servicio de Notificaciones" {
                description "Envía actualizaciones de pedidos y eventos de tracking."
                technology "Push / WebSocket"
            }

            database = container "Base de Datos Operacional" {
                description "Almacena pedidos, usuarios, repartidores y estados operativos."
                technology "PostgreSQL"
            }
        }

        repartidor -> gateway "Envía telemetría GPS y recibe notificaciones"
        cliente -> gateway "Consulta ubicación y estado del pedido"
        operador -> gateway "Gestiona pedidos y operaciones logísticas"

        gateway -> ingestion "Envía pings GPS"
        gateway -> orders "Solicita operaciones de pedidos"
        gateway -> cache "Consulta ubicación actual"

        ingestion -> buffer "Publica eventos GPS"
        buffer -> processor "Entrega eventos GPS"

        processor -> spatial "Envía posiciones procesadas"

        spatial -> cache "Actualiza última ubicación"
        spatial -> geoDb "Indexa posiciones espacialmente"

        cache -> gateway "Retorna ubicación actual"

        orders -> database "Lee y actualiza pedidos"
        orders -> cache "Consulta repartidores disponibles"
        orders -> notifications "Genera eventos de asignación"

        notifications -> repartidor "Envía notificaciones"
        notifications -> cliente "Envía actualizaciones del pedido"
    }

    views {

        container ultradelivery "UltraDelivery-Containers" {
            include *
            autolayout lr

            title "UltraDelivery - Diagrama de Contenedores"

            description "Diagrama C4 Nivel 2 de la arquitectura de UltraDelivery."
        }

        styles {

            element "Person" {
                shape person
            }

            element "Container" {
                shape roundedbox
            }

            element "Database" {
                shape cylinder
            }
        }
    }
}
