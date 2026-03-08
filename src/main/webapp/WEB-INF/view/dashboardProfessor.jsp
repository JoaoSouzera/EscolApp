<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.escolApp.model.Aluno" %>
<%@ page import="com.escolApp.model.Professor" %>
<%@ page import="com.escolApp.model.Nota" %>
<%@ page import="com.escolApp.model.Observacao" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Painel do Professor</title>
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

        /* Menu lateral - mesmo padrão do ADM */
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

        /* Conteúdo principal */
        .conteudo {
            margin-left: 250px;
            padding: 25px;
            width: 100%;
        }

        /* Cards - mesmo padrão do ADM */
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

        /* Títulos das seções */
        .titulo {
            margin: 30px 0 15px;
            color: #1e2a44;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .titulo i {
            font-size: 24px;
            color: #687df0;
            background: #e7ebfe;
            padding: 8px;
            border-radius: 8px;
        }

        /* Mensagens de feedback */
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

        /* Container das tabelas */
        .tabela-container {
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            overflow-x: auto;
        }

        /* Tabelas */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 10px;
            color: #52607a;
            border-bottom: 2px solid #e5ecf3;
            font-size: 14px;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #edf2f9;
        }

        /* Botões - mesmas classes do ADM */
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
        .btn-success { background: #e1f7e1; color: #2e7d32; }

        .btn-novo {
            background: #e1e9fe;
            color: #344e9c;
            padding: 8px 15px;
            margin-bottom: 15px;
            display: inline-block;
            border: 1px dashed #b9c7e0;
            border-radius: 20px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-novo i {
            color: #4f70df;
            margin-right: 5px;
        }

        /* Formulários */
        input, select, textarea {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 13px;
            color: #2b3e6b;
        }

        .form-row {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .form-row .form-group {
            flex: 1;
            min-width: 200px;
        }

        /* Cards de informação */
        .info-card {
            background: #e7ebfe;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #687df0;
        }

        .info-card p {
            margin: 5px 0;
            color: #1e2a44;
        }

        /* Busca */
        .busca-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* Formulário de edição inline */
        .edit-form {
            display: none;
            margin-top: 20px;
            padding: 15px;
            background: #f0f0f0;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<!-- MENU LATERAL - mesmo padrão do ADM -->
<div class="menu">
    <div class="menu-items">
        <h3><i class="fas fa-school"></i> Professor</h3>
        <div class="divider">MENU</div>
        <a href="<%= request.getContextPath() %>/professor?acao=dashboard"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <div class="divider">MINHAS FUNÇÕES</div>
        <a href="#busca"><i class="fas fa-search"></i> Buscar Aluno</a>
        <a href="#notas"><i class="fas fa-star"></i> Lançar Notas</a>
        <a href="#observacoes"><i class="fas fa-comment"></i> Observações</a>
    </div>

    <!-- BOTÃO DE LOGOUT -->
    <div class="logout-btn">
        <a href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt"></i> Sair do Sistema</a>
    </div>
</div>

<!-- CONTEÚDO PRINCIPAL -->
<div class="conteudo">

    <!-- TÍTULO E MENSAGENS -->
    <h1>Painel do Professor</h1>

    <%
        // Dados do professor logado
        Professor profLogado = (Professor) session.getAttribute("professorLogado");
        if (profLogado != null) {
    %>
    <div class="info-card">
        <p><strong><i class="fas fa-user-tie"></i> Bem-vindo, <%= profLogado.getNome() %>!</strong></p>
        <p><i class="fas fa-book"></i> ID Disciplina: <%= profLogado.getIdDisciplina() %></p>
    </div>
    <% } %>

    <%
        String msg = (String) session.getAttribute("msg");
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

    <!-- CARDS DE ESTATÍSTICAS -->
    <div class="cards">
        <div class="card">
            <div><h4>Total Alunos</h4><span class="numero"><%= request.getAttribute("listaAlunos") != null ? ((List<?>)request.getAttribute("listaAlunos")).size() : 0 %></span></div>
            <i class="fas fa-users"></i>
        </div>
        <div class="card">
            <div><h4>Notas Lançadas</h4><span class="numero"><%= request.getAttribute("listaNotas") != null ? ((List<?>)request.getAttribute("listaNotas")).size() : 0 %></span></div>
            <i class="fas fa-star"></i>
        </div>
        <div class="card">
            <div><h4>Observações</h4><span class="numero"><%= request.getAttribute("listaObs") != null ? ((List<?>)request.getAttribute("listaObs")).size() : 0 %></span></div>
            <i class="fas fa-comment"></i>
        </div>
        <div class="card">
            <div><h4>Minha Disciplina</h4><span class="numero"><%= profLogado != null ? profLogado.getIdDisciplina() : 0 %></span></div>
            <i class="fas fa-book"></i>
        </div>
    </div>

    <!-- SEÇÃO DE BUSCA DE ALUNO -->
    <h2 class="titulo" id="busca"><i class="fas fa-search"></i> Buscar Aluno por Matrícula</h2>
    <div class="busca-container">
        <form action="<%= request.getContextPath() %>/professor" method="get">
            <input type="hidden" name="acao" value="buscarAluno">
            <div class="form-row">
                <div class="form-group" style="flex: 3;">
                    <input type="text" name="matricula" placeholder="Digite a matrícula do aluno" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <button type="submit" class="btn btn-edit" style="width: 100%; padding: 8px;">
                        <i class="fas fa-search"></i> Buscar
                    </button>
                </div>
            </div>
        </form>

        <%
            Aluno alunoBuscado = (Aluno) session.getAttribute("alunoBuscado");
            if (alunoBuscado != null) {
        %>
        <div style="margin-top: 15px; padding: 10px; background: #e7ebfe; border-radius: 5px;">
            <p><strong>Aluno encontrado:</strong> <%= alunoBuscado.getNome() %> - Matrícula: <%= alunoBuscado.getMatricula() %></p>
            <div style="margin-top: 10px;">
                <button class="btn btn-edit" onclick="usarAlunoParaNota('<%= alunoBuscado.getId() %>', '<%= alunoBuscado.getNome() %>')">
                    <i class="fas fa-star"></i> Lançar Nota
                </button>
                <button class="btn btn-edit" onclick="usarAlunoParaObs('<%= alunoBuscado.getId() %>', '<%= alunoBuscado.getNome() %>')">
                    <i class="fas fa-comment"></i> Enviar Observação
                </button>
            </div>
        </div>
        <% } %>
    </div>

    <!-- FORMULÁRIO PARA LANÇAR NOTAS -->
    <h2 class="titulo" id="notas"><i class="fas fa-star"></i> Lançar Notas</h2>
    <div class="form-container">
        <h3><i class="fas fa-plus-circle"></i> Nova Nota</h3>
        <form action="<%= request.getContextPath() %>/professor" method="post">
            <input type="hidden" name="acao" value="lancarNota">
            <div class="form-row">
                <div class="form-group">
                    <label>Aluno:</label>
                    <select name="idAluno" id="selectAlunoNota" required>
                        <option value="">Selecione um aluno</option>
                        <%
                            List<Aluno> listaAlunos = (List<Aluno>) request.getAttribute("listaAlunos");
                            if(listaAlunos != null) {
                                for(Aluno a : listaAlunos) {
                        %>
                        <option value="<%= a.getId() %>"><%= a.getNome() %> - <%= a.getMatricula() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label>N1 (Primeira Nota):</label>
                    <input type="number" step="0.1" min="0" max="10" name="n1" required>
                </div>
                <div class="form-group">
                    <label>N2 (Segunda Nota):</label>
                    <input type="number" step="0.1" min="0" max="10" name="n2" required>
                </div>
            </div>
            <button type="submit" class="btn btn-edit"><i class="fas fa-save"></i> Lançar Notas</button>
        </form>
    </div>

    <!-- TABELA DE NOTAS LANÇADAS -->
    <div class="tabela-container">
        <h3 style="margin-bottom: 15px;"><i class="fas fa-list"></i> Notas Lançadas</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Aluno</th>
                <th>N1</th>
                <th>N2</th>
                <th>Média</th>
                <th>Situação</th>
                <th>Ações</th>
            </tr>
            <%
                List<Nota> listaNotas = (List<Nota>) request.getAttribute("listaNotas");
                if(listaNotas != null) {
                    for(Nota n : listaNotas) {
                        // Buscar nome do aluno (simplificado - idealmente faria join no SQL)
                        String nomeAluno = "";
                        if(listaAlunos != null) {
                            for(Aluno a : listaAlunos) {
                                if(a.getId() == n.getIdAluno()) {
                                    nomeAluno = a.getNome();
                                    break;
                                }
                            }
                        }
                        double media = (n.getN1() + n.getN2()) / 2;
                        String situacao = media >= 6 ? "Aprovado" : "Recuperação";
                        String corSituacao = media >= 6 ? "#2e7d32" : "#b85c00";
            %>
            <tr>
                <td><%= n.getId() %></td>
                <td><%= nomeAluno %></td>
                <td><%= n.getN1() %></td>
                <td><%= n.getN2() %></td>
                <td><strong><%= String.format("%.1f", media) %></strong></td>
                <td><span style="color: <%= corSituacao %>; font-weight: bold;"><%= situacao %></span></td>
                <td>
                    <button class="btn btn-edit" onclick="editarNota(<%= n.getId() %>, <%= n.getN1() %>, <%= n.getN2() %>)">
                        <i class="fas fa-edit"></i> Editar
                    </button>
                    <form action="<%= request.getContextPath() %>/professor" method="post" style="display:inline;">
                        <input type="hidden" name="acao" value="removerNota">
                        <input type="hidden" name="idNota" value="<%= n.getId() %>">
                        <button type="submit" class="btn btn-delete" onclick="return confirm('Remover esta nota?')">
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

        <!-- Formulário de edição de notas (inline) -->
        <div id="formEditarNota" class="edit-form">
            <h4>Editar Notas</h4>
            <form action="<%= request.getContextPath() %>/professor" method="post">
                <input type="hidden" name="idNota" id="editNotaId">
                <div class="form-row">
                    <div class="form-group">
                        <label>N1:</label>
                        <input type="number" step="0.1" name="n1" id="editNotaN1" required>
                    </div>
                    <div class="form-group">
                        <label>N2:</label>
                        <input type="number" step="0.1" name="n2" id="editNotaN2" required>
                    </div>
                </div>
                <button type="submit" name="acao" value="editarN1" class="btn btn-edit">Salvar N1</button>
                <button type="submit" name="acao" value="editarN2" class="btn btn-edit">Salvar N2</button>
                <button type="button" class="btn btn-delete" onclick="document.getElementById('formEditarNota').style.display='none'">Cancelar</button>
            </form>
        </div>
    </div>

    <!-- FORMULÁRIO PARA ENVIAR OBSERVAÇÃO -->
    <h2 class="titulo" id="observacoes"><i class="fas fa-comment"></i> Observações</h2>
    <div class="form-container">
        <h3><i class="fas fa-plus-circle"></i> Nova Observação</h3>
        <form action="<%= request.getContextPath() %>/professor" method="post">
            <input type="hidden" name="acao" value="enviarObservacao">
            <div class="form-group">
                <label>Aluno:</label>
                <select name="idAluno" id="selectAlunoObs" required>
                    <option value="">Selecione um aluno</option>
                    <%
                        if(listaAlunos != null) {
                            for(Aluno a : listaAlunos) {
                    %>
                    <option value="<%= a.getId() %>"><%= a.getNome() %> - <%= a.getMatricula() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label>Observação:</label>
                <textarea name="texto" placeholder="Digite a observação sobre o aluno..." required></textarea>
            </div>
            <button type="submit" class="btn btn-edit"><i class="fas fa-paper-plane"></i> Enviar</button>
        </form>
    </div>

    <!-- TABELA DE OBSERVAÇÕES -->
    <div class="tabela-container">
        <h3 style="margin-bottom: 15px;"><i class="fas fa-list"></i> Observações Enviadas</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Aluno</th>
                <th>Data</th>
                <th>Observação</th>
            </tr>
            <%
                List<Observacao> listaObs = (List<Observacao>) request.getAttribute("listaObs");
                if(listaObs != null) {
                    for(Observacao o : listaObs) {
                        // Buscar nome do aluno
                        String nomeAluno = "";
                        if(listaAlunos != null) {
                            for(Aluno a : listaAlunos) {
                                if(a.getId() == o.getId_aluno()) {
                                    nomeAluno = a.getNome();
                                    break;
                                }
                            }
                        }
            %>
            <tr>
                <td><%= o.getId() %></td>
                <td><%= nomeAluno %></td>
                <td><%= o.getData() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(o.getData()) : "" %></td>
                <td><%= o.getTexto() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>

    <div style="text-align:center; color:#999; margin-top:30px;">
        Painel do Professor - <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>
    </div>
</div>

<script>
    // Funções para preencher formulários de edição

    function editarNota(id, n1, n2) {
        document.getElementById('editNotaId').value = id;
        document.getElementById('editNotaN1').value = n1;
        document.getElementById('editNotaN2').value = n2;
        document.getElementById('formEditarNota').style.display = 'block';
    }

    function usarAlunoParaNota(id, nome) {
        var select = document.getElementById('selectAlunoNota');
        for(var i = 0; i < select.options.length; i++) {
            if(select.options[i].value == id) {
                select.selectedIndex = i;
                break;
            }
        }
        // Rolar até a seção de notas
        document.getElementById('notas').scrollIntoView({behavior: 'smooth'});
    }

    function usarAlunoParaObs(id, nome) {
        var select = document.getElementById('selectAlunoObs');
        for(var i = 0; i < select.options.length; i++) {
            if(select.options[i].value == id) {
                select.selectedIndex = i;
                break;
            }
        }
        // Rolar até a seção de observações
        document.getElementById('observacoes').scrollIntoView({behavior: 'smooth'});
    }
</script>

</body>
</html>
