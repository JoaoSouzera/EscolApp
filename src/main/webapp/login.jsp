<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Login -EscolApp</title>
    <link rel="icon" href="../WEB-INF/assets/images/logo_escolApp.png">

    <style>
        :root {
            --preto: rgb(12, 9, 44);
            --azul-claro: #0099ff;
            --vermelho: #ff0000;
            --verde: #00ff00;
            --azul: #0099ff;
            --white: rgb(242, 242, 242);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            background-color: var(--preto);
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            height: 100vh;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background:
                    linear-gradient(rgba(240, 228, 225, 0.03) 2px, transparent 2px),
                    linear-gradient(90deg, rgba(255, 255, 255, 0.03) 2px, transparent 2px);
            background-size: 70px 70px;
            pointer-events: none;
            z-index: 0;
        }
        .return {
            position: absolute;
            top: 2rem;
            left: 2rem;
            background: white;
            color: #2b6cb0;
            padding: 0.8rem 1rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }
        .return:hover{
            transform: scale(1.05);
        }

        .container {
            background-color: #fff;
            border-radius: 30px;
            box-shadow: 0 5px 15px var(--preto);
            position: relative;
            overflow: hidden;
            width: 768px;
            max-width: 100%;
            min-height: 480px;
        }

        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all 0.6s ease-in-out;
        }

        .sign-in {
            left: 0;
            width: 50%;
            z-index: 2;
        }

        .container.active .sign-in {
            transform: translateX(100%);
        }

        .sign-up {
            left: 0;
            width: 50%;
            opacity: 0;
            z-index: 1;
        }

        .container.active .sign-up {
            transform: translateX(100%);
            opacity: 1;
            z-index: 5;
            animation: move 0.6s;
        }

        @keyframes move {

            0%,
            49.99% {
                opacity: 0;
                z-index: 1;
            }

            50%,
            100% {
                opacity: 1;
                z-index: 10;
            }
        }

        form {
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 40px;
            height: 100%;
        }

        button {
            font-size: 12px;
            padding: 10px 45px;
            border-radius: 8px;
            font-weight: 600;
            margin-bottom: 0;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-top: 10px;
            border: 5px solid transparent;
            /* border-image: linear-gradient(0deg, #310332, #02218f, #394ff5) 1; */
            border-color: #02218f;
            background: transparent;
            /* background-origin: border-box; */
            /* background-clip: padding-box, border-box; */
            cursor: pointer;
            position: absolute;
            bottom: 6%;
        }

        button:hover {
            transform: scale(1.06);
            /* animation: borda_giro 1.5s ease-in-out infinite; */

        }

        button.hidden {
            background-color: transparent;
            border-color: #fff;
            color: var(--white);

        }

        @keyframes borda_giro {
            0% {
                border-image: linear-gradient(0deg, #310332, #02218f, #394ff5)1;
            }

            10% {
                border-image: linear-gradient(36deg, #310332, #02218f, #394ff5) 1;
            }

            20% {
                border-image: linear-gradient(72deg, #310332, #02218f, #394ff5)1;
            }

            30% {
                border-image: linear-gradient(108deg, #310332, #02218f, #394ff5)1;
            }

            40% {
                border-image: linear-gradient(144deg, #310332, #02218f, #394ff5)1;
            }

            50% {
                border-image: linear-gradient(180deg, #310332, #02218f, #394ff5)1;
            }

            60% {
                border-image: linear-gradient(216deg, #310332, #02218f, #394ff5)1;
            }

            70% {
                border-image: linear-gradient(252deg, #310332, #02218f, #394ff5)1;
            }

            80% {
                border-image: linear-gradient(288deg, #310332, #02218f, #394ff5)1;
            }

            90% {
                border-image: linear-gradient(324deg, #310332, #02218f, #394ff5)1;
            }


        }

        .cadastro {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            width: 100%;
            padding: 20px 0;
        }

        .cadastro h1 {
            grid-column: 1 / span 2;
            text-align: center;
            margin-bottom: 10px;
        }

        #nome-completo {
            grid-column: 1 / span 2;
        }
        #erro{
            grid-column: 1 / span 2;

        }


        .login-layout {
            display: flex;
            flex-direction: column;
            width: 100%;
            gap: 1rem;
        }

        .login-layout h1 {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
        }

        form button {
            position: relative;
            margin-top: 2rem;
            bottom: auto;
            width: fit-content;
            align-self: center;
        }

        .toggle-container {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            overflow: hidden;
            transition: all 0.6s ease-in-out;
            z-index: 1000;
        }

        .container.active .toggle-container {
            transform: translateX(-100%);
        }

        .toggle {
            background-color: #2a3fbc;
            height: 100%;
            background: linear-gradient(to right, #3c53d2, #2a3fbc);
            color: #fff;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            transform: translateX(0);
            transition: all 0.6s ease-in-out;
        }

        .container.active .toggle {
            transform: translateX(50%);
        }

        .toggle-panel {
            position: absolute;
            width: 50%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 30px;
            text-align: center;
            top: 0;
            transition: all 0.6s ease-in-out;
        }

        .toggle-left {
            transform: translateX(-200%);
        }

        .container.active .toggle-left {
            transform: translateX(0);
        }

        .toggle-right {
            right: 0;
            transform: translateX(0);
        }

        .container.active .toggle-right {
            transform: translateX(200%);
        }

        .inputs {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border: none;
            border-radius: 8px;
            /* background: rgba(225, 227, 248, 0.9); */
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
            box-shadow:  -3px 4px 10px   rgb(107, 106, 106) ;
        }

        .inputs::placeholder {
            color: #02218f;
            font-size: 0.99rem;
        }

        .inputs:focus {
            background-color: rgba(196, 200, 242, 0.9);
        }

        .title {
            font-size: 14px;
            font-weight: bold;
        }
    </style>

</head>

<body>
<a href="<%= request.getContextPath() %>/index.html" class="return">Voltar</a>
<div class="container" id="container">
    <div class="form-container sign-up">

        <form>
            <div class="cadastro">
                <h1>Criar Conta</h1>
                <div id="erro" style="background:#ffdddd;color:#b00020;padding:8px;border-radius:6px;font-size:13px;margin-bottom:15px;display:none;">
                    Usuário ou senha incorretos
                </div>
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
                <div class="container_input" id="nome-completo">
                    <label class="title">Nome Completo</label>
                    <input type="text" name="nome" class="inputs" placeholder="Digite seu nome completo"
                           value="<%= request.getParameter("nome") != null ? request.getParameter("nome") : "" %>">
                </div>

                <div class="container_input">
                    <label class="title">Email</label>
                    <input type="email" name="email" placeholder="Email" class="inputs"
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                </div>

                <div class="container_input">
                    <label class="title">Username</label>
                    <input type="text" name="username" placeholder="Usuário" class="inputs"
                           value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                </div>

                <div class="container_input">
                    <label class="title">Senha</label>
                    <input type="password" name="senha" placeholder="Senha" class="inputs">
                </div>

                <div class="container_input">
                    <label class="title">Confirmar Senha</label>
                    <input type="password" name="confirmarSenha" class="inputs" placeholder="Confirme">
                </div>
            </div>
            <button type="submit">Cadastrar</button>
        </form>
    </div>


    <!-- LOGIN USUÁRIO -->
    <div class="form-container sign-in">

        <form action="<%= request.getContextPath() %>/login" method="post">

            <div class="login-layout">
                <h1>Entrar</h1>
                <div id="erro" style="background:#ffdddd;color:#b00020;padding:8px;border-radius:6px;font-size:13px;margin-bottom:15px;display:none;">
                    Usuário ou senha incorretos
                </div>
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

                <div class="container_input">
                    <label class="title">Usuário</label>
                    <input type="text" name="username" class="inputs" placeholder="Digite seu usuário">
                </div>

                <div class="container_senha">
                    <label class="title">Senha</label>
                    <input type="password" name="senha" class="inputs" placeholder="Digite sua senha">
                </div>
            </div>
            <button type="submit">Entrar</button>
        </form>
    </div>

    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-left">
                <img src="${pageContext.request.contextPath}/imgs/logo_escolApp.png" alt="logo" style="width: 9rem;">
                <h1>Já possui uma conta?</h1>
                <p>Entre com suas informações para ter acesso aos seus dados</p>
                <button class="hidden" id="login">Entrar</button>
            </div>
            <div class="toggle-panel toggle-right">
                <img src="${pageContext.request.contextPath}/imgs/logo_escolApp.png" alt="logo" style="width: 9rem;">
                <h1>Olá!! não possui conta?</h1>
                <p>Cadastre-se como aluno</p>
                <button class="hidden" id="register">Cadastrar</button>
            </div>
        </div>
    </div>
</div>

<%--CONTAINER SCROOL--%>
<script>
    const container = document.getElementById('container');
    const registerBtn = document.getElementById('register');
    const loginBtn = document.getElementById('login');

    registerBtn.addEventListener('click', () => {
        container.classList.add("active");
    });

    loginBtn.addEventListener('click', () => {
        container.classList.remove("active");
    });
</script>

<%--CADASTRO    --%>
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

<%--LOGIN--%>
<script>
    function mostrarSenha() {
        let campo = document.getElementById("senha");
        if (campo.type === "password") {
            campo.type = "text";
        } else {
            campo.type = "password";
        }
    }

    window.addEventListener('pageshow', function (event) {
        if (event.persisted) {
            window.location.reload();
        }
    });

    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
    };

    <% if (request.getAttribute("erro") != null) { %>
    document.getElementById("erro").style.display = "block";
    document.getElementById("erro").innerHTML = "<%= request.getAttribute("erro") %>";
    <% } %>

    // VERIFICA SE USUÁRIO JÁ ESTÁ LOGADO E REDIRECIONA
    <%
                            HttpSession sessao = request.getSession(false);
                     if (sessao != null && sessao.getAttribute("alunoLogado") != null) {
    %>
    window.location.href = '<%= request.getContextPath() %>/aluno/dashboard';
    <%
        } else if (sessao != null && sessao.getAttribute("professorLogado") != null) {
    %>
    window.location.href = '<%= request.getContextPath() %>/professor?acao=dashboard';
    <%
        } else if (sessao != null && sessao.getAttribute("admLogado") != null) {
    %>
    window.location.href = '<%= request.getContextPath() %>/adm?acao=dashboard';
    <% } %>
</script>



</body>

</html>