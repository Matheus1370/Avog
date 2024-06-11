<%@ page import="java.sql.*, java.time.*, java.text.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if(session.getAttribute("usuario_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>

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
                    <li class="nav-item"><a href="perfil_usu.jsp" class="nav-link">Perfil</a></li>
                </ul>
            </div>

            <div class="login-button">
                <button><a href="../../db/logout.jsp">SAIR</a></button>
            </div>

            <div class="mobile-menu-icon">
                <button onclick="menuShow()"><img class="icon" src="../../source/icons/hamburgue.svg" alt=""></button>
            </div>
        </nav>
        <div class="mobile-menu">
            <ul>
                <li class="nav-item"><a href="perfil_usu.jsp" class="nav-link">Perfil</a></li>
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
                    <li class="nav-item"><a id="meu" href="#" onclick="selecao(event, 'meuEvento')">Meus Eventos</a></li>
                </ul>
            </div>
        </div>
        <div id="search"></div>
    </div>
    
    <div id="eventoAtv" class="evento">
        <%
            // Obter a data atual
            LocalDate currentDate = LocalDate.now();
            String date = currentDate.toString();

            String consulta = "SELECT * FROM evento WHERE data >= ?;";
            PreparedStatement stm = conexao.prepareStatement(consulta);
            stm.setDate(1, java.sql.Date.valueOf(date));
            ResultSet dados = stm.executeQuery();
            SimpleDateFormat sdfFormatado = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="caixa">
            <% while (dados.next()) { 
                String databanco = dados.getString("data");
                Date data = java.sql.Date.valueOf(databanco);
                String dataFormatada = sdfFormatado.format(data);%>
                <div class="card">
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
                    <form action="../../db/cadUsuEvento.jsp" method="post">
                        <input type="hidden" name="id_evento" id="id_evento" value="<%= dados.getString("id_evento") %>">
                        <button type="submit">Participar</button>
                    </form>
                </div>
            <% } %>
        </div>
    </div>

    <div id="eventoEnc" class="evento">
        <% 
            int usuarioId = Integer.parseInt(session.getAttribute("usuario_id").toString());

            // Consulta para buscar os eventos associados ao usuário
            String consulta2 = "SELECT * FROM usuarioevento WHERE usuario = ?;";
            PreparedStatement stm2 = conexao.prepareStatement(consulta2);
            stm2.setInt(1, usuarioId);
            ResultSet dados2 = stm2.executeQuery();

            String consulta3 = "SELECT * FROM evento WHERE id_evento = ? and data < ?;";
            PreparedStatement stm3 = conexao.prepareStatement(consulta3);
            stm3.setDate(2, java.sql.Date.valueOf(date));

            while (dados2.next()) {
                stm3.setInt(1, dados2.getInt("evento"));
                ResultSet dados3 = stm3.executeQuery();

                while (dados3.next()) {
                    String databanco2 = dados3.getString("data");
                    Date data2 = java.sql.Date.valueOf(databanco2);
                    String dataFormatada2 = sdfFormatado.format(data2);
        %>
                    <div class="caixa">
                        <div class="card">
                            <input type="hidden" name="id_evento" id="id_evento" value="<%= dados3.getString("id_evento") %>">
                            <p><%= dados3.getString("nome") %></p>
                            <p><%= dados3.getString("descricao") %></p>
                            <p><%= dataFormatada2 %></p>
                            <p><%= dados3.getString("hora") %></p>
                            <p>
                                <% 
                                    // Recuperar o ID do evento desejado
                                    int idEvento2 = Integer.parseInt(dados3.getString("id_evento")); // Neste caso, vamos supor que o ID do evento desejado seja 5
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
                    </div>
        <%
                }
            } 
        %>
    </div>

    <div id="meuEvento" class="evento">
        <%
            java.sql.Date currentDateSql = java.sql.Date.valueOf(currentDate);

            String consulta4 = "SELECT * FROM usuarioevento WHERE usuario = ?;";
            PreparedStatement stm4 = conexao.prepareStatement(consulta4);
            stm4.setInt(1, usuarioId);
            ResultSet dados4 = stm4.executeQuery();

            String consulta5 = "SELECT * FROM evento WHERE id_evento = ? and  data >= ?;";
            PreparedStatement stm5 = conexao.prepareStatement(consulta5);

            while (dados4.next()) {
                int id_evento = dados4.getInt("evento");
                stm5.setInt(1, id_evento);
                stm5.setDate(2, currentDateSql);
                ResultSet dados5 = stm5.executeQuery();

                while (dados5.next()) {
                    String databanco3 = dados5.getString("data");
                    Date data3 = java.sql.Date.valueOf(databanco3);
                    String dataFormatada3 = sdfFormatado.format(data3);
        %>
                    <div class="caixa">
                        <div class="card">
                            <input type="hidden" name="id_evento" id="id_evento" value="<%= dados5.getString("id_evento") %>">
                            <p><%= dados5.getString("nome") %></p>
                            <p><%= dados5.getString("descricao") %></p>
                            <p><%= dataFormatada3 %></p>
                            <p><%= dados5.getString("hora") %></p>
                            <p>
                                <% 
                                    // Recuperar o ID do evento desejado
                                    int idEvento3 = Integer.parseInt(dados5.getString("id_evento")); // Neste caso, vamos supor que o ID do evento desejado seja 5
                                    List<Integer> arrayFromDBME = new ArrayList<>();
                                    
                                    // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                                    String sqlME = "SELECT atividade FROM atividadeevento where evento = ?";
                                    PreparedStatement pstmttME = conexao.prepareStatement(sqlME);
                                    pstmttME.setInt(1, idEvento3); // Definir o ID do evento como parâmetro
                                    ResultSet rssME = pstmttME.executeQuery();
                                    
                                    while (rssME.next()) {
                                        String atividadeStringME = rssME.getString("atividade");
                                        // Remover os colchetes e quebrar a string em substrings separadas por vírgulas
                                        String[] elementosMEString = atividadeStringME.substring(1, atividadeStringME.length() - 1).split(",\\s*");
                                        // Converter substrings para inteiros
                                        for (String elementoMEString : elementosMEString) {
                                            arrayFromDBME.add(Integer.parseInt(elementoMEString));
                                        }
                                    }
                                %>

                                <ul style="list-style: none;">
                                <%
                                    // Iterar sobre a lista e exibir cada elemento em uma lista HTML
                                    for (Integer elementoME : arrayFromDBME) {
                                        int id_ativ3 = elementoME;
                                        // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                                        String sqlME2 = "SELECT * FROM atividade where id_ativ = ?";
                                        PreparedStatement pstmttME2 = conexao.prepareStatement(sqlME2);
                                        pstmttME2.setInt(1, id_ativ3); // Definir o ID da atividade como parâmetro
                                        ResultSet rssME2 = pstmttME2.executeQuery();
                                        while(rssME2.next()){
                                %>
                                            <li><%= rssME2.getString("nome") %></li>
                                <%
                                        }
                                        rssME2.close();
                                        pstmttME2.close();
                                    }
                                %>
                                </ul>

                                <%
                                    // Fechar os recursos (ResultSet e PreparedStatement)
                                    rssME.close();
                                    pstmttME.close();
                                %>
                            </p>
                        </div>
                    </div>
        <%
                }
            } 
        %>
    </div>

    <script type="text/javascript" src="../../js/validacoes/usuario/evento.js"></script>
</body>

</html>
