INSERT INTO auth_user(id, username, password_hash)
VALUES (1, 'admin', '{bcrypt}$2a$10$vVQgOzqgfBgEGNiZ14Wss.zGhRJGmoB4SMnNzkXr7IYsAkaNGYOa2');
INSERT INTO auth_user_roles(auth_user_id, roles)
VALUES (1, 'ROLE_ADMIN');
