/*View com Group By*/
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

/*Function*/
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

/*Procedure*/
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

/*Trigger*/
DROP TRIGGER IF EXISTS trigger_ajusta_nome;

DELIMITER //

CREATE TRIGGER trigger_ajusta_nome BEFORE INSERT
ON leitor
FOR EACH ROW
BEGIN
	SET NEW.leitor_nome = REGEXP_REPLACE(NEW.leitor_nome, "[0-9]", "");
END //

DELIMITER ;

/*Event*/
SET GLOBAL event_scheduler = ON;

DROP EVENT IF EXISTS db_app_db2.limpar_autores;
CREATE EVENT db_app_db2.limpar_autores
ON SCHEDULE EVERY 1 HOUR
ON COMPLETION PRESERVE
DO CALL excluir_autores_sem_livros();
