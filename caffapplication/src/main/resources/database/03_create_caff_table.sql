CREATE TABLE caff_files
(
    caff_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    caff BLOB NOT NULL,
    FOREIGN KEY (user_id)
);
