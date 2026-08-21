workspace "EduUCloud" "Diagrama de contexto del sistema" {

    model {
        estudiante = person "Estudiante" "Usuario que accede a la plataforma educativa"
        admin = person "Administrador" "Gestiona la plataforma"
        eduUCloud = softwareSystem "EduUCloud" "Plataforma educativa en la nube"

        estudiante -> eduUCloud "Usa"
        admin -> eduUCloud "Administra"
    }

    views {
        systemContext eduUCloud {
            include *
            autoLayout
        }
    }

}
