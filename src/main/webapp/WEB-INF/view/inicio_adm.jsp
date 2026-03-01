<%@ page import="com.escolApp.model.Adm" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_inicio_adm.css">

    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/fotos/logo_escolApp.png" type="image/x-icon">

    <title>EscolApp - Dashboard</title>
</head>
<body>
<%
    Adm usuario = (Adm) session.getAttribute("admLogado");
    if (usuario != null) {
%>

<!-- SIDEBAR FIXA -->
<div class="sidebar-fixa">
    <div class="container_conteudo_usuario">
        <!-- Informações do Usuário -->
        <div class="informacao_usuario">
            <div>
                <img src="${pageContext.request.contextPath}/fotos/ronaldinho.png"
                     alt="imagem_usuario" class="img_usuario"><br>
            </div>
        </div>

        <!-- Menu Principal com links para âncoras -->
        <div class="aside">
            <a href="#dashboard" class="campos active" id="link-dashboard">
                <img src="${pageContext.request.contextPath}/fotos/icone_casa.png" alt="icone"> Dashboard
            </a>
            <a href="#alunos" class="campos" id="link-alunos">
                <img src="${pageContext.request.contextPath}/fotos/icone_estrela.png" alt="icone"> Alunos
            </a>
            <a href="#professores" class="campos" id="link-professores">
                <img src="${pageContext.request.contextPath}/fotos/icone_email.png" alt="icone"> Professores
            </a>
            <a href="#materias" class="campos" id="link-materias">
                <img src="${pageContext.request.contextPath}/fotos/icone_livro.png" alt="icone"> Matérias
            </a>
        </div>
    </div>
</div>

<!-- CONTEÚDO PRINCIPAL COM SCROLL -->
<main class="conteudo-scrollavel">
    <!-- SEÇÃO DASHBOARD (VISÃO GERAL) -->
    <section id="dashboard" class="secao-dashboard">
        <div id="ola">
            Olá, <strong>Usuario</strong>
            <img src="${pageContext.request.contextPath}/fotos/icone_chapeu.png" alt="icone">
        </div>

        <h1>Dashboard</h1>

        <!-- Primeira linha de cards -->
        <section class="secao_card">
            <div class="card">
                <p>TOTAL DE USUÁRIOS</p>
                <p>${dashboard.totalUsuarios != null ? dashboard.totalUsuarios : '79'}</p>
                <span class="tendencia">↑ 8% este mês</span>
            </div>
            <div class="card">
                <p>ALUNOS CADASTRADOS</p>
                <p>${dashboard.totalAlunos != null ? dashboard.totalAlunos : '67'}</p>
                <span class="tendencia">↑ 3 novos</span>
            </div>
            <div class="card">
                <p>ADMS CADASTRADOS</p>
                <p>${dashboard.totalAdms != null ? dashboard.totalAdms : '6'}</p>
                <span class="tendencia">Sem alteração</span>
            </div>
            <div class="card">
                <p>PROFESSORES</p>
                <p>${dashboard.totalProfessores != null ? dashboard.totalProfessores : '13'}</p>
                <span class="tendencia">↑ 2 novos</span>
            </div>
        </section>

        <!-- Segunda linha de cards -->
        <section class="secao_card">
            <div class="card">
                <p>FALTAS DE PROFESSORES</p>
                <p>${dashboard.faltasProfessores != null ? dashboard.faltasProfessores : '13'}</p>
                <span class="tendencia negativa">↑ 4 vs semana ant.</span>
            </div>
            <div class="card">
                <p>FALTAS DE ALUNOS</p>
                <p>${dashboard.faltasAlunos != null ? dashboard.faltasAlunos : '13'}</p>
                <span class="tendencia negativa">↑ 2 vs ontem</span>
            </div>
            <div class="card">
                <p>REUNIÕES</p>
                <p>${dashboard.reunioes != null ? dashboard.reunioes : '67'}</p>
                <span class="tendencia">↑ 12 este mês</span>
            </div>
            <div class="card">
                <p>ESCOLAS ATIVAS</p>
                <p>${dashboard.escolasAtivas != null ? dashboard.escolasAtivas : '6'}</p>
                <span class="tendencia">↑ Todas operando</span>
            </div>
        </section>
    </section>

    <!-- SEÇÃO ALUNOS (TABELA ILUSTRATIVA) -->
    <section id="alunos" class="secao-tabela">
        <h2>Alunos</h2>
        <div class="tabela-container">
            <table class="tabela-ilustrativa">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Matrícula</th>
                    <th>Turma</th>
                    <th>Email</th>
                </tr>
                </thead>
                <tbody>
                <tr><td>1</td><td>João Silva</td><td>2024001</td><td>3º Ano A</td><td>joao@email.com</td></tr>
                <tr><td>2</td><td>Maria Oliveira</td><td>2024002</td><td>3º Ano B</td><td>maria@email.com</td></tr>
                <tr><td>3</td><td>Pedro Santos</td><td>2024003</td><td>2º Ano A</td><td>pedro@email.com</td></tr>
                <tr><td>4</td><td>Ana Souza</td><td>2024004</td><td>2º Ano B</td><td>ana@email.com</td></tr>
                <tr><td>5</td><td>Lucas Lima</td><td>2024005</td><td>1º Ano A</td><td>lucas@email.com</td></tr>
                </tbody>
            </table>
        </div>
    </section>

    <!-- SEÇÃO PROFESSORES (TABELA ILUSTRATIVA) -->
    <section id="professores" class="secao-tabela">
        <h2>Professores</h2>
        <div class="tabela-container">
            <table class="tabela-ilustrativa">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Disciplina</th>
                    <th>Email</th>
                    <th>Telefone</th>
                </tr>
                </thead>
                <tbody>
                <tr><td>1</td><td>Carlos Santos</td><td>Matemática</td><td>carlos@email.com</td><td>(11) 97777-7777</td></tr>
                <tr><td>2</td><td>Ana Paula</td><td>Português</td><td>ana@email.com</td><td>(11) 96666-6666</td></tr>
                <tr><td>3</td><td>Roberto Lima</td><td>História</td><td>roberto@email.com</td><td>(11) 95555-5555</td></tr>
                <tr><td>4</td><td>Mariana Costa</td><td>Ciências</td><td>mariana@email.com</td><td>(11) 94444-4444</td></tr>
                </tbody>
            </table>
        </div>
    </section>

    <!-- SEÇÃO MATÉRIAS (TABELA ILUSTRATIVA) -->
    <section id="materias" class="secao-tabela">
        <h2>Matérias</h2>
        <div class="tabela-container">
            <table class="tabela-ilustrativa">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Carga Horária</th>
                    <th>Professor</th>
                    <th>Turmas</th>
                </tr>
                </thead>
                <tbody>
                <tr><td>1</td><td>Matemática</td><td>80h</td><td>Carlos Santos</td><td>3º A, 3º B</td></tr>
                <tr><td>2</td><td>Português</td><td>80h</td><td>Ana Paula</td><td>2º A, 2º B</td></tr>
                <tr><td>3</td><td>História</td><td>60h</td><td>Roberto Lima</td><td>1º A, 1º B</td></tr>
                <tr><td>4</td><td>Ciências</td><td>60h</td><td>Mariana Costa</td><td>3º A, 3º B</td></tr>
                </tbody>
            </table>
        </div>
    </section>
</main>

<%
    }
