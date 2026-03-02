<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.escolApp.model.Observacao" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Observações - Sistema Escolar</title>
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

        .sidebar {
            width: 260px;
            background-color: #1e2b3f;
            color: white;
            height: 100vh;
            position: fixed;
            padding: 20px 0;
        }

        .logo {
            padding: 0 20px 30px 20px;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 1px solid rgba(255,255,255,0.1);
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
            cursor: pointer;
        }

        .menu-item:hover, .menu-item.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid #4CAF50;
        }

        .menu-item i {
            width: 25px;
            margin-right: 10px;
        }

        .menu-item.logout {
            position: absolute;
            bottom: 20px;
            width: 100%;
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 20px;
        }

        .main-content {
            margin-left: 260px;
            padding: 30px;
            width: calc(100% - 260px);
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

        .observacoes-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .observacao-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-left: 4px solid #4CAF50;
            transition: transform 0.3s;
        }

        .observacao-card:hover {
            transform: translateX(5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .observacao-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .disciplina {
            font-size: 18px;
            font-weight: bold;
            color: #1e2b3f;
        }

        .disciplina i {
            color: #4CAF50;
            margin-right: 8px;
        }

        .data {
            color: #666;
            font-size: 14px;
        }

        .data i {
            margin-right: 5px;
        }

        .professor {
            color: #4CAF50;
            font-weight: 500;
            margin-top: 10px;
            font-size: 14px;
        }

        .professor i {
            margin-right: 5px;
        }

        .observacao-conteudo {
            color: #333;
            line-height: 1.8;
            margin-bottom: 15px;
            font-size: 16px;
        }

        .sem-observacoes {
            background: white;
            border-radius: 15px;
            padding: 50px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .sem-observacoes i {
            font-size: 64px;
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .sem-observacoes p {
            color: #666;
            font-size: 18px;
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

    <div class="menu-item" onclick="window.location.href='${pageContext.request.contextPath}/aluno/dashboard'">
        <i class="fas fa-home"></i>
        <span>Dashboard</span>
    </div>
    <div class="menu-item" onclick="window.location.href='${pageContext.request.contextPath}/aluno/boletim'">
        <i class="fas fa-file-alt"></i>
        <span>Boletim</span>
    </div>
    <div class="menu-item active" onclick="window.location.href='${pageContext.request.contextPath}/aluno/observacoes'">
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
    <div class="page-title">
        <i class="fas fa-comment"></i>
        <h1>Observações</h1>
    </div>

    <div class="observacoes-container">
        <%
            List<Observacao> observacoes = (List<Observacao>) request.getAttribute("observacoes");
            Map<Integer, String> mapaDisciplinas = (Map<Integer, String>) request.getAttribute("mapaDisciplinas");
            Map<Integer, String> mapaProfessores = (Map<Integer, String>) request.getAttribute("mapaProfessores");

            if(observacoes != null && !observacoes.isEmpty()) {
                for(Observacao o : observacoes) {
                    String nomeDisciplina = mapaDisciplinas != null ? mapaDisciplinas.get(o.getId_disciplina()) : "N/A";
                    String nomeProfessor = mapaProfessores != null ? mapaProfessores.get(o.getId_professor()) : "N/A";
        %>
        <div class="observacao-card">
            <div class="observacao-header">
                    <span class="disciplina">
                        <i class="fas fa-book"></i> <%= nomeDisciplina %>
                    </span>
                <span class="data">
                        <i class="far fa-calendar"></i> <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(o.getData()) %>
                    </span>
            </div>

            <div class="observacao-conteudo">
                <%= o.getTexto() %>
            </div>

            <div class="professor">
                <i class="fas fa-chalkboard-teacher"></i> Prof. <%= nomeProfessor %>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="sem-observacoes">
            <i class="fas fa-inbox"></i>
            <p>Nenhuma observação encontrada</p>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>