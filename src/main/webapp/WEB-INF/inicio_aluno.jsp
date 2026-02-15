<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>../webapp/css/inicio_aluno.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>../webapp/css/style_global.css">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>../WEB-INF/assets/logo" type="image/x-icon">
    <title>Início</title>
</head>

<body>

<!-- Container Principal -->
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
</div>

<!-- Conteudo Principal -->
<div class="container_aside_materias">

    <!-- Busca -->
    <form class="container_busca" action="buscarMateria" method="get">
        <img src="../WEB-INF/assets/icone_lupa.png" alt="icone">
        <input type="text" name="busca" placeholder="Buscar Matéria" class="input_busca">
    </form>

    <h1>
        Olá <strong>${usuario.apelido}</strong>
        <img src="../WEB-INF/assets/icone_chapeu.png" alt="icone">
    </h1>

    <!-- Informaçoes Gerais -->
    <section class="container_conteudo_info">

        <div class="container_principal media">
            <div>
                <img src="../WEB-INF/assets/icone_estrela.png" alt="icone">
                <p>${usuario.media}</p>
            </div>
            <p>Média</p>
        </div>

        <div class="container_principal frequencia">
            <div>
                <img src="../WEB-INF/assets/icone_certinho.png" alt="icone">
                <p>${usuario.frequencia}%</p>
            </div>
            <p>Frequência</p>
        </div>

        <div class="container_principal prova">
            <div>
                <img src="../WEB-INF/assets/icone_calendario.png" alt="icone">
                <p>${usuario.proximaProva}</p>
            </div>
            <p>Próxima prova</p>
        </div>

        <div id="container_divisao">

            <div class="container_ramo pendencias">
                <img src="../WEB-INF/assets/icone_exclamacao.png" alt="icone">
                <h1>${usuario.pendencias}</h1>
                <p>Pendências</p>
            </div>

            <form class="container_ramo mensagens" action="mensagens" method="get">
                <button>
                    <img src="../WEB-INF/assets/icone_email.png" alt="icone">
                    <p>Mensagens</p>
                    <img src="../WEB-INF/assets/icone_cetinha_branca.png" alt="icone">
                </button>
            </form>

        </div>
    </section>

    <p id="notas">Minhas notas:</p>

    <!-- Notas -->
    <section class="container_notas">

        <c:forEach var="nota" items="${notas}">
            <div class="container_card ${nota.status}">
                <p>${nota.materia}</p>

                <div class="nota">
                    <p>${nota.valor}</p>
                    <img src="${nota.icone}" alt="icone">
                </div>

                <p>Professor: ${nota.professor}</p>
                <hr>

                <form action="detalhesNota" method="get">
                    <input type="hidden" name="idNota" value="${nota.id}">
                    <button>
                        <p>Ver detalhes</p>
                        <img src="../WEB-INF/assets/icone_cetinha.png" alt="icone">
                    </button>
                </form>
            </div>
        </c:forEach>

    </section>

    <!-- Aulas -->
    <section class="container_aulas">

        <div class="conteiner_conteudo_aulas">
            <c:forEach var="aula" items="${aulas}">
                <div class="aulas">
                    <img src="${aula.icone}" alt="">
                    <div>
                        <p>${aula.professor}</p>
                        <p>${aula.materia}</p>
                    </div>
                    <p>${aula.horario}</p>
                </div>
            </c:forEach>
        </div>

        <!-- Provas -->
        <div id="datas_prova">

            <div class="datas_prova_header">
                <p>Ver calendário completo</p>
                <a href="detalhes_provas.jsp">
                    <img src="../WEB-INF/assets/icone_cetinha.png" alt="icone">
                </a>
            </div>

            <hr>

            <c:forEach var="prova" items="${provas}">
                <div class="detalhes_provas">
                    <p>${prova.data}</p>
                    <img src="${prova.icone}" alt="icone">
                    <p>${prova.descricao}</p>
                </div>
            </c:forEach>

        </div>

    </section>
</div>

</body>
</html>
