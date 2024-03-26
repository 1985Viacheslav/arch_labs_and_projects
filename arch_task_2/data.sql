-- Вставка тестовых пользователей
INSERT INTO users (login, password_hash, first_name, last_name)
VALUES
  ('user1', 'hash1', 'John', 'Doe'),
  ('user2', 'hash2', 'Jane', 'Smith'),
  ('user3', 'hash3', 'Alice', 'Johnson');

-- Вставка тестовых чатов
INSERT INTO chats (name, is_group_chat)
VALUES
  ('Group Chat 1', true),
  ('Private Chat 1', false),
  ('Private Chat 2', false);

-- Вставка тестовых связей пользователей и чатов
INSERT INTO user_chats (user_id, chat_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (1, 2),
  (2, 2),
  (1, 3),
  (3, 3);

-- Вставка тестовых сообщений
INSERT INTO messages (sender_id, chat_id, content)
VALUES
  (1, 1, 'Hello, group!'),
  (2, 1, 'Hi everyone!'),
  (1, 2, 'Private message 1'),
  (2, 2, 'Private message 2'),
  (1, 3, 'Another private message'),
  (3, 3, 'Last private message');