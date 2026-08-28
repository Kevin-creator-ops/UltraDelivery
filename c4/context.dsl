workspace "UltraDelivery" "Diagrama de Contexto - UltraDelivery" {

    model {

        repartidor = person "Repartidor" {
            description "Persona encargada de realizar las entregas y enviar continuamente su ubicación GPS."
        }

        cliente = person "Cliente" {
            description "Usuario que realiza pedidos y consulta el estado y ubicación de su entrega."
        }

        operador = person "Operador Logístico" {
            description "Personal encargado de supervisar repartidores, pedidos y operaciones logísticas."
        }

        ultradelivery = softwareSystem "UltraDelivery" {
            description "Sistema de logística y tracking en tiempo real que recibe telemetría GPS, gestiona pedidos, asigna repartidores y proporciona información de ubicación."
        }

        repartidor -> ultradelivery "Envía ubicación GPS y recibe información de sus entregas"

        cliente -> ultradelivery "Realiza pedidos y consulta el estado y ubicación de su entrega"

        operador -> ultradelivery "Gestiona pedidos, repartidores y operaciones logísticas"

    }

    views {

        systemContext ultradelivery "UltraDelivery-Context" {
            include *
            autolayout lr

            title "UltraDelivery - Diagrama de Contexto"

            description "Diagrama C4 Nivel 1 que muestra el sistema UltraDelivery y sus principales actores externos."
        }

        styles {

            element "Person" {
                shape person
            }

            element "Software System" {
                shape roundedbox
            }
        }
    }
}
