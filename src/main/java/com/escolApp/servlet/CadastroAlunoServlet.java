package com.escolApp.servlet;

import com.escolApp.dao.AlunoDAO;
import com.escolApp.model.Aluno;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/cadastroAluno")
public class CadastroAlunoServlet extends HttpServlet {

    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        alunoDAO = new AlunoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DEBUG CADASTRO SERVLET ===");
        System.out.println("Método doGet foi chamado!");
        System.out.println("Tentando acessar: /WEB-INF/view/Aluno/cadastroAluno.jsp");

        request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");

        // Validações...
        if (nome == null || nome.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                senha == null || senha.trim().isEmpty()) {

            request.setAttribute("erro", "Todos os campos são obrigatórios");
            request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
            return;
        }

        if (!senha.equals(confirmarSenha)) {
            request.setAttribute("erro", "As senhas não conferem");
            request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
            return;
        }

        List<Aluno> alunosExistents = alunoDAO.buscarPorUser(username);
        if (!alunosExistents.isEmpty()) {
            request.setAttribute("erro", "Este nome de usuário já está em uso");
            request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
            return;
        }

        List<Aluno> alunosPorEmail = alunoDAO.buscarPorEmail(email);
        if (!alunosPorEmail.isEmpty()) {
            request.setAttribute("erro", "Este email já está cadastrado");
            request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
            return;
        }

        // Gerar matrícula
        String matricula = gerarMatricula();

        // OPTION 1: Usando construtor com parâmetros (se existir)
        Aluno novoAluno = new Aluno(matricula, nome, username, email, senha);

        // OPTION 2: Se não tiver esse construtor, use o construtor completo com id=0
        // Aluno novoAluno = new Aluno(0, matricula, nome, username, email, senha);

        int resultado = alunoDAO.inserir(novoAluno);

        if (resultado > 0) {
            request.setAttribute("sucesso", "Cadastro realizado com sucesso! Sua matrícula é: " + matricula);
            request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
        } else {
            request.setAttribute("erro", "Erro ao realizar cadastro. Tente novamente.");
            request.getRequestDispatcher("/WEB-INF/view/Aluno/cadastroAluno.jsp").forward(request, response);
        }
    }

    private String gerarMatricula() {
        List<Aluno> todosAlunos = alunoDAO.buscar();

        if (todosAlunos == null || todosAlunos.isEmpty()) {
            return "00001";
        }

        int maiorMatricula = 0;
        for (Aluno aluno : todosAlunos) {
            try {
                String matriculaStr = aluno.getMatricula();
                if (matriculaStr != null && !matriculaStr.isEmpty()) {
                    int matriculaNum = Integer.parseInt(matriculaStr);
                    if (matriculaNum > maiorMatricula) {
                        maiorMatricula = matriculaNum;
                    }
                }
            } catch (NumberFormatException e) {
                // Ignora
            }
        }

        int proximaMatricula = maiorMatricula + 1;
        return String.format("%05d", proximaMatricula);
    }
}