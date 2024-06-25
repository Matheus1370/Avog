<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@ include file="../../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="meuEvento" class="evento">
    <%
        int usuarioId = Integer.parseInt(session.getAttribute("usuario_id").toString());

        LocalDate currentDate = LocalDate.now();// Obter a data atual
        String date = currentDate.toString();// Converter para String no formato YYYY-MM-DD
        java.sql.Date currentDateSql = java.sql.Date.valueOf(currentDate);// Converter para a data para a linguagem SQL
        SimpleDateFormat sdfFormatado = new SimpleDateFormat("dd/MM/yyyy");// Converte para dd/MM/yyyy

        String consulta4 = "SELECT * FROM usuarioevento WHERE usuario = ?;";// Consulta para buscar os eventos associados ao usuário
        PreparedStatement stm4 = conexao.prepareStatement(consulta4);
        stm4.setInt(1, usuarioId);
        ResultSet dados4 = stm4.executeQuery();

        String consulta5 = "SELECT * FROM evento WHERE id_evento = ? and  data >= ?;";// consulta do evento que o usuário está cadastrado e ainda está ativo
        PreparedStatement stm5 = conexao.prepareStatement(consulta5);

        while (dados4.next()) {
            int id_evento = dados4.getInt("evento");
            stm5.setInt(1, id_evento);
            stm5.setDate(2, currentDateSql);
            ResultSet dados5 = stm5.executeQuery();

            while (dados5.next()) {
                //Formatando a data recuperada do banco
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