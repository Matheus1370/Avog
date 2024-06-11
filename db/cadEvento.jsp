<%@ page import="java.sql.*, java.time.*, java.time.format.*, java.util.*" %>
<%@ include file="conexao.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% 
    // Recupera os dados enviados pelo formulário
    int organizadorid = Integer.parseInt(session.getAttribute("organizador_id").toString());
    String nome = request.getParameter("nome");
    String descricao = request.getParameter("descricao");
    String data = request.getParameter("data");
    String hora = request.getParameter("hora");
    String[] atividadesSelecionadas = request.getParameterValues("atividade");

    // Variável para armazenar o ID do evento
    int novoID = -1;

    // Cria o comando SQL para inserir os dados na tabela evento
    String sql = "INSERT INTO evento (nome, descricao, data, hora) VALUES (?, ?, ?, ?)";
    PreparedStatement stm = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

    // Define os parâmetros do comando SQL
    stm.setString(1, nome);
    stm.setString(2, descricao);

    // Converte a string de data para o formato "AAAA-MM-DD"
    LocalDate localDate = LocalDate.parse(data);
    stm.setDate(3, java.sql.Date.valueOf(localDate));

    // Adiciona os segundos ao valor da hora
    hora += ":00";
    stm.setTime(4, java.sql.Time.valueOf(hora));

    // Executa o comando SQL
    stm.executeUpdate();

    // Recupera o ID do evento recém-inserido
    ResultSet rs = stm.getGeneratedKeys();
    if (rs.next()) {
        novoID = rs.getInt(1);
    }

    // Fecha os recursos
    rs.close();
    stm.close();

    // Cria o comando SQL para inserir os dados na tabela organizadorevento
    String sql2 = "INSERT INTO organizadorevento (organizador, evento) VALUES (?, ?)";
    PreparedStatement stmAssociada = conexao.prepareStatement(sql2);

    // Define os parâmetros do comando SQL
    stmAssociada.setInt(1, organizadorid); 
    stmAssociada.setInt(2, novoID);

    // Executa o comando SQL para a tabela associada
    stmAssociada.execute();

    // Fecha o PreparedStatement
    stmAssociada.close();

    // Converte os IDs das atividades para inteiros
    int[] idsAtividades = new int[atividadesSelecionadas.length];
    for (int i = 0; i < atividadesSelecionadas.length; i++) {
        idsAtividades[i] = Integer.parseInt(atividadesSelecionadas[i]);
    }
    // Montar a lista de atividades selecionadas como uma string
   // Constrói a string do array para inserção
    StringBuilder arrayString = new StringBuilder();
    arrayString.append("[");
    for (int i = 0; i < idsAtividades.length; i++) {
        arrayString.append(idsAtividades[i]);
        if (i < idsAtividades.length - 1) {
            arrayString.append(",");
        }
    }
    arrayString.append("]");
    
    // Query SQL para inserção
    String sql3 = "INSERT INTO atividadeevento (atividade, evento) VALUES (?, ?)";
    PreparedStatement pstmt = conexao.prepareStatement(sql3);
    pstmt.setString(1, arrayString.toString());
    pstmt.setInt(2, novoID);
    
    // Executa a inserção
    pstmt.executeUpdate();
    pstmt.close();

    response.sendRedirect("../views/organizador/evento.jsp");
%>
