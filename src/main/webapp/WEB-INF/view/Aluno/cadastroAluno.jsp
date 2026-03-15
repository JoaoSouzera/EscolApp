<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="../WEB-INF/assets/images/logo_escolApp.png">
  <title>Cadastro de Aluno - EscolaApp</title>
</head>

<body style="
margin:0;
font-family:Arial, Helvetica, sans-serif;
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#4a6fa5,#6c8cd5,#7fa4ff);
padding:20px;
">

<!-- Ícones decorativos -->
<div style="position:fixed;font-size:140px;opacity:0.05;top:10%;left:10%;">📚</div>
<div style="position:fixed;font-size:120px;opacity:0.05;bottom:10%;right:10%;">✏</div>
<div style="position:fixed;font-size:90px;opacity:0.05;top:65%;left:25%;">🎓</div>

<!-- Botão voltar -->
<a href="<%= request.getContextPath() %>/login.jsp"
   style="
position:fixed;
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
z-index:100;
"
   onmouseover="this.style.transform='scale(1.05)'"
   onmouseout="this.style.transform='scale(1)'"
>
  ← Voltar ao Login
</a>

<!-- Container de cadastro -->
<div style="
width:450px;
padding:40px;
border-radius:16px;
background:rgba(255,255,255,0.25);
backdrop-filter:blur(15px);
box-shadow:0 15px 40px rgba(0,0,0,0.3);
color:white;
position:relative;
z-index:10;
">

  <h1 style="margin-bottom:5px; text-align:center;">📝 Cadastro de Aluno</h1>
  <p style="font-size:14px;margin-bottom:25px;opacity:0.9; text-align:center;">
    Preencha os dados para criar sua conta
  </p>

  <!-- Mensagem de erro/sucesso -->
  <% if (request.getAttribute("erro") != null) { %>
  <div style="
background:#ffdddd;
color:#b00020;
padding:10px;
border-radius:6px;
font-size:13px;
margin-bottom:20px;
text-align:center;
">
    <%= request.getAttribute("erro") %>
  </div>
  <% } %>

  <% if (request.getAttribute("sucesso") != null) { %>
  <div style="
background:#ddffdd;
color:#006600;
padding:10px;
border-radius:6px;
font-size:13px;
margin-bottom:20px;
text-align:center;
">
    <%= request.getAttribute("sucesso") %>
  </div>
  <% } %>

  <form action="<%= request.getContextPath() %>/cadastroAluno" method="post">
    <!-- Nome completo -->
    <div style="margin-bottom:15px;text-align:left;">
      <label style="font-size:14px; font-weight:bold;">👤 Nome Completo</label>
      <input type="text" name="nome" required
             style="
width:100%;
padding:12px;
margin-top:5px;
border:none;
border-radius:8px;
background:rgba(255,255,255,0.9);
font-size:14px;
outline:none;
box-sizing:border-box;
"
             placeholder="Digite seu nome completo"
             value="<%= request.getParameter("nome") != null ? request.getParameter("nome") : "" %>">
    </div>

    <!-- Email -->
    <div style="margin-bottom:15px;text-align:left;">
      <label style="font-size:14px; font-weight:bold;">📧 Email</label>
      <input type="email" name="email" required
             style="
width:100%;
padding:12px;
margin-top:5px;
border:none;
border-radius:8px;
background:rgba(255,255,255,0.9);
font-size:14px;
outline:none;
box-sizing:border-box;
"
             placeholder="Digite seu email"
             value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
    </div>

    <!-- Username -->
    <div style="margin-bottom:15px;text-align:left;">
      <label style="font-size:14px; font-weight:bold;">🔑 Username</label>
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
box-sizing:border-box;
"
             placeholder="Escolha um nome de usuário"
             value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
    </div>

    <!-- Senha -->
    <div style="margin-bottom:15px;text-align:left;position:relative;">
      <label style="font-size:14px; font-weight:bold;">🔒 Senha</label>
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
box-sizing:border-box;
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

    <!-- Confirmar Senha -->
    <div style="margin-bottom:20px;text-align:left;position:relative;">
      <label style="font-size:14px; font-weight:bold;">🔒 Confirmar Senha</label>
      <input id="confirmarSenha" type="password" name="confirmarSenha" required
             style="
width:100%;
padding:12px;
margin-top:5px;
border:none;
border-radius:8px;
background:rgba(255,255,255,0.9);
font-size:14px;
outline:none;
box-sizing:border-box;
"
             placeholder="Confirme sua senha">
      <span onclick="mostrarConfirmarSenha()"
            style="
position:absolute;
right:10px;
top:37px;
cursor:pointer;
color:#333;
font-size:14px;">
            </span>
    </div>

    <!-- Informação sobre matrícula -->
    <div style="
margin-bottom:25px;
padding:10px;
background:rgba(255,255,255,0.15);
border-radius:8px;
font-size:13px;
text-align:center;
">
      <i>📌 Sua matrícula será gerada automaticamente pelo sistema</i>
    </div>

    <!-- Botões -->
    <div style="display:flex;justify-content:space-between; gap:10px;">
      <button type="button"
              style="
flex:1;
padding:12px;
border:none;
border-radius:8px;
background:#ff6b6b;
color:white;
font-weight:bold;
cursor:pointer;
transition:0.3s;
"
              onmouseover="this.style.transform='scale(1.02)'"
              onmouseout="this.style.transform='scale(1)'"
              onclick="window.location.href='<%= request.getContextPath() %>/login.jsp'">
        Cancelar
      </button>

      <button type="submit"
              style="
flex:1;
padding:12px;
border:none;
border-radius:8px;
background:#2b6cb0;
color:white;
font-weight:bold;
cursor:pointer;
transition:0.3s;
"
              onmouseover="this.style.transform='scale(1.02)'"
              onmouseout="this.style.transform='scale(1)'">
        Cadastrar
      </button>
    </div>
  </form>

  <!-- Link para login -->
  <div style="margin-top:20px; text-align:center;">
    <a href="<%= request.getContextPath() %>/login.jsp"
       style="
color:white;
font-size:14px;
opacity:0.9;
text-decoration:none;
">
      Já tem uma conta? <strong>Faça login</strong>
    </a>
  </div>
</div>

<script>
  function mostrarSenha(){
    let campo = document.getElementById("senha");
    campo.type = campo.type === "password" ? "text" : "password";
  }

  function mostrarConfirmarSenha(){
    let campo = document.getElementById("confirmarSenha");
    campo.type = campo.type === "password" ? "text" : "password";
  }

  // Validação básica no cliente
  document.querySelector('form').addEventListener('submit', function(e) {
    let senha = document.getElementById('senha').value;
    let confirmar = document.getElementById('confirmarSenha').value;

    if (senha !== confirmar) {
      e.preventDefault();
      alert('As senhas não conferem!');
    }
  });
</script>

</body>
</html>