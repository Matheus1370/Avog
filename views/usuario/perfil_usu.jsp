<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="java.sql.*, java.time.*, java.text.*" %>
<%@ include file="../../db/conexao.jsp" %>
<% if(session.getAttribute("usuario_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>
<% 
    int idUsuario = Integer.parseInt(session.getAttribute("usuario_id").toString()); 
    //Busca os eventos da data atual e datas seguintes
    String consulta = "select * from usuario where id_usu = ?;";
    //Cria o statement para executar o comando no banco
    PreparedStatement stm = conexao.prepareStatement(consulta);
    stm.setInt(1, idUsuario);
    ResultSet dados = stm.executeQuery();
%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AVOG - Cadastro Organizador</title>
    <link rel="stylesheet" type="text/css" href="../../css/components/navbar.css">
    <link rel="stylesheet" type="text/css" href="../../css/components/footer.css">
    <link rel="stylesheet" href="../../css/perfilusu.css">
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
                    <li class="nav-item"><a href="evento.jsp" class="nav-link">Evento</a></li>
                </ul>
            </div>

            <div class="login-button">
                <button><a href="../../db/logout.jsp">Sair</a></button>
            </div>

            <div class="mobile-menu-icon">
                <button onclick="menuShow()"><img class="icon" src="../../source/icons/hamburgue.svg" alt=""></button>
            </div>
        </nav>
        <div class="mobile-menu">
            <ul>
                    <li class="nav-item"><a href="evento.jsp" class="nav-link">Evento</a></li>
            </ul>
            <div class="login-button">
                <button><a href="../../db/logout.jsp">SAIR</a></button>
            </div>
        </div>
    </header>

        <main>
            <div class="titulo">
                <h1>Perfil do Usuário</h1>
            </div>
            <% if(dados.next()){ %>
                <div class="dados">
                    <div class="info">
                        <label for="txtNome">Nome</label>
                        <input type="text" class="txtNome" id="txtNome" disabled value=<%= dados.getString("nome") %>>
                    </div>
                    <div class="info">
                        <label for="txtEmail">Email</label>
                        <input type="text" class="txtEmail" id="txtEmail" disabled value=<%= dados.getString("email") %>>
                    </div>
                    <div class="info">
                        <label for="txtSenha">Senha</label>
                        <input type="text" class="txtSenha" id="txtSenha" disabled value=<%= dados.getString("senha") %>>
                    </div>
                </div>
            <% }%>
        </main>
</body>

</html>
