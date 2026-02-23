<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>../webapp/css/bem_vindo.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Condiment&family=Grey+Qo&family=Jomhuria&family=Monomakh&family=Petit+Formal+Script&family=Rubik+Puddles&display=swap" rel="stylesheet">
    
    <link rel="shortcut icon" href="assets/logo_escolApp.png" type="image/x-icon">
    <title>Bem vindo</title>
</head>

<body>
    <section id="icones">
        <%-- Nota: Arquivos dentro de WEB-INF não são acessíveis diretamente pelo navegador --%>
        <img src="assets/porta.png" alt="porta" id="porta">
        <img src="assets/mesa_professor.png" alt="mesa professor" id="mesa">
    </section>

    <div id="conteudo">
        <h1>Bem vindo ao EscolApp</h1>
        <p>O aplicativo ideal para alunos e professores.</p>
        
        <div>
            <a href="login.jsp" id="proxima">Próxima página</a>
            <img src="assets/icone_cetinha_branca.png" alt="Seta">
        </div>
    </div>
</body>

</html>