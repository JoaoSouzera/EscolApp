<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.escolApp.model.Aluno" %>
<%@ page import="com.escolApp.model.Professor" %>
<%@ page import="com.escolApp.model.Adm" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Painel Administrativo</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f0f2f5;
            display: flex;
        }

        .menu {
            width: 250px;
            background: #1e2b3f;
            color: white;
            min-height: 100vh;
            position: fixed;
            display: flex;
            flex-direction: column;
        }

        .menu h3 {
            padding: 20px;
            border-bottom: 1px solid #334155;
        }

        .menu .menu-items {
            flex: 1;
        }

        .menu a {
            display: block;
            padding: 12px 20px;
            color: #cbd5e1;
            text-decoration: none;
        }

        .menu a:hover {
            background: #253040;
            color: white;
        }

        .menu a i {
            width: 25px;
        }

        .divider {
            color: #8196b3;
            font-size: 12px;
            padding: 15px 20px 5px;
        }

        /* Botão de logout */
        .logout-btn {
            margin-top: auto;
            border-top: 1px solid #334155;
        }

        .logout-btn a {
            color: #ffb3b3;
        }

        .logout-btn a:hover {
            background: #3b2a2a;
            color: #ff6b6b;
        }

        .logout-btn i {
            color: #ff8a8a;
        }

        .conteudo {
            margin-left: 250px;
            padding: 25px;
            width: 100%;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin: 25px 0;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            flex: 1;
            min-width: 180px;
            display: flex;
            justify-content: space-between;
        }

        .card h4 {
            color: #5e6f8d;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .card .numero {
            font-size: 28px;
            font-weight: bold;
            color: #1e293b;
        }

        .card i {
            font-size: 35px;
            color: #b9c7e4;
        }

        .titulo {
            margin: 30px 0 15px;
            color: #1e2a44;
        }

        .msg {
            background: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .msg.erro {
            background: #f8d7da;
            color: #721c24;
        }

        .tabela-container {
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 10px;
            color: #52607a;
            border-bottom: 2px solid #e5ecf3;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #edf2f9;
        }

        .btn {
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            text-decoration: none;
            display: inline-block;
            margin-right: 3px;
        }

        .btn-edit { background: #ecf2fe; color: #3c66c5; }
        .btn-delete { background: #ffeaf1; color: #b91c4b; }
        .btn-novo { background: #e1e9fe; color: #344e9c; padding: 8px 15px; margin-bottom: 15px; display: inline-block; }

        input, select {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            width: 100%;
        }

        .form-container {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
        }

        .form-container h3 {
            margin-bottom: 15px;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .form-group label {
            display: block;
            margin-bottom: 3px;
            font-weight: bold;
            font-size: 13px;
        }
    </style>
</head>
<body>

<!-- MENU LATERAL -->
<div class="menu">
    <div class="menu-items">
        <h3><i class="fas fa-school"></i> EscolaApp</h3>
        <div class="divider">MENU</div>
        <a href="<%= request.getContextPath() %>/adm?acao=dashboard"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <div class="divider">CADASTROS</div>
        <a href="#admins"><i class="fas fa-user-shield"></i> Administradores</a>
        <a href="#professores"><i class="fas fa-user-tie"></i> Professores</a>
        <a href="#alunos"><i class="fas fa-user-graduate"></i> Alunos</a>
    </div>

    <!-- BOTÃO DE LOGOUT -->
    <div class="logout-btn">
        <a href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt"></i> Sair do Sistema</a>
    </div>
</div>

<!-- CONTEÚDO -->
<div class="conteudo">

    <!-- TÍTULO E MENSAGENS -->
    <h1>Dashboard Administrativo</h1>

    <% String msg = (String) session.getAttribute("msg");
        String tipoMsg = (String) session.getAttribute("tipoMsg");
        if(msg != null) {
            session.removeAttribute("msg");
            session.removeAttribute("tipoMsg");
    %>
    <div class="msg <%= tipoMsg != null ? tipoMsg : "" %>">
        <i class="fas fa-<%= tipoMsg != null && tipoMsg.equals("erro") ? "exclamation-circle" : "check-circle" %>"></i>
        <%= msg %>
    </div>
    <% } %>

    <!-- CARDS -->
    <div class="cards">
        <div class="card">
            <div><h4>Total Usuários</h4><span class="numero"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %></span></div>
            <i class="fas fa-users"></i>
        </div>
        <div class="card">
            <div><h4>Administradores</h4><span class="numero"><%= request.getAttribute("totalAdm") != null ? request.getAttribute("totalAdm") : 0 %></span></div>
            <i class="fas fa-user-shield"></i>
        </div>
        <div class="card">
            <div><h4>Professores</h4><span class="numero"><%= request.getAttribute("totalProf") != null ? request.getAttribute("totalProf") : 0 %></span></div>
            <i class="fas fa-user-tie"></i>
        </div>
        <div class="card">
            <div><h4>Alunos</h4><span class="numero"><%= request.getAttribute("totalAluno") != null ? request.getAttribute("totalAluno") : 0 %></span></div>
            <i class="fas fa-user-graduate"></i>
        </div>
    </div>

    <!-- FORMULÁRIOS DE INSERÇÃO (sempre visíveis) -->

    <!-- Inserir Administrador -->
    <div class="form-container" id="novoAdm">
        <h3><i class="fas fa-plus-circle"></i> Novo Administrador</h3>
        <form action="<%= request.getContextPath() %>/adm" method="post">
            <input type="hidden" name="acao" value="inserirUsuario">
            <input type="hidden" name="tipo" value="adm">
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Senha:</label>
                <input type="password" name="senha" required>
            </div>
            <button type="submit" class="btn btn-edit">Salvar</button>
        </form>
    </div>

    <!-- Inserir Professor -->
    <div class="form-container" id="novoProfessor">
        <h3><i class="fas fa-plus-circle"></i> Novo Professor</h3>
        <form action="<%= request.getContextPath() %>/adm" method="post">
            <input type="hidden" name="acao" value="inserirUsuario">
            <input type="hidden" name="tipo" value="professor">
            <div class="form-group">
                <label>Nome:</label>
                <input type="text" name="nomeProfessor" required>
            </div>
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="usernameProfessor" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="emailProfessor" required>
            </div>
            <div class="form-group">
                <label>Senha:</label>
                <input type="password" name="senhaProfessor" required>
            </div>
            <div class="form-group">
                <label>ID Disciplina:</label>
                <input type="number" name="idDisciplina" required>
            </div>
            <button type="submit" class="btn btn-edit">Salvar</button>
        </form>
    </div>

    <!-- Inserir Aluno -->
    <div class="form-container" id="novoAluno">
        <h3><i class="fas fa-plus-circle"></i> Novo Aluno</h3>
        <form action="<%= request.getContextPath() %>/adm" method="post">
            <input type="hidden" name="acao" value="inserirUsuario">
            <input type="hidden" name="tipo" value="aluno">
            <div class="form-group">
                <label>Matrícula:</label>
                <input type="text" name="matricula" required>
            </div>
            <div class="form-group">
                <label>Nome:</label>
                <input type="text" name="nome" required>
            </div>
            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Senha:</label>
                <input type="password" name="senha" required>
            </div>
            <button type="submit" class="btn btn-edit">Salvar</button>
        </form>
    </div>

    <!-- TABELA ADMINISTRADORES -->
    <h2 class="titulo" id="admins"><i class="fas fa-user-shield"></i> Administradores</h2>
    <div class="tabela-container">
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Ações</th>
            </tr>
            <%
                List<Adm> listaAdm = (List<Adm>) request.getAttribute("listaAdm");
                if(listaAdm != null) {
                    for(Adm a : listaAdm) {
            %>
            <tr>
                <td><%= a.getId() %></td>
                <td><%= a.getUsername() %></td>
                <td><%= a.getEmail() %></td>
                <td>
                    <!-- Form para editar (abre o formulário abaixo com os dados) -->
                    <button class="btn btn-edit" onclick="editarAdm('<%= a.getId() %>', '<%= a.getUsername() %>', '<%= a.getEmail() %>')">
                        <i class="fas fa-edit"></i> Editar
                    </button>

                    <!-- Form para excluir -->
                    <form action="<%= request.getContextPath() %>/adm" method="post" style="display:inline;">
                        <input type="hidden" name="acao" value="removerAdm">
                        <input type="hidden" name="id" value="<%= a.getId() %>">
                        <button type="submit" class="btn btn-delete" onclick="return confirm('Remover administrador?')">
                            <i class="fas fa-trash"></i> Excluir
                        </button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <!-- Formulário de edição de admin (escondido, aparece ao clicar em editar) -->
        <div id="formEditarAdm" style="display:none; margin-top:20px; padding:15px; background:#f0f0f0; border-radius:5px;">
            <h4>Editar Administrador</h4>
            <form action="<%= request.getContextPath() %>/adm" method="post">
                <input type="hidden" name="acao" value="editarAdm">
                <input type="hidden" name="idAdm" id="editAdmId">
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" name="username" id="editAdmUsername">
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" id="editAdmEmail">
                </div>
                <div class="form-group">
                    <label>Nova Senha (deixe em branco para não alterar):</label>
                    <input type="password" name="senha">
                </div>
                <button type="submit" class="btn btn-edit">Salvar</button>
                <button type="button" class="btn btn-delete" onclick="document.getElementById('formEditarAdm').style.display='none'">Cancelar</button>
            </form>
        </div>
    </div>

    <!-- TABELA PROFESSORES -->
    <h2 class="titulo" id="professores"><i class="fas fa-user-tie"></i> Professores</h2>
    <div class="tabela-container">
        <table>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Username</th>
                <th>Email</th>
                <th>ID Disciplina</th>
                <th>Ações</th>
            </tr>
            <%
                List<Professor> listaProf = (List<Professor>) request.getAttribute("listaProf");
                if(listaProf != null) {
                    for(Professor p : listaProf) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNome() %></td>
                <td><%= p.getUsername() %></td>
                <td><%= p.getEmail() %></td>
                <td><%= p.getIdDisciplina() %></td>
                <td>
                    <!-- Botão Editar Professor (abre formulário) -->
                    <button class="btn btn-edit" onclick="editarProf('<%= p.getId() %>', '<%= p.getSenha() %>')">
                        <i class="fas fa-edit"></i> Editar Senha
                    </button>

                    <!-- Form para excluir -->
                    <form action="<%= request.getContextPath() %>/adm" method="post" style="display:inline;">
                        <input type="hidden" name="acao" value="removerProfessor">
                        <input type="hidden" name="idProf" value="<%= p.getId() %>">
                        <button type="submit" class="btn btn-delete" onclick="return confirm('Remover professor?')">
                            <i class="fas fa-trash"></i> Excluir
                        </button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <!-- Formulário de edição de professor -->
        <div id="formEditarProf" style="display:none; margin-top:20px; padding:15px; background:#f0f0f0; border-radius:5px;">
            <h4>Editar Senha do Professor</h4>
            <form action="<%= request.getContextPath() %>/adm" method="post">
                <input type="hidden" name="acao" value="editarProfessor">
                <input type="hidden" name="idProf" id="editProfId">
                <div class="form-group">
                    <label>Nova Senha:</label>
                    <input type="password" name="senha" id="editProfSenha" required>
                </div>
                <button type="submit" class="btn btn-edit">Salvar</button>
                <button type="button" class="btn btn-delete" onclick="document.getElementById('formEditarProf').style.display='none'">Cancelar</button>
            </form>
        </div>
    </div>

    <!-- TABELA ALUNOS -->
    <h2 class="titulo" id="alunos"><i class="fas fa-user-graduate"></i> Alunos</h2>
    <div class="tabela-container">
        <table>
            <tr>
                <th>ID</th>
                <th>Matrícula</th>
                <th>Nome</th>
                <th>Username</th>
                <th>Email</th>
                <th>Ações</th>
            </tr>
            <%
                List<Aluno> listaAluno = (List<Aluno>) request.getAttribute("listaAluno");
                if(listaAluno != null) {
                    for(Aluno a : listaAluno) {
            %>
            <tr>
                <td><%= a.getId() %></td>
                <td><%= a.getMatricula() %></td>
                <td><%= a.getNome() %></td>
                <td><%= a.getUsername() %></td>
                <td><%= a.getEmail() %></td>
                <td>
                    <!-- Botão Editar Aluno (abre formulário) -->
                    <button class="btn btn-edit" onclick="editarAluno('<%= a.getId() %>', '<%= a.getNome() %>', '<%= a.getUsername() %>', '<%= a.getEmail() %>', '<%= a.getMatricula() %>')">
                        <i class="fas fa-edit"></i> Editar
                    </button>
                    <!-- Form para excluir -->
                    <form action="<%= request.getContextPath() %>/adm" method="post" style="display:inline;">
                        <input type="hidden" name="acao" value="removerAluno">
                        <input type="hidden" name="idAluno" value="<%= a.getId() %>">
                        <button type="submit" class="btn btn-delete" onclick="return confirm('Remover aluno?')">
                            <i class="fas fa-trash"></i> Excluir
                        </button>
                    </form>

                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <!-- Formulário de edição de aluno -->
        <div id="formEditarAluno" style="display:none; margin-top:20px; padding:15px; background:#f0f0f0; border-radius:5px;">
            <h4>Editar Aluno</h4>
            <form action="<%= request.getContextPath() %>/adm" method="post">
                <input type="hidden" name="acao" value="editarAluno">
                <input type="hidden" name="idAluno" id="editAlunoId">
                <div class="form-group">
                    <label>Matrícula:</label>
                    <input type="text" name="matricula" id="editAlunoMatricula" required>
                </div>
                <div class="form-group">
                    <label>Nome:</label>
                    <input type="text" name="nome" id="editAlunoNome" required>
                </div>
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" name="username" id="editAlunoUsername" required>
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" id="editAlunoEmail" required>
                </div>
                <div class="form-group">
                    <label>Nova Senha (deixe em branco para não alterar):</label>
                    <input type="password" name="senha">
                </div>
                <button type="submit" class="btn btn-edit">Salvar</button>
                <button type="button" class="btn btn-delete" onclick="document.getElementById('formEditarAluno').style.display='none'">Cancelar</button>
            </form>
        </div>
    </div>

    <div style="text-align:center; color:#999; margin-top:30px;">
        Painel Administrativo
    </div>
</div>

<script>
    // Funções para editar (só preenchem os formulários)
    function editarAdm(id, username, email) {
        document.getElementById('editAdmId').value = id;
        document.getElementById('editAdmUsername').value = username;
        document.getElementById('editAdmEmail').value = email;
        document.getElementById('formEditarAdm').style.display = 'block';
    }

    function editarProf(id, senha) {
        document.getElementById('editProfId').value = id;
        document.getElementById('editProfSenha').value = '';
        document.getElementById('formEditarProf').style.display = 'block';
    }

    function editarAluno(id, nome, username, email, matricula) {
        document.getElementById('editAlunoId').value = id;
        document.getElementById('editAlunoNome').value = nome;
        document.getElementById('editAlunoUsername').value = username;
        document.getElementById('editAlunoEmail').value = email;
        document.getElementById('editAlunoMatricula').value = matricula;
        document.getElementById('formEditarAluno').style.display = 'block';
    }
</script>

</body>
</html>