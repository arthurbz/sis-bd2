# Disciplina de Banco de Dados II

O projeto é uma representação de uma rede social de leitores. É utilizado PHP para exibir os dados com HTML e também para fazer conexão ao banco. Também é utilizado Docker para facilitar o uso do MySQL e do PHP. O objetivo com este trabalho é aprender sobre bancos de dados relacionais e neste está sendo utilizado MySQL.

<h2> Tabelas </h2>

- <b> Amizade </b> <br>
Tabela n ... n representando a amizade entre os leitores. Ela funciona para "ambos os lados" por ser pensada como um "follow" de uma rede social. Ou seja, você pode seguir uma pessoa e ela te seguir de volta ou n

- <b> Autor </b> <br>
Tabela que representa o autor de um livro. Cardinalidade de 1 ... n com a tabela Livro, pois um autor pode ter muitos livros, mas um livro pode ter somente um autor.

- <b> Biblioteca </b> <br>
Uma Biblioteca no contexto deste projeto, é um acumulado de diversos livros que um leitor possui. Também possui cardinalidade 1 ... n com a tabela Leitor, pois um leitor pode ter uma ou muitas bibliotecas.

- <b> Biblioteca tem livros </b> <br>
Tabela que representa a relação n ... n de livros e bibliotecas. Um determinado livro pode estar em uma biblioteca e uma biblioteca pode ter muitos livros.

- <b> Leitor </b> <br>
Tabela que representa os leitores (usuários).

- <b> Leitor tem livro </b> <br>
Representa a relação n ... n entre livros e leitores. Um leitor pode ter muitos livros e um livro (levando em consideração a ideia de um livro e não o livro físico em sí). Por exemplo, em nosso banco o livro "Meditations - Marcus Aurelius" será o mesmo para todos os leitores, por mais que os leitores tenham diferentes cópias do mesmo.

- <b> Leitura </b> <br>
Tabela que registra todas as leituras de um determinado leitor e permite que ele insira sua opinião sobre o livro.

- <b> Livro </b> <br>
Representa o livro em sí. Possui relação com a tabela Autor, sendo a cardinalidade n ... 1, ou seja, um livro possui um autor e o autor possui vários livros.

<h2> Diagrama ER </h2>
<img src="https://raw.githubusercontent.com/arthurbz/sis-bd2/main/scripts/UML.jpg" >

<h2> Stored Objects </h2>

<!-- View com Group By --->
<h3> View com Group By </h3>
<p> Objetivo: Exibir todas as bibliotecas, agrupando seus livros. </p>
<p> Criação: </p>

```
CREATE OR REPLACE VIEW db_app_db2.livros_em_bibliotecas AS  
SELECT
	leitor_nome dono,
	biblioteca_nome,
	biblioteca_tema,
   	GROUP_CONCAT(DISTINCT lv.titulo SEPARATOR '; ') livros 
FROM biblioteca_tem_livro bl 
	INNER JOIN biblioteca b ON b.id_biblioteca = bl.fk_biblioteca 
	INNER JOIN leitor l ON l.id_leitor = b.fk_leitor 
	INNER JOIN livro lv ON lv.id_livro = bl.fk_livro
GROUP BY dono, biblioteca_nome, biblioteca_tema
ORDER BY dono, biblioteca_nome;
```

<p> Exemplo de uso: </p>

```
SELECT * FROM db_app_db2.livros_em_bibliotecas;
```
<!-- /View com Group By --->

<!-- Function --->
<h3> Function </h3>
<p> Objetivo: Calcular quantas vezes um livro já foi lido. </p>
<p> Criação: </p>

```
DELIMITER //

CREATE FUNCTION quantidade_leituras (p_id_livro BIGINT)
RETURNS INT
DETERMINISTIC
BEGIN
	SET @leituras :=
	(SELECT
		COUNT(*)
	FROM leitura
	WHERE id_livro = p_id_livro);

	RETURN @leituras;
END //

DELIMITER ;
```

<p> Exemplo de uso: </p>

```
SELECT
	*,
	quantidade_leituras(id_livro)
FROM livro;
```
<!-- /Function --->

<!-- /Procedure --->
<h3> Procedure </h3>
<p> Objetivo: Excluir todos os autores que não possuam livros. </p>
<p> Criação: </p>

```
DROP PROCEDURE IF EXISTS excluir_autores_sem_livros;

DELIMITER //

CREATE PROCEDURE excluir_autores_sem_livros()
BEGIN
	DELETE autor
	FROM autor
	LEFT JOIN livro ON fk_autor = id_autor
	WHERE id_livro IS NULL;
END //

DELIMITER ;
```

<p> Exemplo de uso: </p>

```
CALL excluir_autores_sem_livros();
```
<!-- /Procedure --->

<!-- /Trigger --->
<h3> Trigger </h3>
<p> Objetivo: Não permitir que leitores insiram números em seu nome. </p>
<p> Criação: </p>

```
DROP TRIGGER IF EXISTS trigger_ajusta_nome;

DELIMITER //

CREATE TRIGGER trigger_ajusta_nome BEFORE INSERT
ON leitor
FOR EACH ROW
BEGIN
	SET NEW.leitor_nome = REGEXP_REPLACE(NEW.leitor_nome, "[0-9]", "");
END //

DELIMITER ;
```

<p> Exemplo de uso: </p>

```
INSERT INTO leitor (leitor_nome, data_nascimento, sexo) VALUES
('Algum 123 Teste 888899912301 Sem Números', '2000-10-08', 'M'),
('Teste1', '2000-05-10', 'M');

SELECT * FROM leitor;
/*
                 ** Resultado **
id_leitor|leitor_nome                 |data_nascimento|sexo|
---------+----------------------------+---------------+----+
        1|Algum  Teste  Sem Números   |     2000-10-08|M   |
        2|Teste                       |     2000-05-10|M   |
*/
```
<!-- /Trigger --->

<!-- /Event --->
<h3> Event </h3>
<p> Objetivo: Excluir todos os autores sem livros a cada 1 semana. </p>
<p> Criação: </p>

```
SET GLOBAL event_scheduler = ON;
SHOW ProcessList;

DROP EVENT IF EXISTS db_app_db2.limpar_autores;
CREATE EVENT db_app_db2.limpar_autores
ON SCHEDULE EVERY 1 HOUR
ON COMPLETION PRESERVE
DO CALL excluir_autores_sem_livros();
```

<p> Exemplo de uso: </p>

```
SHOW events;
```
<!-- /Event --->
