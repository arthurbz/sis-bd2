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

        <h2>Lista de todos leitores e seus livros</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $leitor_nome = 'leitor_nome';
        $quantidade = 'quantidade';
        $titulo = 'titulo';
        /*TODO-1: Adicione uma variavel para cada coluna */

        $sql =
            'SELECT ' . $leitor_nome.
            '     , ' . $titulo .
            '     , ' . $quantidade .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            ' FROM leitor_tem_livro ltl 
              INNER JOIN leitor lt ON lt.id_leitor = ltl.fk_leitor 
              INNER JOIN livro lv ON lv.id_livro = ltl.fk_livro
              ORDER BY leitor_nome, titulo';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $leitor_nome . '</th>' .
            '        <th>' . $titulo . '</th>' .
            '        <th>' . $quantidade . '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$leitor_nome] . '</td>' .
                    '<td>' . $registro[$titulo] . '</td>' .
                    '<td>' . $registro[$quantidade] . '</td>';
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
