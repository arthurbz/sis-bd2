# Disciplina de Banco de Dados II

O projeto é uma representação de uma rede social de leitores. O objetivo com este trabalho é aprender sobre bancos de dados relacionais e neste está sendo utilizado MySQL.

<h2> Tabelas </h2>

- Amizade
- Autor
- Biblioteca
- Biblioteca tem livros
- Leitor
- Leitor tem livro
- Leitura
- Livro

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
