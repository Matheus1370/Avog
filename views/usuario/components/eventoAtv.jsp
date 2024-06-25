<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@ include file="../../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="eventoAtv" class="evento">
    <%
        // Obter a data atual
        LocalDate currentDate = LocalDate.now();
        String date = currentDate.toString();
        java.sql.Date currentDateSql = java.sql.Date.valueOf(currentDate);

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
                    <% String sql3 = "SELECT * FROM usuarioevento where evento = ? and usuario = ?";
                            PreparedStatement pstmtt3 = conexao.prepareStatement(sql3);
                            int eventoid = Integer.parseInt(dados.getString("id_evento"));
                            int usuarioid = Integer.parseInt(session.getAttribute("usuario_id").toString());
                            pstmtt3.setInt(1, eventoid); 
                            pstmtt3.setInt(2, usuarioid); 
                            ResultSet rss3 = pstmtt3.executeQuery(); 
                            %>
                    <input type="hidden" name="id_evento" id="id_evento" value="<%= dados.getString("id_evento") %>">
                    <% if(rss3.next()){%>
                        <input type="submit" class="btn-login active" value="Participar">
                    <% }else{%>
                        <input type="submit" class="btn-login" value="Participar">
                    <% }%>
                </form>
            </div>
        <% } %>
    </div>
</div>