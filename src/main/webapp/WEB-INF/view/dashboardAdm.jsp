<%@ page import="java.util.List" %>
<%@ page import="com.escolApp.model.Adm" %>
<%@ page import="com.escolApp.model.Professor" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Dashboard - Administração</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Fonte moderna (Google Fonts) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz@14..32&display=swap" rel="stylesheet">
    <!-- Chart.js para gráficos -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f5f9ff;
            color: #1e2b3c;
            padding: 24px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Container principal */
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* Cabeçalho */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 16px 24px;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 30, 60, 0.08);
            margin-bottom: 32px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 600;
            color: #0a3b5c;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
            background: #eef4fa;
            padding: 8px 16px;
            border-radius: 40px;
        }

        .user-info span {
            color: #1a4972;
            font-weight: 500;
        }

        .logout-link {
            background: #d4e0f0;
            color: #0f3b6a;
            text-decoration: none;
            padding: 6px 16px;
            border-radius: 30px;
            font-weight: 500;
            transition: 0.2s;
        }

        .logout-link:hover {
            background: #b8cbe0;
        }

        /* Cards de resumo */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 6px 18px rgba(0, 45, 80, 0.06);
            border: 1px solid #e2edff;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 65, 131, 0.12);
        }

        .card-title {
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #5e7a99;
            margin-bottom: 8px;
        }

        .card-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #0b4f8c;
        }

        /* Feedback (toast) */
        #feedback {
            position: fixed;
            top: 24px;
            right: 24px;
            padding: 14px 24px;
            border-radius: 40px;
            color: white;
            font-weight: 500;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            z-index: 1000;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Seções */
        .section {
            background: white;
            border-radius: 24px;
            padding: 24px;
            margin-bottom: 40px;
            box-shadow: 0 6px 16px rgba(0, 40, 80, 0.05);
            border: 1px solid #deecfd;
        }

        .section h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #113755;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 2px solid #cde1f5;
            padding-bottom: 12px;
        }

        /* Formulário */
        .form-cadastro {
            background: #f9fcff;
            border-radius: 20px;
            padding: 20px;
            border: 1px solid #cde1f5;
        }

        .form-row {
            margin-bottom: 20px;
        }

        .form-row label {
            display: block;
            font-weight: 500;
            color: #1d4e7c;
            margin-bottom: 6px;
        }

        select, input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #c2d6ec;
            border-radius: 14px;
            font-size: 1rem;
            transition: 0.2s;
            background: white;
        }

        select:focus, input:focus {
            outline: none;
            border-color: #1e7ac5;
            box-shadow: 0 0 0 3px rgba(23, 115, 230, 0.15);
        }

        .btn {
            background: #1976D2;
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: 0.2s;
            border: 1px solid transparent;
        }

        .btn:hover {
            background: #0f5fb0;
            transform: scale(1.02);
        }

        .btn-excluir {
            background: #dc3545;
        }

        .btn-excluir:hover {
            background: #b02a37;
        }

        /* Campos dinâmicos */
        .dynamic-form {
            background: #e9f2fc;
            border-radius: 18px;
            padding: 20px;
            margin-top: 16px;
            border-left: 4px solid #1976D2;
        }

        .dynamic-form h3 {
            color: #0b3d66;
            margin-bottom: 16px;
            font-size: 1.2rem;
        }

        .dynamic-form input {
            background: white;
            margin-bottom: 12px;
        }

        /* Tabelas */
        .table-responsive {
            overflow-x: auto;
            border-radius: 18px;
            border: 1px solid #d6e5f5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            min-width: 800px;
        }

        th {
            background: #e2edfe;
            color: #1a4b77;
            font-weight: 600;
            padding: 16px 12px;
            text-align: left;
        }

        td {
            padding: 14px 12px;
            border-bottom: 1px solid #ddeeff;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background: #f2f8ff;
        }

        td input {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #bcd0e9;
            border-radius: 10px;
            background: #fbfeff;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-tabela {
            background: transparent;
            border: none;
            font-size: 1.2rem;
            cursor: pointer;
            padding: 6px 10px;
            border-radius: 30px;
            transition: 0.2s;
        }

        .btn-tabela.editar {
            color: #1b6ec2;
        }
        .btn-tabela.excluir {
            color: #dc3545;
        }
        .btn-tabela:hover {
            background: #e4edf9;
        }

        /* Gráfico */
        .grafico-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px 0;
        }

        hr {
            display: none;
        }
    </style>
