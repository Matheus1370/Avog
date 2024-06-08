<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="../../db/conexao.jsp" %>
<% if(session.getAttribute("organizador_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>
