workspace "UltraDelivery" "Diagrama de contexto - Plataforma de logística de delivery" {

    model {
        cliente = person "Cliente" "Realiza pedidos y hace seguimiento en tiempo real"
        repartidor = person "Repartidor" "Entrega pedidos y emite telemetría GPS en tiempo real"
        operador = person "Operador Logístico" "Supervisa la operación y gestiona incidencias"

        ultraDelivery = softwareSystem "UltraDelivery" "Plataforma de logística que gestiona pedidos, tracking GPS en tiempo real y asignación de repartidores"

        cliente -> ultraDelivery "Realiza pedidos y consulta ubicación del repartidor"
        repartidor -> ultraDelivery "Envía ubicación GPS (pings) y recibe pedidos asignados"
        operador -> ultraDelivery "Monitorea operación y gestiona alertas"
    }

    views {
        systemContext ultraDelivery {
            include *
            autoLayout
        }
    }

}