</head>
<body>
<div class="dashboard-container">

    <!-- Mensagem de feedback (toast) -->
    <%
        String msg = (String) session.getAttribute("msg");
        String tipo = (String) session.getAttribute("tipoMsg");
        if (msg != null) {
    %>
    <div id="feedback" style="background-color: <%= "sucesso".equals(tipo) ? "#28a745" : "#dc3545" %>;">
        <%= msg %>
    </div>
    <script>
        setTimeout(() => {
            const msg = document.getElementById("feedback");
            if (msg) msg.style.display = "none";
        }, 3000);
    </script>
    <%
            session.removeAttribute("msg");
            session.removeAttribute("tipoMsg");
        }
    %>

    <!-- Cabeçalho com boas-vindas -->
    <div class="header">
        <h1>📘 Painel Administrativo</h1>
        <%
            Adm usuario = (Adm) session.getAttribute("admLogado");
            if (usuario != null) {
        %>
        <div class="user-info">
            <span>👤 <%= usuario.getUsername() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Sair</a>
        </div>
        <% } %>
    </div>

    <!-- Cards de resumo -->
    <div class="cards-grid">
        <div class="card">
            <div class="card-title">Total de usuários</div>
            <div class="card-value">${totalUsers}</div>
        </div>
        <div class="card">
            <div class="card-title">Administradores</div>
            <div class="card-value">${totalAdm}</div>
        </div>
        <div class="card">
            <div class="card-title">Professores</div>
            <div class="card-value">${totalProf}</div>
        </div>
    </div>

    <!-- Gráfico de distribuição de usuários -->
    <div class="section">
        <h2>📊 Distribuição de Usuários</h2>
        <div class="grafico-container">
            <canvas id="graficoUsuarios" width="400" height="400"></canvas>
        </div>
    </div>

    <!-- Seção de cadastro -->
    <div class="section">
        <h2>➕ Cadastrar Usuário</h2>
        <div class="form-cadastro">
            <form action="${pageContext.request.contextPath}/adm" method="post">
                <input type="hidden" name="acao" value="inserirUsuario">
                <div class="form-row">
                    <label for="tipoUsuario">Tipo de usuário:</label>
                    <select id="tipoUsuario" name="tipo" onchange="mostrarCampos()" required>
                        <option value="">Selecione</option>
                        <option value="adm">Administrador</option>
                        <option value="professor">Professor</option>
                        <option value="aluno">Aluno</option>
                    </select>
                </div>

                <!-- Formulários dinâmicos -->
                <div id="formAdm" class="dynamic-form" style="display:none;">
                    <h3>Administrador</h3>
                    <input name="username" placeholder="Username"><br>
                    <input name="email" type="email" placeholder="E-mail"><br>
                    <input name="senha" type="password" placeholder="Senha"><br>
                </div>

                <div id="formProfessor" class="dynamic-form" style="display:none;">
                    <h3>Professor</h3>
                    <input name="nomeProfessor" placeholder="Nome completo"><br>
                    <input name="usernameProfessor" placeholder="Username"><br>
                    <input name="emailProfessor" type="email" placeholder="E-mail"><br>
                    <input name="senhaProfessor" type="password" placeholder="Senha"><br>
                    <input name="idDisciplina" placeholder="ID da Disciplina"><br>
                </div>

                <div id="formAluno" class="dynamic-form" style="display:none;">
                    <h3>Aluno</h3>
                    <input name="nomeAluno" placeholder="Nome"><br>
                    <input name="matricula" placeholder="Matrícula"><br>
                    <input name="turma" placeholder="Turma"><br>
                </div>

                <button type="submit" class="btn" style="margin-top: 20px;">Salvar</button>
            </form>
        </div>
    </div>

    <!-- Tabela de Administradores -->
    <div class="section">
        <h2>👥 Administradores cadastrados</h2>
        <%
            List<Adm> lista = (List<Adm>) request.getAttribute("listaAdm");
            if (lista != null && !lista.isEmpty()) {
        %>
        <div class="table-responsive">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Senha</th>
                    <th>Editar</th>
                    <th>Excluir</th>
                </tr>
                </thead>
                <tbody>
                <% for (Adm adm : lista) { %>
                <tr>
                    <form action="${pageContext.request.contextPath}/adm" method="post">
                        <td><%= adm.getId() %><input type="hidden" name="idAdm" value="<%= adm.getId() %>"></td>
                        <td><input type="text" name="username" value="<%= adm.getUsername() %>"></td>
                        <td><input type="email" name="email" value="<%= adm.getEmail() %>"></td>
                        <td><input type="password" name="senha" placeholder="Nova senha"></td>
                        <td>
                            <input type="hidden" name="acao" value="editarAdm">
                            <button type="submit" class="btn-tabela editar" title="Salvar alterações">💾</button>
                        </td>
                    </form>
                    <td>
                        <form action="${pageContext.request.contextPath}/adm" method="post" style="display:inline;">
                            <input type="hidden" name="acao" value="removerAdm">
                            <input type="hidden" name="id" value="<%= adm.getId() %>">
                            <button type="submit" class="btn-tabela excluir" onclick="return confirm('Tem certeza que deseja excluir?')" title="Excluir">🗑️</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p style="color: #5e7a99;">Nenhum administrador cadastrado.</p>
        <% } %>
    </div>

    <!-- Tabela de Professores -->
    <div class="section">
        <h2>👩‍🏫 Professores cadastrados</h2>
        <%
            List<Professor> professores = (List<Professor>) request.getAttribute("listaProf");
            if (professores != null && !professores.isEmpty()) {
        %>
        <div class="table-responsive">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Senha</th>
                    <th>ID_Disciplina</th>
                    <th>Editar</th>
                    <th>Excluir</th>
                </tr>
                </thead>
                <tbody>
                <% for (Professor prof : professores) { %>
                <tr>
                    <form action="${pageContext.request.contextPath}/adm" method="post">
                        <td><%= prof.getId() %><input type="hidden" name="idProf" value="<%= prof.getId() %>"></td>
                        <td><input type="text" name="nome" value="<%= prof.getNome() %>"></td>
                        <td><input type="text" name="username" value="<%= prof.getUsername() %>"></td>
                        <td><input type="email" name="email" value="<%= prof.getEmail() %>"></td>
                        <td><input type="password" name="senha" placeholder="Nova senha"></td>
                        <td><input type="text" name="idDisciplina" value="<%= prof.getIdDisciplina() %>"></td>
                        <td>
                            <input type="hidden" name="acao" value="editarProfessor">
                            <button type="submit" class="btn-tabela editar" title="Salvar alterações">💾</button>
                        </td>
                    </form>
                    <td>
                        <form action="${pageContext.request.contextPath}/adm" method="post" style="display:inline;">
                            <input type="hidden" name="acao" value="removerProfessor">
                            <input type="hidden" name="idProf" value="<%= prof.getId() %>">
                            <button type="submit" class="btn-tabela excluir" onclick="return confirm('Tem certeza que deseja excluir?')" title="Excluir">🗑️</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p style="color: #5e7a99;">Nenhum professor cadastrado.</p>
        <% } %>
    </div>
</div>

<!-- Script para exibir/ocultar formulários (original) -->
<script>
    function mostrarCampos() {
        const tipo = document.getElementById("tipoUsuario").value;
        document.getElementById("formAdm").style.display = "none";
        document.getElementById("formProfessor").style.display = "none";
        document.getElementById("formAluno").style.display = "none";

        if (tipo === "adm") {
            document.getElementById("formAdm").style.display = "block";
        } else if (tipo === "professor") {
            document.getElementById("formProfessor").style.display = "block";
        } else if (tipo === "aluno") {
            document.getElementById("formAluno").style.display = "block";
        }
    }
</script>

<!-- Script para gerar o gráfico -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Recupera os valores das variáveis disponíveis no JSP (EL)
        const totalAdm = ${totalAdm != null ? totalAdm : 0};
        const totalProf = ${totalProf != null ? totalProf : 0};
        const totalUsers = ${totalUsers != null ? totalUsers : 0};
        const totalAlunos = totalUsers - totalAdm - totalProf; // calcula alunos (se houver)

        // Garante que não haja valor negativo (caso haja inconsistência)
        const alunos = totalAlunos > 0 ? totalAlunos : 0;

        const ctx = document.getElementById('graficoUsuarios').getContext('2d');
        new Chart(ctx, {
            type: 'pie', // pode ser 'doughnut' ou 'bar' se preferir
            data: {
                labels: ['Administradores', 'Professores', 'Alunos'],
                datasets: [{
                    data: [totalAdm, totalProf, alunos],
                    backgroundColor: ['#1976D2', '#42A5F5', '#90CAF9'],
                    borderColor: '#ffffff',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { color: '#1e2b3c', font: { size: 14 } }
                    },
                    tooltip: { enabled: true }
                }
            }
        });
    });
