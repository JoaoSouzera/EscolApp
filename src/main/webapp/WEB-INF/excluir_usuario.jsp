<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EscolApp</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>./WEB-INF/css/style_global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>./WEB-INF/css/add_usuario.css">
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
            <a href="usuarios_adm.jsp" class="campos usado">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_casa.png" alt="icone"> Usuários
            </a>
            <a href="disciplinas_adm.jsp" class="campos">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_livro.png" alt="icone"> Disciplinas
            </a>
            <a href="configuracoes.jsp" class="campos">
                <img src="<%= request.getContextPath() %>./WEB-INF/assets/icone_calendario.png" alt="icone"> Configurações
            </a>
        </div>
    </div>

    <section>
        <div class="form-card">
            <h2>Tem certeza que deseja excluir ${usuario.nome} ?</h2>

            <form action="EditUsuarioServlet" method="post">

                <input type="hidden" name="id" value="${usuario.id}">

                <div class="row-top">
                    <div class="field">
                        <label for="id_display">ID</label>
                        <input type="text" id="id_display" value="${usuario.id}" disabled>
                    </div>
                    <div class="field">
                        <label for="tipo">Tipo</label>
                        <select id="tipo" name="tipo">
                            <option value="professor" ${usuario.tipo == 'professor' ? 'selected' : ''}>Professor</option>
                            <option value="aluno"     ${usuario.tipo == 'aluno'     ? 'selected' : ''}>Aluno</option>
                            <option value="adm"       ${usuario.tipo == 'adm'       ? 'selected' : ''}>Administrador</option>
                        </select>
                    </div>
                </div>

                <div class="field full">
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" value="${usuario.nome}" placeholder="Nome completo">
                </div>

                <div class="field full">
                    <label for="senha">Senha</label>
                    <div style="display:flex; align-items:center; gap:0.5rem;">
                        <input type="password" id="senha" name="senha" value="${usuario.senha}" placeholder="••••••••" style="flex:1;">
                    </div>
                </div>

                <div class="field materia-field">
                <%-- só para os professores, colocar span ao lado do label? ou não ? ( <span style="font-weight:400;color:#aaa;">(somente para professores)</span> )--%>
                    <label for="materia">Matéria</label>
                    <input type="text" id="materia" name="materia" value="${usuario.materia}" placeholder="Ex: Matemática">
                </div>

                <div class="btn-row">
                    <a href="usuarios_adm.jsp" class="btn-cancelar">Cancelar</a>
                    <button type="submit" class="btn-confirmar">confirmar</button>
                </div>

            </form>
        </div>
    </section>

</body>
</html>