<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%-- me avise depois oq estiver ruim por favor, obs: david --%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}./WEB-INF/css/style_inicio_adm.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}./WEB-INF/css/style_global.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}./WEB-INF/assets/logo_escolApp.png" type="image/x-icon">
    <title>EscolApp - Dashboard</title>
</head>
<body>
    <div class="container_conteudo_usuario">

        <!-- Informaçoes do Usuario-->
        <div class="informacao_usuario">
            <div>
                <img src="${usuario.foto}" alt="imagem_usuario" class="img_usuario">
                <p>${usuario.turma}</p>
            </div>
            <p>${usuario.nome}</p>
        </div>

        <!-- Menu -->
        <div class="aside">
            <a href="inicio.html" class="campos usado">
                <img src="../WEB-INF/assets/icone_casa.png" alt="icone"> Início
            </a>

            <a href="notas.html" class="campos">
                <img src="../WEB-INF/assets/icone_casa.png" alt="icone"> Notas
            </a>

            <a href="materias.html" class="campos">
                <img src="../WEB-INF/assets/icone_livro.png" alt="icone"> Matérias
            </a>

            <a href="calendario.html" class="campos">
                <img src="../WEB-INF/assets/icone_calendario.png" alt="icone"> Calendário
            </a>
        </div>

    </div>

    <section id="container_dashboard">
        <p id="ola">Olá <strong>${usuario.primeiroNome}</strong> <img src="${pageContext.request.contextPath}/WEB-INF/assets/icone_chapeu.png" alt="icone"></p>

        <h1>Cadastros</h1>
        <section class="secao_card">
            <div class="card">
                <p>Total Usuários</p>
                <p>${dashboard.totalUsuarios}</p>
            </div>
            <div class="card">
                <p>Alunos Cadastrados</p>
                <p>${dashboard.totalAlunos}</p>
            </div>
            <div class="card">
                <p>Professores Cadastrados</p>
                <p>${dashboard.totalProfessores}</p>
            </div>
            <div class="card">
                <p>Adms Cadastrados</p>
                <p>${dashboard.totalAdms}</p>
            </div>
        </section>

        <h1>Faltas</h1>
        <section class="secao_card">
            <div class="card">
                <p>Faltas alunos</p>
                <p>${dashboard.faltasAlunos}</p>
            </div>
            <div class="card">
                <p>Faltas Professores</p>
                <p>${dashboard.faltasProfessores}</p>
            </div>
        </section>
    </section>
</body>
</html>