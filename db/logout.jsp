<%

  if( session != null ){
    session.invalidate() ;
    response.sendRedirect("../views/login2.html");
  }
%>