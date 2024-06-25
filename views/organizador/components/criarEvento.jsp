<%@ page import="java.sql.*, java.time.*, java.text.*, java.util.List, java.util.Arrays, java.util.ArrayList" %>
<%@ include file="../../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            
                <div class="wrapper">
            <%
                String cst = "SELECT * FROM atividade;";
                PreparedStatement sttm = conexao.prepareStatement(cst);
                ResultSet rs = sttm.executeQuery();
                while (rs.next()) {
                    String atividade = rs.getString("nome");
                    String atividade_id = rs.getString("id_ativ");
                %>
                    <div class="form-group">
                        <input type="checkbox" class="checkbox" id="checkbox<%= atividade_id %>" name="atividade" value="<%= atividade_id %>"/>
                        <label for="checkbox<%= atividade_id %>"><%= atividade %></label>
                    </div>
                <% }%><br>
                </div>
            <input type="button" onclick="verificar()" value="Salvar">
        </form>
    </div>