</script>
</body>
</html>
<%--<%@ page import="java.util.List" %>--%>
<%--<%@ page import="com.escolApp.model.Adm" %>--%>
<%--<%@ page import="com.escolApp.model.Professor" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" %>--%>

<%--<html>--%>
<%--<head>--%>
<%--    <title>Dashboard - Administração</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--<h1>📊 Painel Administrativo</h1>--%>
<%--<%--%>
<%--    String msg = (String) session.getAttribute("msg");--%>
<%--    String tipo = (String) session.getAttribute("tipoMsg");--%>

<%--    if (msg != null) {--%>
<%--%>--%>
<%--<div id="feedback"--%>
<%--     style="padding:10px; margin:10px 0;--%>
<%--             border-radius:5px;--%>
<%--             color:white;--%>
<%--             background-color:<%= "sucesso".equals(tipo) ? "#28a745" : "#dc3545" %>;">--%>
<%--    <%= msg %>--%>
<%--</div>--%>

<%--<script>--%>
<%--    setTimeout(() => {--%>
<%--        const msg = document.getElementById("feedback");--%>
<%--        if (msg) msg.style.display = "none";--%>
<%--    }, 3000); // desaparece em 3 segundos--%>
<%--</script>--%>
<%--<%--%>
<%--        session.removeAttribute("msg");--%>
<%--        session.removeAttribute("tipoMsg");--%>
<%--    }--%>
<%--%>--%>
<%--<%--%>
<%--    Adm usuario = (Adm) session.getAttribute("admLogado");--%>
<%--%>--%>

