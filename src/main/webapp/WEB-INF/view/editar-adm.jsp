<%@ page import="com.escolApp.model.Adm" %>
<%
    Adm adm = (Adm) request.getAttribute("adm");
%>

<form action="${pageContext.request.contextPath}/adm" method="post">
    <input type="hidden" name="acao" value="editar">
    <input type="hidden" name="id" value="<%= adm.getId() %>">

    Nome: <input type="text" name="username" value="<%= adm.getUsername() %>"><br>
    Email: <input type="email" name="email" value="<%= adm.getEmail() %>"><br>
    Senha: <input type="password" name="senha" placeholder="Digite nova senha (opcional)"><br>

    <button type="submit">Salvar</button>
</form>

