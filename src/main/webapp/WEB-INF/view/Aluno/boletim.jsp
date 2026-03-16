<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.escolApp.servlet.AlunoServlet.ItemBoletim" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boletim - EscolApp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="../../../fotos/logo_escolApp.png">
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
        }

        .logout-btn a:hover {
            background: #3b2a2a;
            color: #ff6b6b;
        }

        .logout-btn i {
            color: #ff8a8a;
        }

        /* Conteúdo principal */
        .main-content {
            margin-left: 250px;
            padding: 25px;
            width: calc(100% - 250px);
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

        .boletim-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .cabecalho-boletim {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }

        .cabecalho-boletim h2 {
            color: #1e2b3f;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .cabecalho-boletim p {
            color: #666;
            font-size: 16px;
        }

        .info-aluno {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-item i {
            color: #2a3fbc;
            font-size: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background-color: #1e2b3f;
            color: white;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .media {
            font-weight: bold;
            font-size: 16px;
        }

        .badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
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

        .media-geral {
            margin-top: 30px;
            padding: 20px;
            background-color: #1e2b3f;
            color: white;
            border-radius: 10px;
            text-align: center;
        }

        .media-geral h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .media-geral .valor {
            font-size: 36px;
            font-weight: bold;
            color: #2a3fbc;
        }

        /* Botões */
        .btn {
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            background-color: #2a3fbc;
            color: white;
        }

        .btn i {
            margin-right: 5px;
        }

        .btn:hover {
            background-color: #1e2b3f;
        }

        @media print {
            .menu, .logout-btn, .page-title i, .btn {
                display: none;
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }

            @page {
                margin: 1.5cm;
                size: A4;
            }

            @page :first {
                margin-top: 1.5cm;
            }

            @page {
                @top-center { content: "" }
                @bottom-center { content: "" }
                @bottom-right { content: "" }
            }

            a[href]:after {
                content: none !important;
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
        <a href="${pageContext.request.contextPath}/aluno/dashboard"><i class="fas fa-chart-pie"></i> Dashboard</a>
        <div class="divider">ÁREA DO ALUNO</div>
        <a href="${pageContext.request.contextPath}/aluno/boletim" style="background: #253040; color: white; border-left: 4px solid #2a3fbc;"><i class="fas fa-file-alt"></i> Boletim</a>
        <a href="${pageContext.request.contextPath}/aluno/observacoes"><i class="fas fa-comment"></i> Observações</a>
    </div>

    <!-- Botão de logout -->
    <div class="logout-btn">
        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Sair do Sistema</a>
    </div>
</div>

<div class="main-content">
    <div class="page-title">
        <i class="fas fa-file-alt"></i>
        <h1>Boletim Escolar</h1>
    </div>

    <div class="boletim-container">
        <div class="cabecalho-boletim">
            <h2>Boletim do Aluno</h2>
            <p>Ano Letivo 2026</p>
        </div>

        <div class="info-aluno">
            <div class="info-item">
                <i class="fas fa-user"></i>
                <span><strong>Aluno:</strong> ${aluno.nome}</span>
            </div>
            <div class="info-item">
                <i class="fas fa-id-card"></i>
                <span><strong>Matrícula:</strong> ${aluno.matricula}</span>
            </div>
            <div class="info-item">
                <i class="fas fa-calendar"></i>
                <span><strong>Data:</strong> <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></span>
            </div>
        </div>

        <table>
            <thead>
            <tr>
                <th>Disciplina</th>
                <th>Nota 1</th>
                <th>Nota 2</th>
                <th>Média</th>
                <th>Situação</th>
            </tr>
            </thead>
            <tbody>
            <%
                double somaMedias = 0;
                int totalDisciplinas = 0;
                List<ItemBoletim> boletim = (List<ItemBoletim>) request.getAttribute("boletim");
                if(boletim != null && !boletim.isEmpty()) {
                    for(ItemBoletim item : boletim) {
                        somaMedias += item.getMedia();
                        totalDisciplinas++;
            %>
            <tr>
                <td><strong><%= item.getDisciplina() %></strong></td>
                <td><%= item.getN1() > 0 ? item.getN1() : "-" %></td>
                <td><%= item.getN2() > 0 ? item.getN2() : "-" %></td>
                <td class="media"><%= String.format("%.1f", item.getMedia()) %></td>
                <td>
                            <span class="badge <%=
                                item.getSituacao().equals("Aprovado") ? "badge-success" :
                                item.getSituacao().equals("Recuperação") ? "badge-warning" : "badge-danger" %>">
                                <%= item.getSituacao() %>
                            </span>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center; padding: 30px;">
                    Nenhuma nota cadastrada para este aluno.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <% if(totalDisciplinas > 0) { %>
        <div class="media-geral">
            <h3><i class="fas fa-chart-line"></i> Média Geral</h3>
            <div class="valor"><%= request.getAttribute("mediaGeral") %></div>
        </div>
        <% } %>

        <div style="margin-top: 30px; text-align: right;">
            <button onclick="window.print()" class="btn">
                <i class="fas fa-print"></i> Imprimir Boletim
            </button>
        </div>
    </div>
</div>
</body>
</html>