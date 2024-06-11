<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="java.sql.*, java.time.*, java.text.*" %>
<%@ include file="../../db/conexao.jsp" %>
<% if(session.getAttribute("organizador_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>
<% 
    int idOrganizador = Integer.parseInt(session.getAttribute("organizador_id").toString()); 
    //Busca os eventos da data atual e datas seguintes
    String consulta = "select * from organizador where id_org = ?;";
    //Cria o statement para executar o comando no banco
    PreparedStatement stm = conexao.prepareStatement(consulta);
    stm.setInt(1, idOrganizador);
    ResultSet dados = stm.executeQuery();//Busca os eventos da data atual e datas seguintes

  
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
                    <li class="nav-item"><a href="cadAdmin.jsp" class="nav-link">Cadastro</a></li>
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
                    <li class="nav-item"><a href="cadAdmin.jsp" class="nav-link">Cadastro</a></li>
            </ul>
            <div class="login-button">
                <button><a href="../../db/logout.jsp">SAIR</a></button>
            </div>
        </div>
    </header>

        <main>
            <div class="titulo">
                <h1>Perfil do Organizador</h1>
            </div>
            <% if(dados.next()){ 
                int idCargo = Integer.parseInt(dados.getString("cargo"));
                String consulta2 = "select * from cargo where id_cargo = ?;";
                //Cria o statement para executar o comando no banco
                PreparedStatement stm2 = conexao.prepareStatement(consulta2);
                stm2.setInt(1, idCargo);
                ResultSet dados2 = stm2.executeQuery();%>
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
                    <% if(dados2.next()){%>
                        <div class="info">
                            <label for="txtCargo">Cargo</label>
                            <input type="text" class="txtCargo" id="txtCargo" disabled value=<%= dados2.getString("nome")%>>
                        </div>
                    <% } %>
                </div>
            <% }%>
        </main>
</body>

</html>
