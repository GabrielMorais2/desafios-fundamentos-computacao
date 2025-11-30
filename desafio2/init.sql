CREATE TABLE messages (
                          id SERIAL PRIMARY KEY,
                          text VARCHAR(255),
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO messages (text) VALUES ('Hello from persistent volume!');
INSERT INTO messages (text) VALUES ('Primeiro registro persistido.');
INSERT INTO messages (text) VALUES ('Mais um teste de persistência.');
INSERT INTO messages (text) VALUES ('Volume Docker funcionando perfeitamente.');
INSERT INTO messages (text) VALUES ('Isso deve permanecer mesmo após remover o container.');