%>

<!-- SCRIPTS PARA SCROLL SUAVE E DESTAQUE DO MENU -->
<script>
    // Scroll suave ao clicar nos links
    document.querySelectorAll('.campos').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);

            targetSection.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        });
    });

    // Destacar link ativo durante a rolagem
    window.addEventListener('scroll', function() {
        const sections = document.querySelectorAll('section[id]');
        const navLinks = document.querySelectorAll('.campos');

        let current = '';

        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;

            if (pageYOffset >= sectionTop - 100) {
                current = section.getAttribute('id');
            }
        });

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === '#' + current) {
                link.classList.add('active');
            }
        });
    });
</script>
</body>
</html>


<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="pt-br">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_inicio_adm.css">--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_global.css">--%>

<%--    <!-- Favicon - agora fora do WEB-INF -->--%>
<%--    <link rel="shortcut icon" href="${pageContext.request.contextPath}/fotos/logo_escolApp.png" type="image/x-icon">--%>

<%--    <title>EscolApp - Dashboard</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container_conteudo_usuario">--%>

<%--    <!-- Informaçoes do Usuario-->--%>
<%--    <div class="informacao_usuario">--%>
<%--        <div>--%>
<%--            <!-- Imagem do usuário - fora do WEB-INF -->--%>
<%--            <img src="${pageContext.request.contextPath}/fotos/ronaldinho.png"--%>
<%--                 alt="imagem_usuario" class="img_usuario">--%>
<%--            <p>${usuario.turma}</p>--%>
<%--        </div>--%>
<%--        <p>${usuario.nome}</p>--%>
<%--    </div>--%>

