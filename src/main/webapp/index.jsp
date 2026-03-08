<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_login.css">
    <title>Login - Sistema Escolar</title>
</head>

<body>
<div id="container_login">
    <h1 id="titulo">Bem-vindo!</h1>
    <p style="text-align: center; color: #718096; margin-bottom: 30px;">Faça login para acessar o sistema</p>

    <form action="<%= request.getContextPath() %>/login" method="post" id="container_dados">
        <input type="text" name="username" class="campo_input" placeholder="Nome de usuário" required>
        <input type="password" name="senha" class="campo_input" placeholder="Senha" required>

        <div id="container_botoes">
            <button type="button" class="botoes" id="cancelar">Cancelar</button>
            <button type="submit" class="botoes" id="confirmar">Entrar</button>
        </div>
    </form>
</div>
</body>

</html>


<%--<%@ page contentType="text/html; charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="pt-br">--%>

<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_login.css">--%>
<%--    <title>Login</title>--%>
<%--</head>--%>

<%--<body>--%>
<%--<div id="container_login">--%>

<%--    <h1 id="titulo">Login</h1>--%>

<%--    <form action="<%= request.getContextPath() %>/login" method="post" id="container_dados">--%>

<%--        <!-- inputs de dados do cadastro <input type="email" name="email" class="campo_input" placeholder="Email:"> -->--%>
<%--        <input type="text" name="username" class="campo_input" placeholder="Username:">--%>
<%--        <input type="password" name="senha" class="campo_input" placeholder="Senha:">--%>

<%--        <!-- botões -->--%>
<%--        <div id="container_botoes">--%>
<%--            <button type="button" class="botoes" id="cancelar">Cancelar</button>--%>
<%--            <button type="submit" class="botoes" id="confirmar">Confirmar</button>--%>
<%--        </div>--%>

<%--    </form>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>

