
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

        <h2>Livros</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $titulo = 'titulo';
        $autor = 'autor';
        $tema = 'tema';
        $paginas = 'paginas';
        $data_publicacao = 'data_publicacao';
        /*TODO-1: Adicione uma variavel para cada coluna */


        $sql =
            'SELECT ' . $titulo .
            '     , autor.autor_nome ' . $autor .
            '     , ' . $tema .
            '     , ' . $paginas.
            '     , ' . $data_publicacao.
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM livro
               INNER JOIN autor ON id_autor = fk_autor';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $titulo . '</th>' .
            '        <th>' . $autor . '</th>' .
            '        <th>' . $tema . '</th>' .
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
                    '<td>' . $registro[$tema] . '</td>' .
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
