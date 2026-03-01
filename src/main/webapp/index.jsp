<%--
  Created by IntelliJ IDEA.
  User: davidbento-ieg
  Date: 09/02/2026
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_login.css">
    <title>Login</title>
</head>

<body>
<div id="container_login">

    <h1 id="titulo">Cadastrar</h1>

    <form action="<%= request.getContextPath() %>/login" method="post" id="container_dados">

        <!-- inputs de dados do cadastro -->
        <input type="text" name="nome" class="campo_input" placeholder="Nome:">
        <input type="password" name="senha" class="campo_input" placeholder="Senha:">
        <input type="email" name="email" class="campo_input" placeholder="Email:">
        <input type="text" name="cpf" class="campo_input" placeholder="CPF:">
        <input type="text" name="cep" class="campo_input" placeholder="CEP:">

        <!-- botões -->
        <div id="container_botoes">
            <button type="button" class="botoes" id="cancelar">Cancelar</button>
            <button type="submit" class="botoes" id="confirmar">Confirmar</button>
        </div>

    </form>

</div>
</body>

</html>
