<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AVOG - Cadastro Organizador</title>
    <link rel="stylesheet" type="text/css" href="../../css/components/navbar.css">
    <link rel="stylesheet" type="text/css" href="../../css/components/footer.css">
    <style>
        .evento {
            display: none;
        }
    </style>
</head>

<body>
    <header>
        <nav class="nav-bar">
            <div class="logo">
                <img src="../../source/icons/Avog.svg" alt="">
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
                <button onclick="menuShow()"><img class="icon" src="../../source/icons/hamburgue.svg" alt=""></button>
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

    <div class="sub_nav">
        <div id="titulos">
            <h2 class="text_titulo">Eventos</h2>
            <div id="sub_titulos">
                <ul>
                    <li class="nav-item"><a id="ativos" href="#" onclick="selecao(event, 'eventoAtv')">Ativos</a></li>
                    <li class="nav-item"><a id="encerrados" href="#" onclick="selecao(event, 'eventoEnc')">Encerrados</a></li>
                    <li class="nav-item"><a id="criar" href="#" onclick="selecao(event, 'criarEvento')">Criar Eventos</a></li>
                </ul>
            </div>
        </div>
        <div id="search"></div>
    </div>

    <div id="eventoAtv" class="evento">
        <%
            // Obter a data atual
            LocalDate currentDate = LocalDate.now();
            String date = currentDate.toString(); // Converter para String no formato YYYY-MM-DD
            //Busca os eventos da data atual e datas seguintes
            String consulta = "select * from evento where data >= ?;";
            //Cria o statement para executar o comando no banco
            PreparedStatement stm = conexao.prepareStatement(consulta);
            stm.setDate(1, java.sql.Date.valueOf(date));
            ResultSet dados = stm.executeQuery();
        %>
        <div class="caixa">
            <% while(dados.next()) { %>
                <div class="card">
                    <input type="hidden" name="id_evento" value="<%= dados.getString("id_evento") %>">
                    <p><%= dados.getString("nome") %></p>
                    <p><%= dados.getString("descricao") %></p>
                    <p><%= dados.getString("data") %></p>
                    <p><%= dados.getString("hora") %></p>
                </div>
            <% } %>
        </div>
    </div> 

    <div id="eventoEnc" class="evento">
        <%
            String consulta2 = "select * from evento where data < ?;";
            PreparedStatement stm2 = conexao.prepareStatement(consulta2);
            stm2.setDate(1, java.sql.Date.valueOf(date));
            ResultSet dados2 = stm2.executeQuery();
        %>
        <div class="caixa">
            <% while(dados2.next()) { %>
                <div class="card">
                    <input type="hidden" name="id_evento" value="<%= dados2.getString("id_evento") %>">
                    <p><%= dados2.getString("nome") %></p>
                    <p><%= dados2.getString("descricao") %></p>
                    <p><%= dados2.getString("data") %></p>
                    <p><%= dados2.getString("hora") %></p>
                </div>
            <% } %>
        </div>
    </div>

    <div id="criarEvento" class="evento">
        <form action="../db/cadastro.jsp" name="form1" method="post">
            <label for="nome" class="texto">Nome: </label>
            <input type="text" name="nome" id="nome" placeholder="Digite seu nome...">
            <span id="errorNome" class="spam"></span>
            <br>

            <label for="descricao" class="texto">Descrição: </label>
            <textarea name="descricao" id="descricao" cols="30" rows="10" placeholder="Digite uma descrição..."></textarea>
            <span id="errorDescricao" class="spam"></span>
            <br>
            
            <label for="data" class="texto">Data: </label>
            <input type="date" name="data" id="data">
            <span id="errorData" class="spam"></span>
            <br>

            <label for="hora">Hora: </label>
            <input type="time" name="hora" id="hora">
            <span id="errorHora" class="spam"></span>
            <br>

            <input type="button" onclick="verificar()" value="Salvar">
        </form>
    </div>

    <script type="text/javascript" src="../../js/validacoes/organizador/evento.js"></script>
</body>

</html>
