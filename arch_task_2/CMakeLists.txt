cmake_minimum_required(VERSION 3.0)
project(messenger_service)

set(CMAKE_CXX_STANDARD 17)

# Включаем директории с заголовочными файлами
include_directories(/usr/local/include)

# Ищем необходимые библиотеки
find_package(Poco REQUIRED COMPONENTS Foundation Data Net JSON Util Crypto)
find_package(PostgreSQL REQUIRED)

# Добавляем директории с заголовочными файлами для Poco и PostgreSQL
include_directories(${Poco_INCLUDE_DIRS} ${PostgreSQL_INCLUDE_DIRS})

# Добавляем директории с библиотеками для Poco и PostgreSQL
link_directories(/usr/local/lib ${Poco_LIBRARY_DIRS} ${PostgreSQL_LIBRARY_DIRS})

# Добавляем исполняемый файл
add_executable(messenger_service server.cpp)

# Связываем исполняемый файл с необходимыми библиотеками
target_link_libraries(messenger_service
    ${Poco_LIBRARIES}
    ${PostgreSQL_LIBRARIES}
    PocoFoundation
    PocoData
    PocoDataPostgreSQL
    PocoNet
    PocoJSON
    PocoUtil
    PocoCrypto
)