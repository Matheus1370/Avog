<%@ page import="java.sql.*, java.text.*, java.time.*" %>
<%@ include file="../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if(session.getAttribute("organizador_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AVOG - Cadastro Organizador</title>
    <link rel="stylesheet" type="text/css" href="../../css/components/navbar.css">
    <link rel="stylesheet" type="text/css" href="../../css/components/footer.css">
    <link rel="stylesheet" href="../../css/usuario/eventoUser.css">
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
                    <li class="nav-item"><a href="perfil_org.jsp" class="nav-link">Perfil</a></li>
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
                    <li class="nav-item"><a href="perfil_org.jsp" class="nav-link">Perfil</a></li>
            </ul>
            <div class="login-button">
                <button><a href="../../db/logout.jsp">SAIR</a></button>
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
            SimpleDateFormat sdfFormatado = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="caixa">
            <% while(dados.next()) {
                String databanco = dados.getString("data");
                Date data = java.sql.Date.valueOf(databanco);
                String dataFormatada = sdfFormatado.format(data);

                %>
                <div class="card">
                    <input type="hidden" name="id_evento" value="<%= dados.getString("id_evento") %>">
                    <p><%= dados.getString("nome") %></p>
                    <p><%= dados.getString("descricao") %></p>
                    <p><%= dataFormatada %></p>
                    <p><%= dados.getString("hora") %></p>
                    <p><% 
                        // Recuperar o ID do evento desejado
                        int idEvento = Integer.parseInt(dados.getString("id_evento")); // Neste caso, vamos supor que o ID do evento desejado seja 5

                        // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                        String sql = "SELECT nome " +
                                    "FROM atividade " +
                                    "JOIN atividadeevento ON atividade.id_ativ = atividadeevento.atividade " +
                                    "WHERE atividadeevento.evento = ?";
                        PreparedStatement pstmtt = conexao.prepareStatement(sql);
                        pstmtt.setInt(1, idEvento); // Definir o ID do evento como parâmetro
                        ResultSet rss = pstmtt.executeQuery();
                        out.print(rss.next());
                    %>

                    <ul>
                    <%
                        // Exibir os nomes das atividades associadas ao evento
                        while (rss.next()) {
                            String nomeAtividade = rss.getString("nome");
                    %>
                        <li><%= nomeAtividade %></li>
                    <%
                        }
                    %>
                    </ul>

                    <%
                        // Fechar os recursos (ResultSet e PreparedStatement)
                        rss.close();
                        pstmtt.close();
                    %></P>
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
            <% while(dados2.next()) { 
                String databanco2 = dados2.getString("data");
                Date data2 = java.sql.Date.valueOf(databanco2);
                String dataFormatada2 = sdfFormatado.format(data2);%>
                <div class="card">
                    <input type="hidden" name="id_evento" value="<%= dados2.getString("id_evento") %>">
                    <p><%= dados2.getString("nome") %></p>
                    <p><%= dados2.getString("descricao") %></p>
                    <p><%= dataFormatada2 %></p>
                    <p><%= dados2.getString("hora") %></p>
                </div>
            <% } %>
        </div>
    </div>

    <div id="criarEvento" class="evento">
        <form action="../../db/cadEvento.jsp" name="form1" method="post">
            <label for="nome" class="texto">Nome: </label>
            <input type="text" name="nome" id="nome" placeholder="Digite seu nome...">
            <span id="errorNome" class="spam"></span>
            <br>

            <label for="descricao" class="texto">Descrição: </label>
            <textarea name="descricao" id="descricao" cols="30" rows="10" ></textarea>
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
            <%
                String cst = "SELECT * FROM atividade;";
                PreparedStatement sttm = conexao.prepareStatement(cst);
                ResultSet rs = sttm.executeQuery();
                while (rs.next()) {
                    String atividade = rs.getString("nome");
                    String atividade_id = rs.getString("id_ativ");
                %>
                    <input type="checkbox" name="atividade" value="<%= atividade_id %>"><%= atividade %><br>
                <% }%>
            <input type="button" onclick="verificar()" value="Salvar">
        </form>
    </div>

    <script type="text/javascript" src="../../js/validacoes/organizador/evento.js"></script>
</body>

</html>
