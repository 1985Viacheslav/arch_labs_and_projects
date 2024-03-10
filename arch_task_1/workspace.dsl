workspace {
    name "Мессенджер"
    description "Система обмена сообщениями с поддержкой групповых и PtP чатов"

    # Включаем режим с иерархической системой идентификаторов
    !identifiers hierarchical

    !docs documentation
    !adrs decisions
    # Модель архитектуры
    model {

        # Настраиваем возможность создания вложенных групп
        properties { 
            structurizr.groupSeparator "/"
        }

        # Описание компонент модели
        user = person "Пользователь"
        messenger = softwareSystem "Мессенджер" {
            description "Система мгновенного обмена сообщениями"

            user_service = container "User Service" {
                description "Сервис для управления пользователями"
            }

            chat_service = container "Chat Service" {
                description "Сервис для управления чатами и сообщениями"
            }

            group "Слой данных" {
                user_database = container "User Database" {
                    description "База данных пользователей"
                    technology "PostgreSQL"
                    tags "database"
                }

                chat_database = container "Chat Database" {
                    description "База данных для хранения информации о чатах и сообщениях"
                    technology "MongoDB"
                    tags "database"
                }
            }

            user_service -> user_database "Получение/обновление данных о пользователях" "TCP 5432"
            chat_service -> user_service "Получение данных о пользователях" "REST HTTP"
            chat_service -> chat_database "Получение/обновление данных о чатах и сообщениях" "TCP 27017"

            user -> user_service "Регистрация/поиск пользователей" "REST HTTP"
            user -> chat_service "Управление чатами и сообщениями" "REST HTTP"
        }

        deploymentEnvironment "Production" {
            deploymentNode "User Server" {
                containerInstance messenger.user_service
            }

            deploymentNode "Chat Server" {
                containerInstance messenger.chat_service
            }

            deploymentNode "databases" {
                deploymentNode "User Database Server" {
                    containerInstance messenger.user_database
                }

                deploymentNode "Chat Database Server" {
                    containerInstance messenger.chat_database
                }
            }
        }
    }

    views {
        themes default

        properties { 
            structurizr.tooltips true
        }

        !script groovy {
            workspace.views.createDefaultViews()
            workspace.views.views.findAll { it instanceof com.structurizr.view.ModelView }.each { it.enableAutomaticLayout() }
        }

        dynamic messenger "UC01" "Создание нового пользователя" {
            autoLayout
            user -> messenger.user_service "Создать нового пользователя (POST /user)"
            messenger.user_service -> messenger.user_database "Сохранить данные о пользователе"
        }

        dynamic messenger "UC02" "Поиск пользователя по логину" {
            autoLayout
            user -> messenger.user_service "Поиск пользователя (GET /users/login)"
        }

        dynamic messenger "UC03" "Поиск пользователя по маске имени и фамилии" {
            autoLayout
            user -> messenger.user_service "Поиск пользователя (GET /users/name)"
        }

        dynamic messenger "UC04" "Создание группового чата" {
            autoLayout
            user -> messenger.chat_service "Создать групповой чат (POST /chat/group)"
        }

        dynamic messenger "UC05" "Добавление пользователя в чат" {
            autoLayout
            user -> messenger.chat_service "Добавить пользователя в чат (POST /chat/group/add)"
        }

        dynamic messenger "UC06" "Добавление сообщения в групповой чат" {
            autoLayout
            user -> messenger.chat_service "Добавить сообщение (POST /chat/group/message)"
        }

        dynamic messenger "UC07" "Загрузка сообщений группового чата" {
            autoLayout
            user -> messenger.chat_service "Загрузить сообщения (GET /chat/group/messages)"
        }

        dynamic messenger "UC08" "Отправка PtP сообщения пользователю" {
            autoLayout
            user -> messenger.chat_service "Отправить PtP сообщение (POST /chat/ptp)"
        }

        dynamic messenger "UC09" "Получение PtP списка сообщений для пользователя" {
            autoLayout
            user -> messenger.chat_service "Получить PtP сообщения (GET /chat/ptp/messages)"
        }

        styles {
            element "database" {
                shape cylinder
            }
        }
    }
}
