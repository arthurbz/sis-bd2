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

        <h2>Leitores</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $nome = 'nome';
        $data_nascimento = 'data_nascimento';
        $sexo = 'sexo';
        /*TODO-1: Adicione uma variavel para cada coluna */

        $sql =
            'SELECT ' . $nome.
            '     , ' . $data_nascimento.
            '     , ' . $sexo.
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM leitor';

        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
        $cabecalho =
            '<table style="width:100%;">' .
            '    <tr align="left">' .
            '        <th>' . $nome. '</th>' .
            '        <th>' . $data_nascimento. '</th>' .
            '        <th>' . $sexo. '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';
                    /* TODO-4: Adicione a tabela os novos registros. */
                echo '<td>' . $registro[$nome] . '</td>' .
                    '<td>' . $registro[$data_nascimento] . '</td>' .
                    '<td>' . $registro[$sexo] . '</td>';
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
