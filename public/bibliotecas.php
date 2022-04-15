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

        <h2>Bibliotecas</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $leitor_nome = 'leitor_nome';
        $biblioteca_nome = 'biblioteca_nome';
        $biblioteca_tema = 'biblioteca_tema';

        $sql =
            'SELECT ' . $leitor_nome.
            '     , ' . $biblioteca_nome .
            '     , ' . $biblioteca_tema .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            ' FROM biblioteca b 
              INNER JOIN leitor l ON l.id_leitor = b.fk_leitor 
              ORDER BY biblioteca_nome';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }

        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $leitor_nome . '</th>' .
            '        <th>' . $biblioteca_nome . '</th>' .
            '        <th>' . $biblioteca_tema . '</th>';
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$leitor_nome] . '</td>' .
                    '<td>' . $registro[$biblioteca_nome] . '</td>' .
                    '<td>' . $registro[$biblioteca_tema] . '</td>';
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
