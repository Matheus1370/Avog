<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="conexao.jsp" %>

<%

    String vlogin = request.getParameter("email");
    String vsenha = request.getParameter("senha");

    String sql = "SELECT * FROM usuario WHERE email=? AND senha=?";
    // Cria o statement para executar o camando no banco
    PreparedStatement stm = conexao.prepareStatement( sql );
    stm.setString(1, vlogin) ;
    stm.setString(2, vsenha) ;
    ResultSet dados =  stm.executeQuery() ;

    String sql2 = "SELECT * FROM organizador WHERE email=? AND senha=?";
    // Cria o statement para executar o camando no banco
    PreparedStatement stm2 = conexao.prepareStatement( sql2 );
    stm2.setString(1, vlogin) ;
    stm2.setString(2, vsenha) ;
    ResultSet dados2 =  stm2.executeQuery() ;

    if(dados.next())
    {
       session.setAttribute( "usuario_id"  ,  dados.getString("id_usu")  ) ;
       session.setAttribute( "usuario_nome"  ,  dados.getString("nome")  ) ;
       response.sendRedirect("../views/usuario/perfil_usu.jsp");
    }else if(dados2.next())
    {
       session.setAttribute( "organizador_id"  ,  dados2.getString("id_org")  ) ;
       session.setAttribute( "organizador_nome"  ,  dados2.getString("nome")  ) ;
       response.sendRedirect("../views/organizador/perfil_org.jsp");
    }
    else
    {
        response.sendRedirect("../views/login.html?loginError=true");
    }

%>

