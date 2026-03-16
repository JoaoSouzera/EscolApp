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
    <title>Dashboard Aluno - EscolApp</title>
    <link rel="icon" href="../../../fotos/logo_escolApp.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f0f2f5;
            display: flex;
            height: 100%;
            min-height: 100vh;
        }

        /* Menu lateral - mesmo padrão do Professor */
        .menu {
            width: 250px;
            background: #1e2b3f;
            height: 100%;
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

        .menu h3 i {
            margin-right: 10px;
            color: #2a3fbc;
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
            display: block;
            padding: 12px 20px;
            text-decoration: none;
        }

        .logout-btn a:hover {
            background: #3b2a2a;
            color: #ff6b6b;
        }

        .logout-btn i {
            color: #ff8a8a;
            width: 25px;
        }

        /* Conteúdo principal */
        .main-content {
            margin-left: 250px;
            padding: 25px;
            width: calc(100% - 250px);
            background-color: #f0f2f5;
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
            color: #2a3fbc;
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
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .card h4 {
            color: #5e6f8d;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .card .numero {
            font-size: 28px;
            font-weight: bold;
            color: #22308D;
        }

        .card i {
            font-size: 35px;
            color: #22308D;
            opacity: 0.8;
        }

        /* Container de informações do aluno */
        .info-aluno {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
            color: #22308D;
            width: 20px;
        }

        /* Tabelas */
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            overflow-x: auto;
        }

        .table-container h3 {
            color: #1e2b3f;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 18px;
        }

        .table-container h3 i {
            color: #22308D;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #f8f9fa;
            color: #1e2b3f;
            font-weight: 600;
            padding: 12px 10px;
            text-align: left;
            border-bottom: 2px solid #dee2e6;
            font-size: 14px;
        }

        td {
            padding: 12px 10px;
            border-bottom: 1px solid #dee2e6;
            color: #555;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #f1f3f5;
        }

        /* Badges - NOVAS CORES para as notas */
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

        /* NOVAS classes para notas específicas */
        .nota-alta {
            background-color: #d4edda;
            color: #155724;
        }

        .nota-media {
            background-color: #fff3cd;
            color: #856404;
        }

        .nota-baixa {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* Lista de observações */
        .observacoes-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .observacao-item {
            background-color: #f8f9fa;
            border-left: 4px solid #22308D;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
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
            font-size: 13px;
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
            font-size: 14px;
        }

        /* Mensagens de feedback */
        .msg {
            padding: 15px 20px;
            border-radius: 5px;
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
            .menu {
                width: 70px;
                overflow: hidden;
            }

            .menu a span,
            .menu h3 span {
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
<!-- Menu lateral - mesmo padrão do Professor -->
<div class="menu">
    <div class="menu-items">
        <h3><i class="fas fa-user-graduate"></i> Aluno</h3>
        <div class="divider">MENU</div>
        <a href="${pageContext.request.contextPath}/aluno/dashboard" style="background: #253040; color: white; border-left: 4px solid #2a3fbc;"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <div class="divider">ÁREA DO ALUNO</div>
        <a href="${pageContext.request.contextPath}/aluno/boletim"><i class="fas fa-file-alt"></i> Boletim</a>
        <a href="${pageContext.request.contextPath}/aluno/observacoes"><i class="fas fa-comment"></i> Observações</a>
    </div>

    <!-- Botão de logout -->
    <div class="logout-btn">
        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Sair do Sistema</a>
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
        <i class="fas fa-chart-pie"></i>
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

                            // Definir classe CSS para N1 baseado no valor
                            String classeN1 = "nota-baixa";
                            if (n.getN1() >= 7) {
                                classeN1 = "nota-alta";
                            } else if (n.getN1() >= 4) {
                                classeN1 = "nota-media";
                            }

                            // Definir classe CSS para N2 baseado no valor
                            String classeN2 = "nota-baixa";
                            if (n.getN2() >= 7) {
                                classeN2 = "nota-alta";
                            } else if (n.getN2() >= 4) {
                                classeN2 = "nota-media";
                            }
                %>
                <tr>
                    <td><%= nomeDisciplina %></td>
                    <td>
                                <span class="badge <%= classeN1 %>">
                                    <%= n.getN1() %>
                                </span>
                    </td>
                    <td>
                                <span class="badge <%= classeN2 %>">
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