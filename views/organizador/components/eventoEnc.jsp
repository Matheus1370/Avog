<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@ include file="../../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="eventoEnc" class="evento">
    <%
        LocalDate currentDate = LocalDate.now();// Obter a data atual
        String date = currentDate.toString(); // Converter para String no formato YYYY-MM-DD

        String consulta2 = "select * from evento where data < ?;";//Busca os eventos de datas anteriores
        PreparedStatement stm2 = conexao.prepareStatement(consulta2);
        stm2.setDate(1, java.sql.Date.valueOf(date));
        ResultSet dados2 = stm2.executeQuery();
        SimpleDateFormat sdfFormatado = new SimpleDateFormat("dd/MM/yyyy");
    %>
    <div class="caixa">
        <% while(dados2.next()) { 
            //Formatando a data recuperada do banco
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
                        int idEvento2 = Integer.parseInt(dados2.getString("id_evento")); 
                        List<Integer> arrayFromDBEnc = new ArrayList<>();// Cria um array para armazenar a lista de atividades
                        
                        // Consulta SQL para recuperar os nomes das atividades associadas ao evento
                        String sqlEnc = "SELECT atividade FROM atividadeevento where evento = ?";
                        PreparedStatement pstmttEnc = conexao.prepareStatement(sqlEnc);
                        pstmttEnc.setInt(1, idEvento2);
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