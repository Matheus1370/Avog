<%@ page import="java.sql.*, java.text.*, java.time.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
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
    <link rel="stylesheet" href="../../css/login.css">
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
                    <li class="nav-item"><a href="perfil_org.jsp" class="nav-link">Perfil</a></li>
                    <li class="nav-item"><a href="cadAdmin.jsp" class="nav-link">Cadastro</a></li>
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
                    <p>
                    <% 
                        // Recuperar o ID do evento desejado
                        int idEvento = Integer.parseInt(dados.getString("id_evento")); // Neste caso, vamos supor que o ID do evento desejado seja 5
                        List<Integer> arrayFromDB = new ArrayList<>();
                        
                        // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                        String sql = "SELECT atividade FROM atividadeevento where evento = ?";
                        PreparedStatement pstmtt = conexao.prepareStatement(sql);
                        pstmtt.setInt(1, idEvento); // Definir o ID do evento como parâmetro
                        ResultSet rss = pstmtt.executeQuery();
                        
                        while (rss.next()) {
                            String atividadeString = rss.getString("atividade");
                            // Remover os colchetes e quebrar a string em substrings separadas por vírgulas
                            String[] elementosString = atividadeString.substring(1, atividadeString.length() - 1).split(",\\s*");
                            // Converter substrings para inteiros
                            for (String elementoString : elementosString) {
                                arrayFromDB.add(Integer.parseInt(elementoString));
                            }
                        }
                    %>

                    <ul style="list-style: none;">
                        <%
                            // Iterar sobre a lista e exibir cada elemento em uma lista HTML
                            for (Integer elemento : arrayFromDB) {
                                int id_ativ = elemento;
                                // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                                String sql2 = "SELECT * FROM atividade where id_ativ = ?";
                                PreparedStatement pstmtt2 = conexao.prepareStatement(sql2);
                                pstmtt2.setInt(1, id_ativ); // Definir o ID do evento como parâmetro
                                ResultSet rss2 = pstmtt2.executeQuery();
                                while(rss2.next()){
                        %>
                                    <li><%= rss2.getString("nome") %></li>
                        <%
                                }
                                rss2.close();
                                pstmtt2.close();
                            }
                        %>
                    </ul>

                    <%
                        // Fechar os recursos (ResultSet e PreparedStatement)
                        rss.close();
                        pstmtt.close();
                    %>
                    </p>
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
                    <p>
                        <% 
                            // Recuperar o ID do evento desejado
                            int idEvento2 = Integer.parseInt(dados2.getString("id_evento")); // Neste caso, vamos supor que o ID do evento desejado seja 5
                            List<Integer> arrayFromDBEnc = new ArrayList<>();
                            
                            // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                            String sqlEnc = "SELECT atividade FROM atividadeevento where evento = ?";
                            PreparedStatement pstmttEnc = conexao.prepareStatement(sqlEnc);
                            pstmttEnc.setInt(1, idEvento2); // Definir o ID do evento como parâmetro
                            ResultSet rssEnc = pstmttEnc.executeQuery();
                            
                            while (rssEnc.next()) {
                                String atividadeString2 = rssEnc.getString("atividade");
                                // Remover os colchetes e quebrar a string em substrings separadas por vírgulas
                                String[] elementosEncString = atividadeString2.substring(1, atividadeString2.length() - 1).split(",\\s*");
                                // Converter substrings para inteiros
                                for (String elementoEncString : elementosEncString) {
                                    arrayFromDBEnc.add(Integer.parseInt(elementoEncString));
                                }
                            }
                        %>

                        <ul style="list-style: none;">
                        <%
                            // Iterar sobre a lista e exibir cada elemento em uma lista HTML
                            for (Integer elementoEnc : arrayFromDBEnc) {
                                int id_ativ2 = elementoEnc;
                                // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                                String sqlEnc2 = "SELECT * FROM atividade where id_ativ = ?";
                                PreparedStatement pstmttEnc2 = conexao.prepareStatement(sqlEnc2);
                                pstmttEnc2.setInt(1, id_ativ2); // Definir o ID da atividade como parâmetro
                                ResultSet rssEnc2 = pstmttEnc2.executeQuery();
                                while(rssEnc2.next()){
                        %>
                                    <li><%= rssEnc2.getString("nome") %></li>
                        <%
                                }
                                rssEnc2.close();
                                pstmttEnc2.close();
                            }
                        %>
                        </ul>

                        <%
                            // Fechar os recursos (ResultSet e PreparedStatement)
                            rssEnc.close();
                            pstmttEnc.close();
                        %>
                    </p>
                </div>
            <% } %>
        </div>
    </div>

    <div id="criarEvento" class="evento">
        <form action="../../db/cadEvento.jsp" name="form1" method="post">
            <div class="textfield">
            <label for="nome" class="texto">Nome: </label>
            <input type="text" name="nome" id="nome" placeholder="Digite seu nome...">
            <span id="errorNome" class="spam"></span>
            <br>
                </div>

            <div class="textfield">
            <label for="descricao" class="texto">Descrição: </label>
            <textarea name="descricao" id="descricao" cols="30" rows="10" ></textarea>
            <span id="errorDescricao" class="spam"></span>
            <br>
                </div>
            
            <div class="textfield">
            <label for="data" class="texto">Data: </label>
            <input type="date" name="data" id="data">
            <span id="errorData" class="spam"></span>
            <br>
                </div>

                <div class="textfield">
            <label for="hora">Hora: </label>
            <input type="time" name="hora" id="hora">
            <span id="errorHora" class="spam"></span>
            <br>
                </div>
            
                <div class="textfield">
            <%
                String cst = "SELECT * FROM atividade;";
                PreparedStatement sttm = conexao.prepareStatement(cst);
                ResultSet rs = sttm.executeQuery();
                while (rs.next()) {
                    String atividade = rs.getString("nome");
                    String atividade_id = rs.getString("id_ativ");
                %>
                    <input type="checkbox" name="atividade" value="<%= atividade_id %>"><%= atividade %><br>
                <% }%><br>
                </div>
            <input type="button" onclick="verificar()" value="Salvar">
        </form>
    </div>

    <script type="text/javascript" src="../../js/validacoes/organizador/evento.js"></script>
</body>

</html>