<%--<div style="background:#eee; padding:10px;">--%>
<%--    <% if (usuario != null) { %>--%>
<%--    👤 Bem-vindo, <strong><%= usuario.getUsername() %></strong>--%>
<%--    | <a href="${pageContext.request.contextPath}/logout">Sair</a>--%>
<%--    <% } %>--%>
<%--</div>--%>


<%--<h2>Resumo</h2>--%>
<%--<p>Total de Usuários: <strong>${totalUsers}</strong></p>--%>
<%--<p>Total de Administradores: <strong>${totalAdm}</strong></p>--%>
<%--<p>Total de Professores: <strong>${totalProf}</strong></p>--%>
<%--<hr>--%>
<%--<!-- 🔥 FORMULÁRIO DINÂMICO (INSERIR AQUI) -->--%>
<%--<h2>➕ Cadastrar Usuário</h2>--%>

<%--<form action="${pageContext.request.contextPath}/adm" method="post">--%>
<%--    <input type="hidden" name="acao" value="inserirUsuario">--%>
<%--    <label>Tipo de usuário:</label>--%>
<%--    <select id="tipoUsuario" name="tipo" onchange="mostrarCampos()" required>--%>
<%--        <option value="">Selecione</option>--%>
<%--        <option value="adm">Administrador</option>--%>
<%--        <option value="professor">Professor</option>--%>
<%--        <option value="aluno">Aluno</option>--%>
<%--    </select>--%>

