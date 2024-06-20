<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="../../db/conexao.jsp" %>
<% if(session.getAttribute("usuario_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>

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
            <h1>Home</h1>
        </div>
    </main>
</body>

</html>
