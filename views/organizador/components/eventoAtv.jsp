<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@ include file="../../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="eventoAtv" class="evento">
    <%
        LocalDate currentDate = LocalDate.now();// Obter a data atual
        String date = currentDate.toString(); // Converter para String no formato YYYY-MM-DD
        String consulta = "select * from evento where data >= ?;";//Busca os eventos da data atual e datas seguintes
        PreparedStatement stm = conexao.prepareStatement(consulta);
        stm.setDate(1, java.sql.Date.valueOf(date));
        ResultSet dados = stm.executeQuery();
        SimpleDateFormat sdfFormatado = new SimpleDateFormat("dd/MM/yyyy");
    %>
    <div class="caixa">
        <% while(dados.next()) {
            //Formatando a data recuperada do banco
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
                    int idEvento = Integer.parseInt(dados.getString("id_evento"));
                    List<Integer> arrayFromDB = new ArrayList<>(); // Cria um array para armazenar a lista de atividades 
                    
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