cmake_minimum_required(VERSION 3.0)
project(messenger_service)

set(CMAKE_CXX_STANDARD 17)

# Включаем директории с заголовочными файлами
include_directories(/usr/local/include)

# Ищем необходимые библиотеки
find_package(Poco REQUIRED COMPONENTS Foundation Net JSON Util Crypto MongoDB)

# Добавляем директории с заголовочными файлами для Poco
include_directories(${Poco_INCLUDE_DIRS})

# Добавляем директории с библиотеками для Poco
link_directories(/usr/local/lib ${Poco_LIBRARY_DIRS})

# Добавляем исполняемый файл
add_executable(messenger_service server.cpp)

# Связываем исполняемый файл с необходимыми библиотеками
target_link_libraries(messenger_service
    ${Poco_LIBRARIES}
    PocoFoundation
    PocoNet
    PocoJSON
    PocoUtil
    PocoCrypto
    PocoMongoDB
)