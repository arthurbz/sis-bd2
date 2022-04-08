<!DOCTYPE html>

<head>
    <style>
        .content {
            max-width: 500px;
            margin: auto;
        }
    </style>
</head>

<html>

<body>
    <div class="content">
        <h1>Bibliófilo's</h1>

        <h2>Livros</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $titulo = 'titulo';
        $autor = 'autor';
        $classificacao = 'classificacao';
        $paginas = 'paginas';
        $data_publicacao = 'data_publicacao';
        /*TODO-1: Adicione uma variavel para cada coluna */


        $sql =
            'SELECT ' . $titulo .
            '     , ' . $autor .
            '     , ' . $classificacao .
            '     , ' . $paginas.
            '     , ' . $data_publicacao.
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM livros';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table>' .
            '    <tr>' .
            '        <th>' . $titulo . '</th>' .
            '        <th>' . $autor . '</th>' .
            '        <th>' . $classificacao . '</th>' .
            '        <th>' . $paginas . '</th>' .
            '        <th>' . $data_publicacao. '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$titulo] . '</td>' .
                    '<td>' . $registro[$autor] . '</td>' .
                    '<td>' . $registro[$classificacao] . '</td>' .
                    '<td>' . $registro[$paginas] . '</td>' .
                    '<td>' . $registro[$data_publicacao] . '</td>';
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
