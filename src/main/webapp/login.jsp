<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- IMPEDIR CACHE DO NAVEGADOR -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">

    <title>Login - EscolaApp</title>
</head>

<body style="
margin:0;
font-family:Arial, Helvetica, sans-serif;
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#4a6fa5,#6c8cd5,#7fa4ff);
overflow:hidden;
">

<!-- Ícones decorativos -->
<div style="position:absolute;font-size:140px;opacity:0.05;top:10%;left:10%;">📚</div>
<div style="position:absolute;font-size:120px;opacity:0.05;bottom:10%;right:10%;">✏</div>
<div style="position:absolute;font-size:90px;opacity:0.05;top:65%;left:25%;">🎓</div>

<!-- Botão voltar -->
<a href="<%= request.getContextPath() %>/index.html"
   style="
position:absolute;
top:25px;
left:25px;
background:white;
color:#2b6cb0;
padding:10px 18px;
border-radius:10px;
text-decoration:none;
font-weight:bold;
box-shadow:0 6px 15px rgba(0,0,0,0.2);
transition:0.3s;
"
   onmouseover="this.style.transform='scale(1.05)'"
   onmouseout="this.style.transform='scale(1)'"
>
    ← Voltar
</a>

<!-- Container -->
<div style="
width:360px;
padding:40px;
border-radius:16px;
background:rgba(255,255,255,0.25);
backdrop-filter:blur(15px);
box-shadow:0 15px 40px rgba(0,0,0,0.3);
color:white;
text-align:center;
">

    <h1 style="margin-bottom:5px;">🎓 EscolaApp</h1>
    <p style="font-size:14px;margin-bottom:25px;opacity:0.9;">
        Acesse sua conta
    </p>

    <!-- Mensagem de erro -->
    <div id="erro"
         style="
background:#ffdddd;
color:#b00020;
padding:8px;
border-radius:6px;
font-size:13px;
margin-bottom:15px;
display:none;
">
        Usuário ou senha incorretos
    </div>

    <form action="<%= request.getContextPath() %>/login" method="post">
        <!-- usuário -->
        <div style="margin-bottom:15px;text-align:left;">
            <label style="font-size:14px;">👤 Usuário</label>
            <input type="text" name="username" required
                   style="
width:100%;
padding:12px;
margin-top:5px;
border:none;
border-radius:8px;
background:rgba(255,255,255,0.9);
font-size:14px;
outline:none;
"
                   placeholder="Digite seu usuário">
        </div>

        <!-- senha -->
        <div style="margin-bottom:20px;text-align:left;position:relative;">
            <label style="font-size:14px;">🔒 Senha</label>
            <input id="senha" type="password" name="senha" required
                   style="
width:100%;
padding:12px;
margin-top:5px;
border:none;
border-radius:8px;
background:rgba(255,255,255,0.9);
font-size:14px;
outline:none;
"
                   placeholder="Digite sua senha">
            <span onclick="mostrarSenha()"
                  style="
position:absolute;
right:10px;
top:37px;
cursor:pointer;
color:#333;
font-size:14px;">
            </span>
        </div>

        <!-- botões -->
        <div style="display:flex;justify-content:space-between;">
            <button type="button"
                    style="
padding:10px 18px;
border:none;
border-radius:8px;
background:#ff6b6b;
color:white;
font-weight:bold;
cursor:pointer;
transition:0.3s;
"
                    onmouseover="this.style.transform='scale(1.05)'"
                    onmouseout="this.style.transform='scale(1)'"
                    onclick="window.location.href='<%= request.getContextPath() %>/index.html'">
                Cancelar
            </button>

            <button type="submit"
                    style="
padding:10px 18px;
border:none;
border-radius:8px;
background:#2b6cb0;
color:white;
font-weight:bold;
cursor:pointer;
transition:0.3s;
"
                    onmouseover="this.style.transform='scale(1.05)'"
                    onmouseout="this.style.transform='scale(1)'">
                Entrar
            </button>
        </div>
    </form>

    <!-- Link para cadastro -->
    <div style="margin-top:25px; padding-top:20px; border-top:1px solid rgba(255,255,255,0.3);">
        <p style="font-size:14px; opacity:0.9; margin-bottom:10px;">
            Não tem uma conta?
        </p>
        <a href="<%= request.getContextPath() %>/cadastroAluno"
           style="
display:inline-block;
padding:10px 25px;
background:rgba(255,255,255,0.2);
color:white;
text-decoration:none;
border-radius:8px;
font-weight:bold;
border:2px solid white;
transition:0.3s;
"
           onmouseover="this.style.background='white'; this.style.color='#2b6cb0';"
           onmouseout="this.style.background='rgba(255,255,255,0.2)'; this.style.color='white';">
            Cadastre-se como Aluno
        </a>
    </div>
</div>

<script>
    function mostrarSenha(){
        let campo = document.getElementById("senha");
        if(campo.type === "password"){
            campo.type = "text";
        }else{
            campo.type = "password";
        }
    }

    window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    });

    history.pushState(null, null, location.href);
    window.onpopstate = function() {
        history.go(1);
    };

    <% if (request.getAttribute("erro") != null) { %>
    document.getElementById("erro").style.display = "block";
    document.getElementById("erro").innerHTML = "<%= request.getAttribute("erro") %>";
    <% } %>

    // VERIFICA SE USUÁRIO JÁ ESTÁ LOGADO E REDIRECIONA
    <%
        HttpSession sessao = request.getSession(false);
        if(sessao != null && sessao.getAttribute("alunoLogado") != null) {
    %>
    window.location.href = '<%= request.getContextPath() %>/aluno/dashboard';
    <%
        } else if(sessao != null && sessao.getAttribute("professorLogado") != null) {
    %>
    window.location.href = '<%= request.getContextPath() %>/professor?acao=dashboard';
    <%
        } else if(sessao != null && sessao.getAttribute("admLogado") != null) {
    %>
    window.location.href = '<%= request.getContextPath() %>/adm?acao=dashboard';
    <% } %>
</script>

</body>
</html>