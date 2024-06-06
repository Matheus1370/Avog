<%@page language="java" import="java.sql.*" %>
<%
    //variaveis para o banco de dados
    String banco    = "web" ;
    String endereco = "jdbc:mysql://localhost:3306/"+banco;
    String usuario  = "root";
    String senha    = "" ;
    //Variavel para o Driver
    String driver = "com.mysql.jdbc.Driver" ;
    //Carregar o driver na memória
    Class.forName( driver ) ;
    //Cria a variavel para conectar com o banco de dados
     Connection conexao ;
    //Abrir a conexao com o banco de dados
    conexao = DriverManager.getConnection(endereco, usuario, senha) ;
    String sql = "insert into usuario (nome, email, senha) values (?,?,?);";
    
    // cria as variáveis das informações
    String vnome = request.getParameter("nome");
    String vemail = request.getParameter("email");
    String vsenha = request.getParameter("senha");   

    PreparedStatement stm = conexao.prepareStatement(sql);

    stm.setString( 1, vnome );
    stm.setString( 2, vemail );
    stm.setString( 3, vsenha );

    stm.execute();
    if(stm.execute())
    {
        stm.close();
        response.sendRedirect("/views/cadastro.html");
    }
    stm.close();
    
%>