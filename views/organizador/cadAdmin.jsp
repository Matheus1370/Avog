<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../db/conexao.jsp" %>
<% if(session.getAttribute("organizador_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AVOG - Cadastro Organizador</title>
    <link rel="stylesheet" href="../../css/components/footer.css"> 
    <link rel="stylesheet" href="../../css/login.css">
</head>
<body>
        <!-- Formulário que cadastra o evento -->
        <form class="main-login" action="../../db/cadAdmin.jsp" name="form1" method="post">
            <div class="left-login ">
                <div class="card-link">
                    <!-- -->
                    <!-- Mensagem que retorna se o cadastro foi realizado com sucesso -->
                    <div id="mensagemCard" class="textfield">
                        <span id="mensagem"></span>
                    </div>
                    <div class="textfield">
                        <label for="email">Nome</label>
                        <input type="text" name="nome" id="nome" placeholder="Digite seu nome...">
                        <span id="errorNome" class="spam"></span>
                    </div>
                    <div class="textfield">
                        <label for="email">Email</label>
                        <input type="text" name="email" id="email" placeholder="Digite seu email...">
                        <span id="errorEmail" class="spam"></span>
                        <span id="errorEmailURL" class="spam" style="display: none;"></span>
                    </div>
                    <div class="textfield">
                        <label for="email">Senha</label>
                        <input type="password" name="senha" id="senha" placeholder="Digite sua senha...">
                        <span id="errorSenha" class="spam"></span>
                    </div>
                    <div class="textfield">
                        <label for="senha">Confirme sua senha</label>
                        <input type="password" name="confirmeSenha" id="confirmeSenha" placeholder="Confirme sua senha...">
                        <span id="errorConfirmeSenha" class="spam"></span>
                    </div>
                    <div class="textfield">
                    <label class="textino" for="cargo">Cargo </label>
                    <select class="select" name="cargo" id="cargo">
                    <option value="0">Selecione</option>
                    <option value="1">Presidente</option>
                    <option value="2">Vice</option>
                    <option value="3">Secretário</option>
                    </select>
                    <span id="errorCargo" class="spam"></span>
                    </div>
                    <input type="button" class="btn-login" onclick="verificar()" value="SALVAR">
                    <a href="home.jsp" class="voltar">Voltar</a>
                </div>
            </div>
            <div class="right-login">
                <h1>Faça seu cadastro como Administrador!!</h1>
                <img class="voli" src="../../source/banners/admin-animate.svg" alt="Volei">
            </div>
        </form>
        <script src="../../js/validacoes/organizador/cadAdmin.js"></script>
</body>
</html>