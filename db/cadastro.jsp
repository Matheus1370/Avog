<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // cria as variáveis das informações
    String vnome = request.getParameter("nome");
    String vemail = request.getParameter("email");
    String vsenha = request.getParameter("senha");  

    String sql = "insert into usuario (nome, email, senha) values (?,?,?);";
    PreparedStatement stm = conexao.prepareStatement(sql);

    stm.setString( 1, vnome );
    stm.setString( 2, vemail );
    stm.setString( 3, vsenha );

    stm.execute();
    stm.close();
    response.sendRedirect("../views/cadastro.html");
    
%>