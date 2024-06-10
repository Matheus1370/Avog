<%@ page import="java.sql.*, java.time.*, java.util.*" %>
<%@ include file="../../db/conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if(session.getAttribute("organizador_id") == null ){response.sendRedirect("../../db/restrito.jsp");}%>
