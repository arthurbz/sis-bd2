USE db_app_db2;

/*CREATE TABLE*/
CREATE TABLE livro (
  id_livro BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100),
  autor VARCHAR(100),
  classificacao VARCHAR(100),
  paginas INT,
  data_publicacao DATE
);

CREATE TABLE leitor (
  id_leitor BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  data_nascimento DATE,
  sexo CHAR,
  CONSTRAINT check_sexo CHECK (sexo = 'M' OR sexo = 'F')
);

CREATE TABLE leitura (
  id_leitura BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  data_inicio DATE,
  data_fim DATE,
  opiniao_leitor VARCHAR(1000),
  classificacao INT,
  fk_leitor BIGINT NOT NULL,
  fk_livro BIGINT NOT NULL,
  CONSTRAINT fk_leitor FOREIGN KEY(fk_leitor) REFERENCES leitor(id_leitor),
  CONSTRAINT fk_livro FOREIGN KEY(fk_livro) REFERENCES livro(id_livro),
  CONSTRAINT check_classificacao CHECK (classificacao >= 0 AND classificacao <= 10)
);

CREATE TABLE amizade (
  fk_leitor1 BIGINT NOT NULL,
  fk_leitor2 BIGINT NOT NULL,
  PRIMARY KEY (fk_leitor1, fk_leitor2),
  CONSTRAINT fk_leitor1 FOREIGN KEY(fk_leitor1) REFERENCES leitor(id_leitor),
  CONSTRAINT fk_leitor2 FOREIGN KEY(fk_leitor2) REFERENCES leitor(id_leitor)
);



/*INSERT*/
INSERT INTO livro (titulo, autor, classificacao, paginas, data_publicacao)
VALUES
('A República', 'Platão', 'Filosofia', 365, '2021-12-31'),
('Sobre a brevidade da vida', 'Sêneca', 'Filosofia', 120, '2021-12-31'),
('Em busca de sentido', 'Vitor E. Frankl', 'Filosofia', 200, '2021-12-31'),
('Sistemas Operacionais Modernos', 'Andrew Tanenbaum', 'Computadores', 1000, '2021-12-31');

INSERT INTO leitor (nome, data_nascimento, sexo)
VALUES
('Guilherme Giordani', '2000-10-08', 'M'),
('Leonardo Bortolini', '2000-05-10', 'M'),
('Cléber Macieski', '1992-12-03', 'M'),
('Arthur Bassotto Ziero', '2001-02-02', 'M'),
('Alguma Vs. Sr.', '2002-02-02', 'F');

INSERT INTO leitura (data_inicio, data_fim, opiniao_leitor, classificacao, fk_leitor, fk_livro)
VALUES
('2021-01-01', '2021-03-10', 'Muito bom', 8, 1, 3),
('2021-03-09', '2021-05-01', 'Complexo demais pro meu gosto', 8, 2, 1),
('2021-01-01', '2021-03-10', 'Não gostei 100%', 4, 3, 4),
('2021-01-01', '2021-02-10', 'Melhor que já li', 10, 1, 3),
('2021-01-01', '2021-03-10', NULL, 10, 3, 3),
('2021-01-01', '2021-03-10', 'Gostei até, mas ... ... ...', 6, 5, 1),
('2021-01-01', '2021-03-10', 'Muito bom!!! Gostei por que ...', 9, 4, 2),
('2021-01-01', '2021-03-10', 'Sim, gostei por tal e tal motivo', 8, 3, 2);

INSERT INTO amizade (fk_leitor1, fk_leitor2)
VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(2, 5),
(3, 1),
(3, 2),
(4, 1),
(4, 3),
(4, 5),
(5, 1),
(5, 3),
(5, 4);

SELECT
	*
FROM leitura
INNER JOIN livro ON id_livro = leitura.fk_livro
INNER JOIN leitor ON id_leitor = leitura.fk_leitor;
