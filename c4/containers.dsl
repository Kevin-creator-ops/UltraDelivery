workspace "EduUCloud" "Diagrama de contenedores del sistema" {

    model {
        estudiante = person "Estudiante" "Usuario que accede a la plataforma educativa"
        admin = person "Administrador" "Gestiona la plataforma"

        eduUCloud = softwareSystem "EduUCloud" "Plataforma educativa en la nube" {
            webApp = container "Aplicación Web" "Interfaz de usuario" "React"
            api = container "API" "Expone la lógica de negocio" "Node.js / Spring Boot"
            baseDatos = container "Base de Datos" "Almacena usuarios, cursos y contenidos" "PostgreSQL"
        }

        estudiante -> webApp "Usa" "HTTPS"
        admin -> webApp "Administra" "HTTPS"
        webApp -> api "Hace peticiones" "JSON/HTTPS"
        api -> baseDatos "Lee y escribe" "SQL"
    }

    views {
        container eduUCloud {
            include *
            autoLayout
        }
    }

}
