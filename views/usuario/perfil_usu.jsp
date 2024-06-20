<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
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
    
    <jsp:include page="components/navbar.jsp" />

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
