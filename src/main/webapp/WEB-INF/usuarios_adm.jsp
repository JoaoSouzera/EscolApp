<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EscolApp</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/WEB-INF/css/style_global.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/WEB-INF/css/usuarios_adm.css">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/WEB-INF/assets/logo_escolApp.png" type="image/x-icon">
</head>
<body>

    <div class="container_conteudo_usuario">
        <div class="informacao_usuario">
            <div>
                <img src="<%= request.getContextPath() %>/WEB-INF/assets/ronaldinho.png" alt="imagem_usuario" class="img_usuario">
            </div>
            <p>Alexandre o Grande</p>
        </div>

        <div class="aside">
            <a href="inicio_adm.jsp" class="campos">
                <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_casa.png" alt="icone"> Início
            </a>
            <a href="usuarios_adm.jsp" class="campos usado">
                <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_casa.png" alt="icone"> Usuários
            </a>
            <a href="disciplinas_adm.jsp" class="campos">
                <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_livro.png" alt="icone"> Disciplinas
            </a>
            <a href="configuracoes.jsp" class="campos">
                <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_calendario.png" alt="icone"> Configurações
            </a>
        </div>
    </div>

    <section>
        <div class="topbar">
            <div class="filter-tabs">
                <a href="UsuarioServlet?filtro=todos"      class="tab-btn ${filtro == 'todos'      ? 'active' : ''}">Todos</a>
                <a href="UsuarioServlet?filtro=alunos"     class="tab-btn ${filtro == 'alunos'     ? 'active' : ''}">Alunos</a>
                <a href="UsuarioServlet?filtro=professores" class="tab-btn ${filtro == 'professores' ? 'active' : ''}">Professores</a>
            </div>
            <a href="add_usuario.jsp" class="add-btn">
                <span class="plus-circle">
                    <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_mais.png" alt="">
                </span> Adicionar usuário
            </a>
        </div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuário</th>
                        <th>E-mail</th>
                        <th>Senha</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<?> usuarios = (List<?>) request.getAttribute("usuarios");
                        if (usuarios != null) {
                            for (Object obj : usuarios) {
                           
                    %>
                    <tr>
                        <td><%= ((model.Usuario) obj).getId() %></td>
                        <td><%= ((model.Usuario) obj).getNome() %></td>
                        <td><%= ((model.Usuario) obj).getEmail() %></td>
                        <td class="senha-dots">••••••</td>
                        <td>
                            <div class="action-btns">
                                <a href="EditUsuarioServlet?id=<%= ((model.Usuario) obj).getId() %>" class="btn-edit">
                                    <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_editar.png" alt="editar">
                                </a>
                                <a href="DeleteUsuarioServlet?id=<%= ((model.Usuario) obj).getId() %>" class="btn-del">
                                    <img src="<%= request.getContextPath() %>/WEB-INF/assets/icone_lixeira.png" alt="deletar">
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </section>

</body>
</html>