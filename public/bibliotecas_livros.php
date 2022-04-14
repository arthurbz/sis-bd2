<!DOCTYPE html>

<head>
    <style>
        .content {
            margin: auto;
        }
    </style>
</head>

<html>

<body>
    <div class="content">
        <h1>Bibliófilo's</h1>

        <h2>Bibliotecas e seus livros</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $leitor_nome = 'leitor_nome';
        $biblioteca_nome = 'biblioteca_nome';
        $biblioteca_tema = 'biblioteca_tema';
        $titulo = 'titulo';
        /*TODO-1: Adicione uma variavel para cada coluna */

        $sql =
            'SELECT ' . $leitor_nome.
            '     , ' . $biblioteca_nome .
            '     , ' . $biblioteca_tema .
            '     , ' . $titulo .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            ' FROM biblioteca_tem_livro bl 
              INNER JOIN biblioteca b ON b.id_biblioteca = bl.fk_biblioteca 
              INNER JOIN leitor l ON l.id_leitor = b.fk_leitor 
              INNER JOIN livro lv ON lv.id_livro = bl.fk_livro
              ORDER BY biblioteca_nome, titulo';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $leitor_nome . '</th>' .
            '        <th>' . $biblioteca_nome . '</th>' .
            '        <th>' . $biblioteca_tema . '</th>' .
            '        <th>' . $titulo . '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$leitor_nome] . '</td>' .
                    '<td>' . $registro[$biblioteca_nome] . '</td>' .
                    '<td>' . $registro[$biblioteca_tema] . '</td>' .
                    '<td>' . $registro[$titulo] . '</td>';
                echo '</tr>';
            }
            echo '</table>';
        } else {
            echo 'Sem dados!';
        }
        FecharConexao($conexao);
        ?>
    </div>
</body>

</html>
