<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Login - EscolApp</title>
    <link rel="icon" href="fotos/logo_escolApp.png">

    <style>
        :root {
            --preto: rgb(12, 9, 44);
            --azul-claro: #0099ff;
            --vermelho: #ff0000;
            --verde: #00ff00;
            --azul: #0099ff;
            --white: rgb(242, 242, 242);
            --erro-bg: #ffdddd;
            --erro-text: #b00020;
            --erro-border: #ff0000;
            --sucesso-bg: #ddffdd;
            --sucesso-text: #006600;
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
            z-index: 10;
        }

        .return:hover {
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
            min-height: 520px;
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
            justify-content: space-between; /* Muda de center para space-between */
            flex-direction: column;
            padding: 30px 30px 20px 30px; /* Aumenta o padding superior e inferior */
            height: 100%;
            position: relative;
        }

        /* ESTILO DOS BOTÕES DE SUBMIT (Cadastrar/Entrar) */
        form button {
            font-size: 12px;
            padding: 10px 45px;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border: 2px solid #02218f;
            background: transparent;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 5px;
            margin-bottom: 30px;
            width: fit-content;
            align-self: center;
            position: relative;
            bottom: auto;
            color: #02218f;
        }

        form button:hover {
            transform: scale(1.05);
            background-color: #02218f;
            color: white;
        }

        /* ESTILO DOS BOTÕES DO TOGGLE PANEL (parte azul) */
        .toggle-panel button {
            font-size: 14px;
            padding: 12px 45px;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border: 2px solid white;
            background: transparent;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
            margin-top: 15px;
            width: fit-content;
        }

        .toggle-panel button:hover {
            transform: scale(1.05);
            background-color: white;
            color: #2a3fbc;
        }

        button.hidden {
            background-color: transparent;
            border-color: #fff;
            color: white;
        }

        /* ESTILO DOS CARDS DE CADASTRO */
        .cadastro {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            width: 100%;
            margin: 0;
            position: relative;
            flex: 1; /* Adiciona flex:1 para ocupar o espaço disponível */
            align-content: center; /* Centraliza verticalmente o grid */
        }

        .cadastro h1 {
            grid-column: 1 / span 2;
            text-align: center;
            margin: 0 0 10px 0;
            font-size: 1.5rem;
        }

        #nome-completo {
            grid-column: 1 / span 2;
        }

        /* CONTAINER DE MENSAGENS DE ERRO */
        .mensagem-container {
            grid-column: 1 / span 2;
            min-height: auto; /* Muda de 40px para auto */
            margin: 0 0 10px 0;
            width: 100%;
        }

        .mensagem-erro {
            background: var(--erro-bg);
            color: var(--erro-text);
            border: 1px solid var(--erro-border);
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            text-align: center;
            width: 100%;
        }

        .mensagem-sucesso {
            background: var(--sucesso-bg);
            color: var(--sucesso-text);
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            text-align: center;
            width: 100%;
        }

        /* ESTILO PARA INPUT COM ERRO */
        .input-erro {
            border: 2px solid var(--erro-border) !important;
            box-shadow: 0 2px 8px rgba(255, 0, 0, 0.2) !important;
        }

        /* LAYOUT DO LOGIN */
        .login-layout {
            display: flex;
            flex-direction: column;
            width: 100%;
            gap: 15px;
            justify-content: center;
            margin: 0;
            padding: 0;
            flex: 1; /* Adiciona flex:1 para ocupar o espaço disponível */
        }

        .login-layout h1 {
            text-align: center;
            font-size: 1.5rem;
            margin: 0 0 5px 0;
        }



        /* CONTAINER DE INPUTS */
        .container_input,
        .container_senha {
            width: 100%;
            margin-bottom: 5px;
        }

        .containerInputs {
            display: flex;
            flex-direction: column;
            gap: 20px; /* Aumenta o espaçamento entre os inputs */
            width: 100%;
        }

        /* ESTILO DOS INPUTS - TAMANHO ORIGINAL */
        .inputs {
            width: 100%;
            padding: 15px 18px;
            margin-top: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .inputs:hover {
            border-color: #02218f;
            box-shadow: 0 4px 10px rgba(2, 33, 143, 0.1);
        }

        .inputs:focus {
            border-color: #02218f;
            box-shadow: 0 4px 15px rgba(2, 33, 143, 0.2);
            background-color: rgba(196, 200, 242, 0.1);
        }

        .inputs::placeholder {
            color: #999;
            font-size: 0.9rem;
        }

        .title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            display: block;
            margin-bottom: 2px;
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

        .toggle-panel h1 {
            font-size: 1.2rem;
            margin: 10px 0;
            color: white;
        }

        .toggle-panel p {
            font-size: 0.9rem;
            margin-bottom: 15px;
            color: rgba(255, 255, 255, 0.9);
        }

        .toggle-panel img {
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
<a href="<%= request.getContextPath() %>/index.html" class="return">Voltar</a>

<div class="container" id="container">
    <!-- FORMULÁRIO DE CADASTRO -->
    <div class="form-container sign-up">
        <form action="<%= request.getContextPath() %>/cadastro" method="post" id="formCadastro">
            <div class="cadastro">
                <h1>Criar Conta</h1>

                <!-- CONTAINER DE MENSAGENS DO CADASTRO -->
                <div class="mensagem-container" id="mensagemCadastroContainer">
                    <%
                        String erroCadastroAttr = (String) request.getAttribute("erroCadastro");
                        String sucessoAttr = (String) request.getAttribute("sucesso");
                        if (erroCadastroAttr != null && !erroCadastroAttr.isEmpty()) {
                    %>
                    <div class="mensagem-erro" id="mensagemCadastro">
                        <%= erroCadastroAttr %>
                    </div>
                    <%
                        }
                        if (sucessoAttr != null && !sucessoAttr.isEmpty()) {
                    %>
                    <div class="mensagem-sucesso" id="mensagemCadastro">
                        <%= sucessoAttr %>
                    </div>
                    <%
                        }
                    %>
                </div>

                <div class="container_input" id="nome-completo">
                    <label class="title">Nome Completo</label>
                    <input type="text" name="nome" class="inputs" id="nome"
                           placeholder="Digite seu nome completo"
                           value="<%= request.getParameter("nome") != null ? request.getParameter("nome") : "" %>">
                </div>

                <div class="container_input">
                    <label class="title">Email</label>
                    <input type="email" name="email" id="email" placeholder="Email" class="inputs"
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                </div>

                <div class="container_input">
                    <label class="title">Username</label>
                    <input type="text" name="username" id="username" placeholder="Usuário" class="inputs"
                           value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                </div>

                <div class="container_input">
                    <label class="title">Senha</label>
                    <input type="password" name="senha" id="senha" placeholder="Senha" class="inputs">
                </div>

                <div class="container_input">
                    <label class="title">Confirmar Senha</label>
                    <input type="password" name="confirmarSenha" id="confirmarSenha" class="inputs"
                           placeholder="Confirme">
                </div>
            </div>
            <button type="submit">Cadastrar</button>
        </form>
    </div>

    <!-- FORMULÁRIO DE LOGIN -->
    <div class="form-container sign-in">
        <form action="<%= request.getContextPath() %>/login" method="post" id="formLogin">
            <div class="login-layout">
                <h1 class="EntrarH1">Entrar</h1>

                <!-- CONTAINER DE MENSAGENS DO LOGIN -->
                <div class="mensagem-container" id="mensagemLoginContainer">
                    <%
                        String erroLoginAttr = (String) request.getAttribute("erroLogin");
                        if (erroLoginAttr != null && !erroLoginAttr.isEmpty()) {
                    %>
                    <div class="mensagem-erro" id="mensagemLogin">
                        <%= erroLoginAttr %>
                    </div>
                    <%
                        }
                    %>
                </div>

                <div class="containerInputs">
                    <div class="container_input">
                        <label class="title">Usuário</label>
                        <input type="text" name="username" id="loginUsername" class="inputs"
                               placeholder="Digite seu usuário"
                               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                    </div>

                    <div class="container_senha">
                        <label class="title">Senha</label>
                        <input type="password" name="senha" id="loginSenha" class="inputs"
                               placeholder="Digite sua senha">
                    </div>
                </div>
            </div>
            <button type="submit">Entrar</button>
        </form>
    </div>

    <!-- TOGGLE PANEL -->
    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-left">
                <img src="${pageContext.request.contextPath}/fotos/logo_escolApp.png" alt="logo"
                     style="width: 9rem;">
                <h1>Já possui uma conta?</h1>
                <p>Entre com suas informações para ter acesso aos seus dados</p>
                <button class="hidden" id="login">Entrar</button>
            </div>
            <div class="toggle-panel toggle-right">
                <img src="${pageContext.request.contextPath}/fotos/logo_escolApp.png" alt="logo"
                     style="width: 9rem;">
                <h1>Olá!! não possui conta?</h1>
                <p>Cadastre-se como aluno</p>
                <button class="hidden" id="register">Cadastrar</button>
            </div>
        </div>
    </div>
</div>

<script>
    // TOGGLE ENTRE LOGIN E CADASTRO
    const container = document.getElementById('container');
    const registerBtn = document.getElementById('register');
    const loginBtn = document.getElementById('login');

    if (registerBtn) {
        registerBtn.addEventListener('click', () => {
            container.classList.add("active");
        });
    }

    if (loginBtn) {
        loginBtn.addEventListener('click', () => {
            container.classList.remove("active");
        });
    }

    // FUNÇÃO PARA LIMPAR ERROS DOS INPUTS
    function limparErrosInputs() {
        document.querySelectorAll('.inputs').forEach(input => {
            input.classList.remove('input-erro');
        });
    }

    // FUNÇÃO PARA MOSTRAR ERRO NO LOGIN
    function mostrarErroLogin(mensagem) {
        const containerMensagem = document.getElementById('mensagemLoginContainer');
        if (containerMensagem) {
            containerMensagem.innerHTML = '<div class="mensagem-erro" id="mensagemLogin">' + mensagem + '</div>';

            // Adiciona borda vermelha nos inputs de login
            const loginUsername = document.getElementById('loginUsername');
            const loginSenha = document.getElementById('loginSenha');

            if (loginUsername) loginUsername.classList.add('input-erro');
            if (loginSenha) loginSenha.classList.add('input-erro');
        }
    }

    // FUNÇÃO PARA MOSTRAR ERRO NO CADASTRO
    function mostrarErroCadastro(mensagem) {
        const containerMensagem = document.getElementById('mensagemCadastroContainer');
        if (containerMensagem) {
            containerMensagem.innerHTML = '<div class="mensagem-erro" id="mensagemCadastro">' + mensagem + '</div>';

            // Adiciona borda vermelha em todos os inputs do cadastro
            document.querySelectorAll('.sign-up .inputs').forEach(input => {
                input.classList.add('input-erro');
            });
        }
    }

    // FUNÇÃO PARA MOSTRAR SUCESSO NO CADASTRO
    function mostrarSucessoCadastro(mensagem) {
        const containerMensagem = document.getElementById('mensagemCadastroContainer');
        if (containerMensagem) {
            containerMensagem.innerHTML = '<div class="mensagem-sucesso" id="mensagemCadastro">' + mensagem + '</div>';
        }
    }

    // VALIDAÇÃO DE LOGIN
    const formLogin = document.getElementById('formLogin');
    if (formLogin) {
        formLogin.addEventListener('submit', function (e) {
            limparErrosInputs();

            let username = document.getElementById('loginUsername');
            let senha = document.getElementById('loginSenha');

            if (username && senha) {
                // Validação do lado do cliente
                if (!username.value || !senha.value) {
                    e.preventDefault();
                    mostrarErroLogin('Usuário e senha são obrigatórios');
                }
            }
        });
    }

    // VALIDAÇÃO DE CADASTRO
    const formCadastro = document.getElementById('formCadastro');
    if (formCadastro) {
        formCadastro.addEventListener('submit', function (e) {
            limparErrosInputs();

            let nome = document.getElementById('nome');
            let email = document.getElementById('email');
            let username = document.getElementById('username');
            let senha = document.getElementById('senha');
            let confirmarSenha = document.getElementById('confirmarSenha');

            if (nome && email && username && senha && confirmarSenha) {
                // Validações do lado do cliente
                if (!nome.value || !email.value || !username.value || !senha.value || !confirmarSenha.value) {
                    e.preventDefault();
                    mostrarErroCadastro('Informações Inválidas - Preencha todos os campos');
                    return;
                }

                if (senha.value !== confirmarSenha.value) {
                    e.preventDefault();
                    mostrarErroCadastro('As senhas não conferem');
                    return;
                }

                if (senha.value.length < 6) {
                    e.preventDefault();
                    mostrarErroCadastro('A senha deve ter pelo menos 6 caracteres');
                    return;
                }

                // Validação de email simples
                if (!email.value.includes('@') || !email.value.includes('.')) {
                    e.preventDefault();
                    mostrarErroCadastro('Email inválido');
                    return;
                }
            }
        });
    }

    // VERIFICAR SE TEM ERRO DO BACKEND NA PÁGINA
    window.addEventListener('load', function () {
        <%
            String erroLoginBackend = (String) request.getAttribute("erroLogin");
            String erroCadastroBackend = (String) request.getAttribute("erroCadastro");
            String sucessoBackend = (String) request.getAttribute("sucesso");
        %>

        <% if (erroLoginBackend != null && !erroLoginBackend.isEmpty()) { %>
        mostrarErroLogin('<%= erroLoginBackend %>');
        <% } %>

        <% if (erroCadastroBackend != null && !erroCadastroBackend.isEmpty()) { %>
        mostrarErroCadastro('<%= erroCadastroBackend %>');
        <% } %>

        <% if (sucessoBackend != null && !sucessoBackend.isEmpty()) { %>
        mostrarSucessoCadastro('<%= sucessoBackend %>');
        <% } %>
    });

    // PREVENIR VOLTA NO HISTÓRICO
    window.addEventListener('pageshow', function (event) {
        if (event.persisted) {
            window.location.reload();
        }
    });

    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
    };

    // VERIFICA SE USUÁRIO JÁ ESTÁ LOGADO
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
    <%
        }
    %>
</script>
</body>

</html>