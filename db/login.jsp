<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
    String vlogin = request.getParameter("txtLogin");
    String vsenha = request.getParameter("txtSenha");

    String sql = "SELECT * FROM usuario WHERE login=? AND senha=?";

    // Cria o statement para executar o camando no banco
    PreparedStatement stm = conexao.prepareStatement( sql );

    stm.setString(1, vlogin) ;
    stm.setString(2, vsenha) ;

    ResultSet dados =  stm.executeQuery() ;

    if(dados.next())
    {
       session.setAttribute( "usuario"  ,  dados.getString("nome")  ) ;
       response.sendRedirect("consulta2.jsp");
    }
    else
    {
        out.print("Login incorreto");
    }

%>
