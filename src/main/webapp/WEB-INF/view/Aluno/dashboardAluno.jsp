<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.escolApp.model.Aluno" %>
<%@ page import="com.escolApp.model.Nota" %>
<%@ page import="com.escolApp.model.Observacao" %>
<%@ page import="com.escolApp.model.Disciplina" %>
<%@ page import="com.escolApp.servlet.AlunoServlet.ResumoDisciplina" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Aluno - Sistema Escolar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f4f7fc;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: #1e2b3f;
            color: white;
            height: 100vh;
            position: fixed;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .logo {
            padding: 0 20px 30px 20px;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
        }

        .logo i {
            margin-right: 10px;
            color: #4CAF50;
        }

        .menu-item {
            padding: 12px 25px;
            display: flex;
            align-items: center;
            color: rgba(255,255,255,0.8);
            transition: all 0.3s;
            cursor: pointer;
            margin: 5px 0;
        }

        .menu-item:hover, .menu-item.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid #4CAF50;
        }

        .menu-item i {
            width: 25px;
            margin-right: 10px;
            font-size: 18px;
        }

        .menu-item.logout {
            position: absolute;
            bottom: 20px;
            width: 100%;
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 20px;
        }

        /* Conteúdo principal */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            width: calc(100% - 260px);
            background-color: #f4f7fc;
        }

        .page-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
        }

        .page-title i {
            margin-right: 15px;
            color: #1e2b3f;
            font-size: 32px;
        }

        /* Cards */
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .card h4 {
            color: #666;
            font-size: 14px;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .card .numero {
            font-size: 32px;
            font-weight: bold;
            color: #1e2b3f;
        }

        .card i {
            font-size: 48px;
            color: #4CAF50;
            opacity: 0.8;
        }

        /* Container de informações do aluno */
        .info-aluno {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .avatar-aluno {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #1e2b3f;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .avatar-aluno i {
            font-size: 50px;
            color: white;
        }

        .dados-aluno h2 {
            color: #1e2b3f;
            margin-bottom: 10px;
        }

        .dados-aluno p {
            color: #666;
            margin: 5px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dados-aluno i {
            color: #4CAF50;
            width: 20px;
        }

        /* Tabelas */
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow-x: auto;
        }

        .table-container h3 {
            color: #1e2b3f;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
        }

        .table-container h3 i {
            color: #4CAF50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #f8f9fa;
            color: #1e2b3f;
            font-weight: 600;
            padding: 15px 10px;
            text-align: left;
            border-bottom: 2px solid #dee2e6;
        }

        td {
            padding: 15px 10px;
            border-bottom: 1px solid #dee2e6;
            color: #555;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #f1f3f5;
        }

        /* Badges */
        .badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-success {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-warning {
            background-color: #fff3cd;
            color: #856404;
        }

        .badge-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .badge-info {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        /* Lista de observações */
        .observacoes-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .observacao-item {
            background-color: #f8f9fa;
            border-left: 4px solid #4CAF50;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            transition: transform 0.3s;
        }

        .observacao-item:hover {
            transform: translateX(5px);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .observacao-item .cabecalho {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: #666;
            font-size: 14px;
        }

        .observacao-item .disciplina {
            font-weight: bold;
            color: #1e2b3f;
        }

        .observacao-item .data {
            color: #999;
        }

        .observacao-item .conteudo {
            color: #333;
            line-height: 1.6;
        }

        /* Mensagens de feedback */
        .msg {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
            animation: slideIn 0.5s;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .msg.sucesso {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .msg.erro {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .msg.info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        /* Grid de conteúdo */
        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }

            .sidebar .menu-item span,
            .sidebar .logo span {
                display: none;
            }

            .main-content {
                margin-left: 70px;
                width: calc(100% - 70px);
            }

            .grid-2 {
                grid-template-columns: 1fr;
            }

            .info-aluno {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">
        <i class="fas fa-user-graduate"></i>
        <span>Aluno</span>
    </div>

    <div class="menu-item active" onclick="window.location.href='${pageContext.request.contextPath}/aluno/dashboard'">
        <i class="fas fa-home"></i>
        <span>Dashboard</span>
    </div>
    <div class="menu-item" onclick="window.location.href='${pageContext.request.contextPath}/aluno/boletim'">
        <i class="fas fa-file-alt"></i>
        <span>Boletim</span>
    </div>
    <div class="menu-item" onclick="window.location.href='${pageContext.request.contextPath}/aluno/observacoes'">
        <i class="fas fa-comment"></i>
        <span>Observações</span>
    </div>

    <div class="menu-item logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
        <i class="fas fa-sign-out-alt"></i>
        <span>Sair</span>
    </div>
</div>

<!-- Conteúdo principal -->
<div class="main-content">
    <!-- Mensagens de feedback -->
    <%
        String msg = (String) session.getAttribute("msg");
        String tipoMsg = (String) session.getAttribute("tipoMsg");
        if(msg != null && tipoMsg != null) {
            session.removeAttribute("msg");
            session.removeAttribute("tipoMsg");
    %>
    <div class="msg <%= tipoMsg %>">
        <i class="fas fa-<%= tipoMsg.equals("erro") ? "exclamation-circle" : "check-circle" %>"></i>
        <%= msg %>
    </div>
    <% } %>

    <div class="page-title">
        <i class="fas fa-user-graduate"></i>
        <h1>Dashboard do Aluno</h1>
    </div>

    <!-- Informações do Aluno -->
    <div class="info-aluno">
        <div class="avatar-aluno">
            <i class="fas fa-user-graduate"></i>
        </div>
        <div class="dados-aluno">
            <h2><i class="fas fa-user"></i> ${aluno.nome}</h2>
            <p><i class="fas fa-id-card"></i> Matrícula: ${aluno.matricula}</p>
            <p><i class="fas fa-envelope"></i> Email: ${aluno.email}</p>
            <p><i class="fas fa-user-tag"></i> Username: ${aluno.username}</p>
        </div>
    </div>

    <!-- Cards de estatísticas -->
    <div class="cards">
        <div class="card">
            <div>
                <h4>Total de Disciplinas</h4>
                <span class="numero">${totalDisciplinas}</span>
            </div>
            <i class="fas fa-book"></i>
        </div>

        <div class="card">
            <div>
                <h4>Média Geral</h4>
                <span class="numero">${mediaGeral}</span>
            </div>
            <i class="fas fa-chart-line"></i>
        </div>

        <div class="card">
            <div>
                <h4>Observações</h4>
                <span class="numero">${totalObservacoes}</span>
            </div>
            <i class="fas fa-envelope"></i>
        </div>
    </div>

    <!-- Grid de conteúdo -->
    <div class="grid-2">
        <!-- Últimas Notas -->
        <div class="table-container">
            <h3><i class="fas fa-star"></i> Últimas Notas</h3>
            <table>
                <thead>
                <tr>
                    <th>Disciplina</th>
                    <th>N1</th>
                    <th>N2</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Map<Integer, String> mapaDisciplinas = (Map<Integer, String>) request.getAttribute("mapaDisciplinas");
                    List<Nota> ultimasNotas = (List<Nota>) request.getAttribute("ultimasNotas");
                    if(ultimasNotas != null && !ultimasNotas.isEmpty()) {
                        for(Nota n : ultimasNotas) {
                            String nomeDisciplina = mapaDisciplinas != null ? mapaDisciplinas.get(n.getIdDisciplina()) : "N/A";
                %>
                <tr>
                    <td><%= nomeDisciplina %></td>
                    <td>
                                <span class="badge <%= n.getN1() >= 6 ? "badge-success" : "badge-danger" %>">
                                    <%= n.getN1() %>
                                </span>
                    </td>
                    <td>
                                <span class="badge <%= n.getN2() >= 6 ? "badge-success" : "badge-danger" %>">
                                    <%= n.getN2() %>
                                </span>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="3" style="text-align: center;">Nenhuma nota cadastrada</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <!-- Observações Recentes -->
        <div class="table-container">
            <h3><i class="fas fa-comment"></i> Observações Recentes</h3>
            <div class="observacoes-list">
                <%
                    List<Observacao> observacoesRecentes = (List<Observacao>) request.getAttribute("observacoesRecentes");
                    if(observacoesRecentes != null && !observacoesRecentes.isEmpty()) {
                        for(Observacao o : observacoesRecentes) {
                            String nomeDisciplina = mapaDisciplinas != null ? mapaDisciplinas.get(o.getId_disciplina()) : "N/A";
                %>
                <div class="observacao-item">
                    <div class="cabecalho">
                        <span class="disciplina"><i class="fas fa-book"></i> <%= nomeDisciplina %></span>
                        <span class="data"><i class="far fa-calendar"></i> <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(o.getData()) %></span>
                    </div>
                    <div class="conteudo">
                        <%= o.getTexto() %>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <p class="msg info">Nenhuma observação no momento</p>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Tabela de Resumo das Disciplinas -->
    <div class="table-container">
        <h3><i class="fas fa-chart-bar"></i> Resumo das Disciplinas</h3>
        <table>
            <thead>
            <tr>
                <th>Disciplina</th>
                <th>N1</th>
                <th>N2</th>
                <th>Média</th>
                <th>Situação</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<ResumoDisciplina> resumoDisciplinas = (List<ResumoDisciplina>) request.getAttribute("resumoDisciplinas");
                if(resumoDisciplinas != null && !resumoDisciplinas.isEmpty()) {
                    for(ResumoDisciplina r : resumoDisciplinas) {
            %>
            <tr>
                <td><%= r.getDisciplina() %></td>
                <td><%= r.getN1() > 0 ? r.getN1() : "-" %></td>
                <td><%= r.getN2() > 0 ? r.getN2() : "-" %></td>
                <td>
                    <strong><%= String.format("%.1f", r.getMedia()) %></strong>
                </td>
                <td>
                            <span class="badge <%=
                                r.getSituacao().equals("Aprovado") ? "badge-success" :
                                r.getSituacao().equals("Recuperação") ? "badge-warning" : "badge-danger" %>">
                                <%= r.getSituacao() %>
                            </span>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center;">Nenhuma disciplina cadastrada</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>