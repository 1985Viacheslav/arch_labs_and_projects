-- Создание таблиц
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  login VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

CREATE TABLE chats (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  is_group_chat BOOLEAN NOT NULL
);

CREATE TABLE user_chats (
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  chat_id INTEGER REFERENCES chats(id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, chat_id)
);

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  sender_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  chat_id INTEGER REFERENCES chats(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Вставка тестовых данных
INSERT INTO users (login, password_hash, first_name, last_name)
VALUES
  ('user1', 'hash1', 'John', 'Doe'),
  ('user2', 'hash2', 'Jane', 'Smith'),
  ('user3', 'hash3', 'Alice', 'Johnson');

INSERT INTO chats (name, is_group_chat)
VALUES
  ('Group Chat 1', true),
  ('Private Chat 1', false),
  ('Private Chat 2', false);

INSERT INTO user_chats (user_id, chat_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (1, 2),
  (2, 2),
  (1, 3),
  (3, 3);

INSERT INTO messages (sender_id, chat_id, content)
VALUES
  (1, 1, 'Hello, group!'),
  (2, 1, 'Hi everyone!'),
  (1, 2, 'Private message 1'),
  (2, 2, 'Private message 2'),
  (1, 3, 'Another private message'),
  (3, 3, 'Last private message');