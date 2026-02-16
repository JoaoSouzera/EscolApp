<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Cadastro ADM</title>
</head>
<body>

    <h2>Administrador</h2>

    <form action="${pageContext.request.contextPath}/adm" method="post">
        <input type="hidden" name="acao" value="salvar">

        Username: <input type="text" name="username"><br><br>
        Email: <input type="text" name="email"><br><br>
        Senha: <input type="password" name="senha"><br><br>

        <button type="submit">Salvar</button>
    </form>

</body>
</html>
