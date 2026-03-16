<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.escolApp.model.Observacao" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Observações - EscolApp</title>
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

        .observacoes-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .observacao-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-left: 4px solid #22308D;
            transition: transform 0.3s;
        }

        .observacao-card:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
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
            color: #22308D;
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
            color: #22308D;
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
            border-radius: 10px;
            padding: 50px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .sem-observacoes i {
            font-size: 64px;
            color: #22308D;
            margin-bottom: 20px;
        }

        .sem-observacoes p {
            color: #666;
            font-size: 18px;
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
        <a href="${pageContext.request.contextPath}/aluno/boletim"><i class="fas fa-file-alt"></i> Boletim</a>
        <a href="${pageContext.request.contextPath}/aluno/observacoes" style="background: #253040; color: white; border-left: 4px solid #2a3fbc;"><i class="fas fa-comment"></i> Observações</a>
    </div>

    <!-- Botão de logout -->
    <div class="logout-btn">
        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Sair do Sistema</a>
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