<%--    <!-- ADM -->--%>
<%--    <div id="formAdm" style="display:none;">--%>
<%--        <h3>Administrador</h3>--%>
<%--        Username: <input name="username"><br>--%>
<%--        Email: <input name="email"><br>--%>
<%--        Senha: <input name="senha" type="password"><br>--%>
<%--    </div>--%>

<%--    <!-- PROFESSOR -->--%>
<%--    <div id="formProfessor" style="display:none;">--%>
<%--        <h3>Professor</h3>--%>
<%--        Nome: <input name="nomeProfessor"><br>--%>
<%--        Username: <input name="usernameProfessor"><br>--%>
<%--        Email: <input name="emailProfessor"><br>--%>
<%--        Senha: <input name="senhaProfessor"><br>--%>
<%--        Id da Disciplina: <input name="idDisciplina"><br>--%>
<%--    </div>--%>

<%--    <!-- ALUNO -->--%>
<%--    <div id="formAluno" style="display:none;">--%>
<%--        <h3>Aluno</h3>--%>
<%--        Nome: <input name="nomeAluno"><br>--%>
<%--        Matrícula: <input name="matricula"><br>--%>
<%--        Turma: <input name="turma"><br>--%>
<%--    </div>--%>

<%--    <br>--%>
<%--    <button type="submit">Salvar</button>--%>
<%--</form>--%>

<%--<hr>--%>


<%--<h2>Administradores cadastrados</h2>--%>

<%--<%--%>
<%--    List<Adm> lista = (List<Adm>) request.getAttribute("listaAdm");--%>
<%--    if (lista != null && !lista.isEmpty()) {--%>
<%--%>--%>

<%--<table border="1" cellpadding="8">--%>
<%--    <tr>--%>
<%--        <th>ID</th>--%>
<%--        <th>Username</th>--%>
<%--        <th>Email</th>--%>
<%--        <th>Senha</th>--%>
<%--        <th>Edição</th>--%>
<%--        <th>Excluir</th>--%>
<%--    </tr>--%>

<%--    <%--%>
<%--        for (Adm adm : lista) {--%>
<%--    %>--%>
<%--    <tr>--%>
<%--        <form action="${pageContext.request.contextPath}/adm" method="post">--%>
<%--            <td>--%>
<%--                <%= adm.getId() %>--%>
<%--                <input type="hidden" name="idAdm" value="<%= adm.getId() %>">--%>
<%--            </td>--%>

<%--            <td>--%>
<%--                <input type="text" name="username" value="<%= adm.getUsername() %>">--%>
<%--            </td>--%>

<%--            <td>--%>
<%--                <input type="email" name="email" value="<%= adm.getEmail() %>">--%>
<%--            </td>--%>

<%--            <td>--%>
<%--                <input type="password" name="senha" placeholder="Nova senha">--%>
<%--            </td>--%>

<%--            <td>--%>
<%--                <input type="hidden" name="acao" value="editarAdm">--%>
<%--                <button type="submit">💾 Salvar</button>--%>
<%--            </td>--%>
<%--        </form>--%>
<%--        <td>--%>
<%--        <form action="${pageContext.request.contextPath}/adm" method="post" style="display:inline;">--%>
<%--            <input type="hidden" name="acao" value="removerAdm">--%>
<%--            <input type="hidden" name="id" value="<%= adm.getId() %>">--%>
<%--            <button type="submit"--%>
<%--                    onclick="return confirm('Tem certeza que deseja excluir?')">--%>
<%--                🗑️ Excluir--%>
<%--            </button>--%>
<%--        </form>--%>
<%--        </td>--%>
<%--    </tr>--%>
<%--    <%--%>
<%--        }--%>
<%--    %>--%>

<%--</table>--%>
<%--<%--%>
<%--    } else{--%>
<%--%>--%>
<%--<p>Nenhum administrador cadastrado.</p>--%>
<%--<%--%>
<%--    }--%>
<%--%>--%>
<%--<h2>Professores cadastrados</h2>--%>

