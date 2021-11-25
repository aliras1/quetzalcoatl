CREATE TABLE user_roles
(
    user_id BIGINT       NOT NULL,
    roles        VARCHAR(256) NOT NULL,
    PRIMARY KEY (user_id, roles),
    FOREIGN KEY (user_id) REFERENCES auth_user(id)
);
