package com.escolApp.servlet;

import com.escolApp.dao.AdmDAO;
import com.escolApp.dao.AlunoDAO;
import com.escolApp.dao.ProfessorDAO;
import com.escolApp.model.Adm;
import com.escolApp.model.Aluno;
import com.escolApp.model.Professor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet  extends HttpServlet {
    AdmDAO dao = new AdmDAO();
    ProfessorDAO profDao = new ProfessorDAO();
    AlunoDAO alunoDao = new AlunoDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        String username = request.getParameter("username");
        String senha = request.getParameter("senha");

        // 1. Tenta autenticar como ADMIN
        Adm adm = dao.autenticar(username, senha);
        if (adm != null) {
            request.getSession().setAttribute("admLogado", adm);
            response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
            return; // IMPORTANTE: para a execução
        }

        // 2. Tenta autenticar como PROFESSOR
        Professor prof = profDao.autenticar(username, senha);
        if (prof != null) {
            request.getSession().setAttribute("professorLogado", prof);
            response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard");
            return; // IMPORTANTE: para a execução
        }

        // 3. Tenta autenticar como ALUNO (agora usando o novo método autenticar)
        Aluno aluno = alunoDao.autenticar(username, senha);
        if (aluno != null) {
            HttpSession session = request.getSession();
            session.setAttribute("alunoLogado", aluno);
            session.setAttribute("tipoUsuario", "ALUNO");
            session.setAttribute("msg", "Login realizado com sucesso!");
            session.setAttribute("tipoMsg", "sucesso");
            response.sendRedirect(request.getContextPath() + "/aluno/dashboard");
            return;
        }


        request.setAttribute("erro", "Usuário ou senha inválidos");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

