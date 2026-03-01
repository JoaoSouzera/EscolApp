<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EscolApp - Disciplinas</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>./WEB-INF/css/style_global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>./WEB-INF/css/usuarios_adm.css">
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
        <h1 class="page-title"></h1>

        <div class="content-row">
            <div class="list-card">
                <%
                    List<?> disciplinas = (List<?>) request.getAttribute("disciplinas");
                    if (disciplinas != null) {
                        for (Object obj : disciplinas) {
                            model.Disciplina d = (model.Disciplina) obj;
                %>
                <div class="disciplina-item">
                    <div class="disciplina-bar"></div>
                    <span class="disciplina-nome"><%= d.getNome() %></span>
                    <div class="action-btns">
                        <a href="./WEB-INF/editar_disciplina.jsp=<%= d.getId() %>" class="btn-edit"><img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_editar.png" alt="editar"></a>
                        <a href="./WEB-INF/excluir_disciplina.jsp=<%= d.getId() %>" class="btn-del"><img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_lixeira.png" alt="deletar"></a>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>

            <a href="add_disciplina.jsp" class="add-btn">
                <span class="plus-circle"><img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_mais.png" alt="deletar"></span>
                Adicionar Disciplina
            </a>
        </div>
    </section>

</body>
</html>
