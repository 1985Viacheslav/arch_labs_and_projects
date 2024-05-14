from pymongo import MongoClient

# Подключение к базе данных MongoDB
client = MongoClient('mongodb://root:password@db:27017/')
db = client['messenger_db']

# Создание коллекций
users_collection = db['users']
chats_collection = db['chats']
messages_collection = db['messages']

# Очистка коллекций перед наполнением данными
users_collection.delete_many({})
chats_collection.delete_many({})
messages_collection.delete_many({})

# Добавление тестовых пользователей
users_collection.insert_many([
    {'login': 'user1', 'password_hash': 'hash1', 'first_name': 'John', 'last_name': 'Doe'},
    {'login': 'user2', 'password_hash': 'hash2', 'first_name': 'Jane', 'last_name': 'Smith'},
    {'login': 'user3', 'password_hash': 'hash3', 'first_name': 'Alice', 'last_name': 'Johnson'}
])

# Добавление тестовых чатов
chats_collection.insert_many([
    {'name': 'Group Chat 1', 'is_group_chat': True},
    {'name': 'Private Chat 1', 'is_group_chat': False},
    {'name': 'Private Chat 2', 'is_group_chat': False}
])

# Добавление тестовых сообщений
messages_collection.insert_many([
    {'sender_id': 1, 'chat_id': 1, 'content': 'Hello, group!'},
    {'sender_id': 2, 'chat_id': 1, 'content': 'Hi everyone!'},
    {'sender_id': 1, 'chat_id': 2, 'content': 'Private message 1'},
    {'sender_id': 2, 'chat_id': 2, 'content': 'Private message 2'},
    {'sender_id': 1, 'chat_id': 3, 'content': 'Another private message'},
    {'sender_id': 3, 'chat_id': 3, 'content': 'Last private message'}
])

print("Database initialized with test data.")