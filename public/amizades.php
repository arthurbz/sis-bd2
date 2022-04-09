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

        <h2>Amizades</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $fk_leitor1 = 'fk_leitor1';
        $fk_leitor2 = 'fk_leitor2';
        /*TODO-1: Adicione uma variavel para cada coluna */

        $sql =
            'SELECT leitor1.nome ' . $fk_leitor1 .
            '     , leitor2.nome ' . $fk_leitor2 .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM amizade 
               INNER JOIN leitor leitor1 ON leitor1.id_leitor = amizade.fk_leitor1
               INNER JOIN leitor leitor2 ON leitor2.id_leitor = amizade.fk_leitor2';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }

        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $fk_leitor1. '</th>' .
            '        <th>' . $fk_leitor2 . '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$fk_leitor1] . '</td>' .
                    '<td>' . $registro[$fk_leitor2] . '</td>';
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
