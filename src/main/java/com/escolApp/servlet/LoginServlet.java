package com.escolApp.servlet;

import com.escolApp.dao.AdmDAO;
import com.escolApp.dao.AlunoDAO;
import com.escolApp.dao.ProfessorDAO;
import com.escolApp.model.Adm;
import com.escolApp.model.Professor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

        Adm adm = dao.autenticar(username, senha);
        Professor prof = profDao.autenticar(username,senha);
        if (adm != null){
            // salva sessão
            request.getSession().setAttribute("admLogado",adm);
            // manda para o menu de adm
            response.sendRedirect(request.getContextPath()+"/adm?acao=dashboard");
        }else {
            // retorna o erro de login
            request.setAttribute("erro", "Usuário ou senha inválidos");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
        if (prof != null){
            // salva sessão
            request.getSession().setAttribute("profLogado",prof);
            // manda para o menu de professor
            response.sendRedirect(request.getContextPath()+"/professor?acao=dashboard");
        }
    }
}