<%--    <!-- Menu -->--%>
<%--    <div class="aside">--%>
<%--        <a href="inicio.html" class="campos usado">--%>
<%--            <img src="${pageContext.request.contextPath}/fotos/icone_casa.png"--%>
<%--                 alt="icone"> Início--%>
<%--        </a>--%>

<%--        <a href="notas.html" class="campos">--%>
<%--            <img src="${pageContext.request.contextPath}/fotos/icone_certinho.png"--%>
<%--                 alt="icone"> Usuários--%>
<%--        </a>--%>

<%--        <a href="materias.html" class="campos">--%>
<%--            <img src="${pageContext.request.contextPath}/fotos/icone_livro.png"--%>
<%--                 alt="icone"> Turmas--%>
<%--        </a>--%>

<%--        <a href="calendario.html" class="campos">--%>
<%--            <img src="${pageContext.request.contextPath}/fotos/icone_ruim.png"--%>
<%--                 alt="icone"> Relatórios--%>
<%--        </a>--%>
<%--    </div>--%>

<%--</div>--%>

<%--<section id="container_dashboard">--%>
<%--    <p id="ola">--%>
<%--        Olá <strong>${usuario.primeiroNome}</strong>--%>
<%--        <img src="${pageContext.request.contextPath}/fotos/icone_chapeu.png" alt="icone">--%>
<%--    </p>--%>

<%--    <h1>Cadastros</h1>--%>
<%--    <section class="secao_card">--%>
<%--        <div class="card">--%>
<%--            <p>Total Usuários</p>--%>
<%--            <p>${dashboard.totalUsuarios}</p>--%>
<%--        </div>--%>
<%--        <div class="card">--%>
<%--            <p>Alunos Cadastrados</p>--%>
<%--            <p>${dashboard.totalAlunos}</p>--%>
<%--        </div>--%>
<%--        <div class="card">--%>
<%--            <p>Professores Cadastrados</p>--%>
<%--            <p>${dashboard.totalProfessores}</p>--%>
<%--        </div>--%>
<%--        <div class="card">--%>
<%--            <p>Adms Cadastrados</p>--%>
<%--            <p>${dashboard.totalAdms}</p>--%>
<%--        </div>--%>
<%--    </section>--%>

<%--    <h1>Faltas</h1>--%>
<%--    <section class="secao_card">--%>
<%--        <div class="card">--%>
<%--            <p>Faltas alunos</p>--%>
<%--            <p>${dashboard.faltasAlunos}</p>--%>
<%--        </div>--%>
<%--        <div class="card">--%>
<%--            <p>Faltas Professores</p>--%>
<%--            <p>${dashboard.faltasProfessores}</p>--%>
<%--        </div>--%>
<%--    </section>--%>
<%--</section>--%>
<%--</body>--%>
<%--</html>--%>
