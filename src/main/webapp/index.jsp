<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Sistema</title>
</head>
<body>

<h2>🔐 Login</h2>

<form action="${pageContext.request.contextPath}/login" method="post">
    Usuário: <input type="text" name="username"><br><br>
    Senha: <input type="password" name="senha"><br><br>
    <button type="submit">Entrar</button>
</form>

<%
    String erro = (String) request.getAttribute("erro");
    if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
    }
%>

</body>
</html>

