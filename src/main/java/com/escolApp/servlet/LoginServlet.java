package com.escolApp.servlet;

import com.escolApp.dao.AdmDAO;
import com.escolApp.model.Adm;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet  extends HttpServlet {
    AdmDAO dao = new AdmDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        String username = request.getParameter("username");
        String senha = request.getParameter("senha");

        Adm adm = dao.autenticar(username, senha);


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
    }
}
