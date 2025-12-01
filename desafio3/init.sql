CREATE TABLE IF NOT EXISTS messages (
                                        id SERIAL PRIMARY KEY,
                                        text VARCHAR(255)
    );

INSERT INTO messages (text) VALUES ('Olá! Banco funcionando!');
INSERT INTO messages (text) VALUES ('Desafio 3 — Comunicação OK');
INSERT INTO messages (text) VALUES ('Persistência inicial via init.sql');
