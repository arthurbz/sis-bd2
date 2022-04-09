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

        <h2>Leituras</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $data_inicio = 'data_inicio';
        $data_fim = 'data_fim';
        $opiniao_leitor = 'opiniao_leitor';
        $classificacao = 'classificacao';
        $fk_leitor = 'fk_leitor';
        $fk_livro = 'fk_livro';
        /*TODO-1: Adicione uma variavel para cada coluna */

        $sql =
            'SELECT leitor.nome ' . $fk_leitor.
            '     , livro.titulo ' . $fk_livro .
            '     , ' . $data_inicio .
            '     , ' . $data_fim .
            '     , ' . $opiniao_leitor .
            '     , leitura.' . $classificacao .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM leitura
               INNER JOIN leitor ON id_leitor = leitura.fk_leitor
               INNER JOIN livro ON id_livro = leitura.fk_livro;';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $fk_leitor . '</th>' .
            '        <th>' . $fk_livro . '</th>' .
            '        <th>' . $data_inicio . '</th>' .
            '        <th>' . $data_fim . '</th>' .
            '        <th>' . $classificacao . '</th>' .
            '        <th>' . $opiniao_leitor . '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$fk_leitor] . '</td>' .
                    '<td>' . $registro[$fk_livro] . '</td>' .
                    '<td>' . $registro[$data_inicio] . '</td>' .
                    '<td>' . $registro[$data_fim] . '</td>' .
                    '<td>' . $registro[$classificacao] . '</td>' .
                    '<td>' . $registro[$opiniao_leitor] . '</td>';
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
