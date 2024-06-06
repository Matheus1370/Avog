<%@page language="java" import="java.sql.*" %>

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
