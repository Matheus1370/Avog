<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>

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
                <button><a href="../../db/logout.jsp">SAIR</a></button>
            </div>

            <div class="mobile-menu-icon">
                <button onclick="menuShow()"><img class="icon" src="../../source/icons/hamburgue.svg" alt=""></button>
            </div>
        </nav>
        </header>

        <main>
            <div class="titulo">
                <h1>Perfil do Usuário</h1>
            </div>

            <div class="dados">
                <div class="info">
                    <label for="txtNome">Nome</label>
                    <input type="text" class="txtNome" id="txtNome" disabled value="<% out.print(session.getAttribute("usuario_nome")); %>">
                </div>
                <div class="info">
                    <label for="txtEmail">Email</label>
                    <input type="text" class="txtEmail" id="txtEmail" disabled value="<% out.print(session.getAttribute("usuario_email")); %>">
                </div>
                <div class="info">
                    <label for="txtSenha">Senha</label>
                    <input type="text" class="txtSenha" id="txtSenha" disabled value="<% out.print(session.getAttribute("usuario_senha")); %>">
                </div>
            </div>
        </main>
</body>

</html>
