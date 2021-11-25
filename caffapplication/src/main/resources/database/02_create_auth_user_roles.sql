CREATE TABLE auth_user_roles
(
    auth_user_id BIGINT       NOT NULL,
    roles        VARCHAR(256) NOT NULL,
    PRIMARY KEY (auth_user_id, roles),
    FOREIGN KEY (auth_user_id) REFERENCES auth_user(id)
);