<%--<%--%>
<%--    List<Professor> professores = (List<Professor>) request.getAttribute("listaProf");--%>
<%--    if (professores != null && !professores.isEmpty()){--%>
<%--%>--%>
<%--<table border="1" cellpadding="8">--%>
<%--    <tr>--%>
<%--        <th>ID</th>--%>
<%--        <th>Nome</th>--%>
<%--        <th>Username</th>--%>
<%--        <th>Email</th>--%>
<%--        <th>Senha</th>--%>
<%--        <th>ID_Disciplina</th>--%>
<%--        <th>Edição</th>--%>
<%--        <th>Excluir</th>--%>
<%--    </tr>--%>
<%--        <%--%>
<%--        for (Professor prof : professores) {--%>
<%--    %>--%>
<%--    <tr>--%>
<%--        <form action="${pageContext.request.contextPath}/adm" method="post">--%>
<%--            <td>--%>
<%--                <%= prof.getId() %>--%>
<%--                <input type="hidden" name="idProf" value="<%= prof.getId() %>">--%>
<%--            </td>--%>

<%--            <td>--%>
<%--                <input type="text" name="nome" value="<%= prof.getNome() %>">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <input type="text" name="username" value="<%= prof.getUsername() %>">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <input type="email" name="email" value="<%= prof.getEmail() %>">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <input type="password" name="senha" placeholder="Nova senha">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <input type="text" name="idDisciplina" value="<%= prof.getIdDisciplina()%>">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <input type="hidden" name="acao" value="editarProfessor">--%>
<%--                <button type="submit">💾 Salvar</button>--%>
<%--            </td>--%>
<%--        </form>--%>
<%--        <td>--%>
<%--            <form action="${pageContext.request.contextPath}/adm" method="post" style="display:inline;">--%>
<%--                <input type="hidden" name="acao" value="removerProfessor">--%>
<%--                <input type="hidden" name="idProf" value="<%= prof.getId() %>">--%>
<%--                <button type="submit"--%>
<%--                        onclick="return confirm('Tem certeza que deseja excluir?')">--%>
<%--                    🗑️ Excluir--%>
<%--                </button>--%>
<%--            </form>--%>
<%--        </td>--%>
<%--    </tr>--%>
<%--        <%--%>
<%--        }--%>
<%--    %>--%>
<%--<%--%>
<%--} else {--%>
<%--%>--%>

<%--<p>Nenhum professor cadastrado.</p>--%>
<%--        <%--%>
<%--    }--%>
<%--%>--%>

<%--<!-- 🔥 SCRIPT SEMPRE NO FINAL DO BODY -->--%>
<%--<script>--%>
<%--    function mostrarCampos() {--%>
<%--        const tipo = document.getElementById("tipoUsuario").value;--%>

<%--        document.getElementById("formAdm").style.display = "none";--%>
<%--        document.getElementById("formProfessor").style.display = "none";--%>
<%--        document.getElementById("formAluno").style.display = "none";--%>

<%--        if (tipo === "adm") {--%>
<%--            document.getElementById("formAdm").style.display = "block";--%>
<%--        }--%>
<%--        else if (tipo === "professor") {--%>
<%--            document.getElementById("formProfessor").style.display = "block";--%>
<%--        }--%>
<%--        else if (tipo === "aluno") {--%>
<%--            document.getElementById("formAluno").style.display = "block";--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
