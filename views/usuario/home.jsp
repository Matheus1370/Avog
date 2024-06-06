<%@page language="java" import="java.sql.*" %>
<%
    //variaveis para o banco de dados
    String banco    = "web" ;
    String endereco = "jdbc:mysql://localhost:3306/"+banco;
    String usuario  = "root";
    String senha    = "" ;
    //Variavel para o Driver
    String driver = "com.mysql.jdbc.Driver" ;
    //Carregar o driver na memória
    Class.forName( driver ) ;
    //Cria a variavel para conectar com o banco de dados
    Connection conexao ;
    //Abrir a conexao com o banco de dados
    conexao = DriverManager.getConnection(endereco, usuario, senha) ;

    String consulta = "select * from evento order desc limit 3;";

    //Cria o statement para executar o comando no banco
    PreparedStatement stm = conexao.prepareStatement(consulta) ;

    ResultSet  dados = stm.executeQuery() ;
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AVOG - Cadastro Organizador</title>
    <link rel="stylesheet" href="../css/organizador/cadAdmin.css">
    <link rel="stylesheet" href="../css/components/navbar.css">
    <link rel="stylesheet" href="../css/components/footer.css">
</head>

<body>
    <header>
        <nav class="nav-bar">
            <div class="logo">
                <img src="../source/icons/Avog.svg" alt="">
            </div>
            <div class="nav-list">
                <ul>
                    <li class="nav-item"><a href="../index.html" class="nav-link">Início</a></li>
                    <li class="nav-item"><a href="../sobre.html" class="nav-link">Sobre</a></li>
                    <li class="nav-item"><a href="../projetos.html" class="nav-link">Projetos</a></li>
                    <li class="nav-item"><a href="../apoiar.html" class="nav-link">Como Apoiar</a></li>
                    <li class="nav-item"><a href="../contato.html" class="nav-link">Contato</a></li>
                </ul>
            </div>

            <div class="login-button">
                <button><a href="login.html">ENTRAR</a></button>
            </div>

            <div class="mobile-menu-icon">
                <button onclick="menuShow()"><img class="icon" src="/source/icons/hamburgue.svg" alt=""></button>
            </div>
        </nav>
        <div class="mobile-menu">
            <ul>
                <li class="nav-item"><a href="index.html" class="nav-link">Início</a></li>
                <li class="nav-item"><a href="sobre.html" class="nav-link">Sobre</a></li>
                <li class="nav-item"><a href="projetos.html" class="nav-link">Projetos</a></li>
                <li class="nav-item"><a href="apoiar.html" class="nav-link">Como Apoiar</a></li>
                <li class="nav-item"><a href="contato.html" class="nav-link">Contato</a></li>
            </ul>
            <div class="login-button">
                <button><a href="login.html">ENTRAR</a></button>
            </div>
        </div>
    </header>

    <div class="titulos">
        <h2 class="text_titulo">Conta de Administrador</h2>
    </div>

    <div class="content">
        <form action="/db/cadAdmin.jsp" name="form1" method="post">
            <label for="nome">Nome: </label>
            <input type="text" name="nome" id="nome" placeholder="Digite seu nome...">
            <span id="errorNome" class="spam"></span>
            <br>

            <label for="email">Email: </label>
            <input type="text" name="email" id="email" placeholder="Digite seu email...">
            <span id="errorEmail" class="spam"></span>
            <br>

            <label for="senha">Senha: </label>
            <input type="password" name="senha" id="senha" placeholder="Digite sua senha...">
            <span id="errorSenha" class="spam"></span>
            <br>

            <label for="confirmSenha">Confirme sua senha: </label>
            <input type="password" name="confirmeSenha" id="confirmeSenha" placeholder="Confirme sua senha...">
            <span id="errorConfirmeSenha" class="spam"></span>
            <br>
            <% %>
                <label for="cargo">Cargo: </label>
                <select name="cargo" id="cargo">
                    <option value="">Selecione</option>
                    <option value="1">Presidente</option>
                    <option value="2">Vice</option>
                    <option value="3">Secretário</option>
                </select>

                <span id="errorCargo" class="spam"></span>
                <br>
                <input type="button" onclick="verificar()" value="Salvar">
        </form>
    </div>
    <script src="../js/validacoes/organizador/cadAdmin.js"></script>
</body>

</html>