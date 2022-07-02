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

- <b> Leitor </b> <br>

- <b> Leitor tem livro </b> <br>

- <b> Leitura </b> <br>

- <b> Livro </b> <br>


<h2> Stored Objects </h2>

<h3> View com Group By </h3>
<p> Criação: </p>
<pre>
CREATE OR REPLACE VIEW db_app_db2.livros_em_bibliotecas AS  
SELECT
	l.leitor_nome dono,
    biblioteca_nome,
	biblioteca_tema,
   	GROUP_CONCAT(DISTINCT lv.titulo SEPARATOR '; ') livros 
FROM biblioteca_tem_livro bl 
  INNER JOIN biblioteca b ON b.id_biblioteca = bl.fk_biblioteca 
  INNER JOIN leitor l ON l.id_leitor = b.fk_leitor 
  INNER JOIN livro lv ON lv.id_livro = bl.fk_livro
GROUP BY dono, biblioteca_nome, biblioteca_tema
ORDER BY dono, biblioteca_nome;
</pre>
<p> Exemplo de uso: </p>
<pre>
SELECT * FROM db_app_db2.livros_em_bibliotecas;
</pre>
