<%@ page import="java.util.List" %>
<%@ page import="com.escolApp.model.Adm" %>
<%@ page import="com.escolApp.model.Professor" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Dashboard - Administração</title>
</head>
<body>

<h1>📊 Painel Administrativo</h1>
<%
    Adm usuario = (Adm) session.getAttribute("admLogado");
%>

<div style="background:#eee; padding:10px;">
    <% if (usuario != null) { %>
    👤 Bem-vindo, <strong><%= usuario.getUsername() %></strong>
    | <a href="${pageContext.request.contextPath}/logout">Sair</a>
    <% } %>
</div>

<h2>Resumo</h2>
<p>Total de Administradores: <strong>${totalAdm}</strong></p>
<p>Total de Professores: <strong>${totalProf}</strong></p>
<hr>
<!-- 🔥 FORMULÁRIO DINÂMICO (INSERIR AQUI) -->
<h2>➕ Cadastrar Usuário</h2>

<form action="${pageContext.request.contextPath}/adm" method="post">
    <input type="hidden" name="acao" value="inserirUsuario">
    <label>Tipo de usuário:</label>
    <select id="tipoUsuario" name="tipo" onchange="mostrarCampos()" required>
        <option value="">Selecione</option>
        <option value="adm">Administrador</option>
        <option value="professor">Professor</option>
        <option value="aluno">Aluno</option>
    </select>

    <!-- ADM -->
    <div id="formAdm" style="display:none;">
        <h3>Administrador</h3>
        Username: <input name="username"><br>
        Email: <input name="email"><br>
        Senha: <input name="senha" type="password"><br>
    </div>

    <!-- PROFESSOR -->
    <div id="formProfessor" style="display:none;">
        <h3>Professor</h3>
        Nome: <input name="nomeProfessor"><br>
        Username: <input name="usernameProfessor"><br>
        Email: <input name="emailProfessor"><br>
        Senha: <input name="senhaProfessor"><br>
        Id da Disciplina: <input name="idDisciplina"><br>
    </div>

    <!-- ALUNO -->
    <div id="formAluno" style="display:none;">
        <h3>Aluno</h3>
        Nome: <input name="nomeAluno"><br>
        Matrícula: <input name="matricula"><br>
        Turma: <input name="turma"><br>
    </div>

    <br>
    <button type="submit">Salvar</button>
</form>

<hr>


<h2>Administradores cadastrados</h2>

<%
    List<Adm> lista = (List<Adm>) request.getAttribute("listaAdm");
    if (lista != null && !lista.isEmpty()) {
%>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Ações</th>
    </tr>

    <%
        for (Adm adm : lista) {
    %>
    <tr>
        <td><%= adm.getId() %></td>
        <td><%= adm.getUsername() %></td>
        <td><%= adm.getEmail() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/adm?acao=editar&id=<%= adm.getId() %>">✏️ Editar</a>
            |
            <a href="${pageContext.request.contextPath}/adm?acao=remover&id=<%= adm.getId() %>"
               onclick="return confirm('Deseja remover este administrador?')">
                🗑️ Remover
            </a>
        </td>
    </tr>
    <%
        }
    %>

</table>
<%
    } else{
%>
<p>Nenhum administrador cadastrado.</p>
<%
    }
%>
<h2>Professores cadastrados</h2>

<%
    List<Professor> professores = (List<Professor>) request.getAttribute("listaProf");
    if (professores != null && !professores.isEmpty()){
%>
<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Username</th>
        <th>Email</th>
        <th>Senha</th>
        <th>ID_Disciplina</th>
        <th>Ações</th>
    </tr>
        <%
        for (Professor prof : professores) {
    %>
    <tr>
        <td><%= prof.getId() %></td>
        <td><%= prof.getNome() %></td>
        <td><%= prof.getUsername() %></td>
        <td><%= prof.getEmail() %></td>
        <td><%= prof.getSenha() %></td>
        <td><%= prof.getIdDisciplina() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/adm?acao=editar&id=<%= prof.getId() %>">✏️ Editar</a>
            |
            <a href="${pageContext.request.contextPath}/adm?acao=remover&id=<%= prof.getId() %>"
               onclick="return confirm('Deseja remover este administrador?')">
                🗑️ Remover
            </a>
        </td>
    </tr>
        <%
        }
    %>
<%
} else {
%>

<p>Nenhum professor cadastrado.</p>
        <%
    }
%>

<!-- 🔥 SCRIPT SEMPRE NO FINAL DO BODY -->
<script>
    function mostrarCampos() {
        const tipo = document.getElementById("tipoUsuario").value;

        document.getElementById("formAdm").style.display = "none";
        document.getElementById("formProfessor").style.display = "none";
        document.getElementById("formAluno").style.display = "none";

        if (tipo === "adm") {
            document.getElementById("formAdm").style.display = "block";
        }
        else if (tipo === "professor") {
            document.getElementById("formProfessor").style.display = "block";
        }
        else if (tipo === "aluno") {
            document.getElementById("formAluno").style.display = "block";
        }
    }
</script>
</body>
</html>
