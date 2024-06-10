<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
    // cria as variáveis das informações

    int usuarioId = Integer.parseInt(session.getAttribute("usuario_id").toString());
    int vevento = Integer.parseInt(request.getParameter("id_evento"));

    String sql = "insert into usuarioevento (usuario, evento) values (?,?);";

    PreparedStatement stm = conexao.prepareStatement(sql);

    stm.setInt( 1, usuarioId );
    stm.setInt( 2, vevento );

    stm.execute();
    // Recupera o ID do evento recém-inserido
    ResultSet rs = stm.getGeneratedKeys();
    if (rs.next()) {
        novoID = rs.getInt(1);
    }

    // Fecha os recursos
    rs.close();
    stm.close();
    response.sendRedirect("../views/usuario/evento.jsp");
%>