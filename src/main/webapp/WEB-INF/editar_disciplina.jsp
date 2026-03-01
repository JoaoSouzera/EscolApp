<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EscolApp - Editar Disciplina</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>./WEB-INF/css/style_global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>./WEB-INF/css/add_disciplina.css">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>./WEB-INF/assets/logo_escolApp.png" type="image/x-icon">
</head>
<body>
    <div class="container_conteudo_usuario">
        <div class="informacao_usuario">
            <div>
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/ronaldinho.png" alt="imagem_usuario" class="img_usuario">
            </div>
            <p>Alexandre o Grande</p>
        </div>

        <div class="aside">
            <a href="inicio_adm.jsp" class="campos">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_casa.png" alt="icone"> Início
            </a>
            <a href="usuarios_adm.jsp" class="campos">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_casa.png" alt="icone"> Usuários
            </a>
            <a href="disciplinas_adm.jsp" class="campos usado">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_livro.png" alt="icone"> Disciplinas
            </a>
            <a href="configuracoes.jsp" class="campos">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_calendario.png" alt="icone"> Configurações
            </a>
        </div>
    </div>

    <section>
        <div class="form-card">
            <h2>Editar Disciplina</h2>

            <form action="EditDisciplinaServlet" method="post">

                <input type="hidden" name="id" value="${disciplina.id}">

                <div class="field">
                    <label for="id_display">ID</label>
                    <input type="text" id="id_display" value="${disciplina.id}" disabled>
                </div>

                <div class="field">
                    <label for="nome">Disciplina</label>
                    <input type="text" id="nome" name="nome" value="${disciplina.nome}" placeholder="Ex: Matemática">
                </div>

                <div class="field">
                    <label for="professor">Professor</label>
                    <input type="text" id="professor" name="professor" value="${disciplina.professor}" placeholder="Nome do professor">
                </div>

                <div class="btn-row">
                    <a href="disciplinas_adm.jsp" class="btn-cancelar">Cancelar</a>
                    <button type="submit" class="btn-confirmar">Confirmar</button>
                </div>

            </form>
        </div>
    </section>

</body>
</html>
