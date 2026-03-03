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

import java.io.IOException;
import java.util.List;

@WebServlet("/adm")
public class AdmServlet extends HttpServlet {
    AdmDAO dao = new AdmDAO();
    ProfessorDAO profDao = new ProfessorDAO();
    AlunoDAO alunoDao = new AlunoDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {

        String acao = request.getParameter("acao");
        if(acao.equals("dashboard")){
            dashboard(request,response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        String acao = request.getParameter("acao");
        switch (acao) {
            case "inserirUsuario":
                String tipo = request.getParameter("tipo");
                if ("adm".equals(tipo)){
                    inserirAdm(request, response);
                }
                else if ("professor".equals(tipo)) {
                    inserirProfessor(request,response);
                }
                else if("aluno".equals(tipo)){
                    inserirAluno(request,response);
                }
                break;
            case "editarAdm":
                editarAdm(request, response);
                break;

            case "editarProfessor":
                editarProfessor(request, response);
                break;

            case "removerAdm":
                removerAdm(request, response);
                break;
            case "editarAluno":
                editarAluno(request,response);
                break;
            case "removerProfessor":
                removerProfessor(request, response);
                break;
            case "removerAluno":
                removerAluno(request,response);
        }
    }

    // REGISTRAR USUÁRIO NO BANCO ADM, PROFESSOR, ALUNO

    private void inserirAdm(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        Adm adm = new Adm(username, email, senha);
        boolean inserido = dao.inserirAdm(adm);

        if (inserido) {
            request.getSession().setAttribute("msg", "Administrador inserido com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        } else {
            request.getSession().setAttribute("msg", "Erro ao inserir administrador!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }

    private void inserirProfessor(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String nome = request.getParameter("nomeProfessor");
        String username = request.getParameter("usernameProfessor");
        String email = request.getParameter("emailProfessor");
        String senha = request.getParameter("senhaProfessor");
        int idDisciplina = Integer.parseInt(request.getParameter("idDisciplina"));

        Professor prof = new Professor(nome, username, email, senha, idDisciplina);
        boolean inserido = profDao.inserirProfessor(prof);

        if (inserido) {
            request.getSession().setAttribute("msg", "Professor inserido com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        } else {
            request.getSession().setAttribute("msg", "Erro ao inserir professor!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }
    private void inserirAluno(HttpServletRequest request, HttpServletResponse response)
            throws IOException{
        String matricula = request.getParameter("matricula");
        String nome = request.getParameter("nome");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        Aluno aluno = new Aluno(matricula,nome,username,email,senha);

        int inserido = alunoDao.inserir(aluno);
        if (inserido > 0){
            request.getSession().setAttribute("msg", "Aluno inserido com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        } else{
            request.getSession().setAttribute("msg", "Erro ao inserir aluno!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }

    // REMOVER ADM, PROFESSOR, ALUNO


    private void removerAdm(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean removido = dao.removerAdm(id);

        if (removido){ // FEEDBACK DA AÇÃO
            request.getSession().setAttribute("msg", "Administrador removido com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        }
        else {
            request.getSession().setAttribute("msg", "Erro ao remover administrador!");
            request.getSession().setAttribute("tipoMsg", "erro"); // usando session pq o sendRedirect cria novo
            // request
        }
        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }
    private void removerProfessor(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("idProf"));
        boolean removido = profDao.removerProfessor(id);
        if (removido){ // FEEDBACK DA AÇÃO
            request.getSession().setAttribute("msg", "Professor removido com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        }
        else {
            request.getSession().setAttribute("msg", "Erro ao remover professor!");
            request.getSession().setAttribute("tipoMsg", "erro"); // usando session pq o sendRedirect cria novo
            // request
        }
        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }
    private void removerAluno(HttpServletRequest request, HttpServletResponse response)
            throws IOException{
        int id  = Integer.parseInt(request.getParameter("idAluno"));
        String matricula = request.getParameter("matricula");
        String nome = request.getParameter("nome");
        String username = request.getParameter("username");
        String email  = request.getParameter("email");
        String senha = request.getParameter("senha");
        Aluno aluno = new Aluno(id,matricula,nome,username,email,senha);
        boolean removido = alunoDao.remover(aluno);
        if (removido){ // FEEDBACK DA AÇÃO
            request.getSession().setAttribute("msg", "Professor removido com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        }
        else {
            request.getSession().setAttribute("msg", "Erro ao remover professor!");
            request.getSession().setAttribute("tipoMsg", "erro"); // usando session pq o sendRedirect cria novo
            // request
        }
        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }

    // EDITAR ADM, PROFESSOR, ALUNO

    private void editarAdm(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("idAdm"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        boolean atualizado = false;

        if (username != null) atualizado |= dao.atualizarUsername(id, username);
        if (email != null) atualizado |= dao.atualizarEmail(id, email);
        if (senha != null && !senha.isEmpty()) atualizado |= dao.atualizarSenha(id, senha);

        if (atualizado){ // FEEDBACK DA AÇÃO
            request.getSession().setAttribute("msg", "Administrador atualizado com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        }
        else {
            request.getSession().setAttribute("msg", "Erro ao atualizar administrador!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }
    private void editarProfessor(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("idProf"));
        String senha = request.getParameter("senha");

        boolean atualizado = profDao.alterarSenha(id, senha);

        if (atualizado){
            request.getSession().setAttribute("msg", "Senha atualizada com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        }
        else{
            request.getSession().setAttribute("msg", "Erro ao atualizar senha!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }

    private void editarAluno(HttpServletRequest request, HttpServletResponse response) throws IOException{
        int idAluno = Integer.parseInt(request.getParameter("idAluno"));
        String matricula = request.getParameter("matricula");
        String nome = request.getParameter("nome");
        String username = request.getParameter("username");
        String email  = request.getParameter("email");
        String senha = request.getParameter("senha");
        Aluno aluno = new Aluno(idAluno,matricula,nome,username,email,senha);

        int atualizado = 0;
        if (username != null){
            atualizado = alunoDao.atualizarUsername(aluno, username);
        }
        if (email != null){
            atualizado = alunoDao.atualizarEmail(aluno,email);
        }
        if (senha != null && !senha.isEmpty()){
            atualizado = alunoDao.atualizarSenha(aluno,senha);
        }

        if (atualizado > 0){
            request.getSession().setAttribute("msg", "Aluno atualizada com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        }
        else{
            request.getSession().setAttribute("msg", "Erro ao atualizar aluno!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }



    // DASHBOARD INICIAL
    private void dashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException{
        List<Adm> lista = dao.buscarAdm();
        List<Professor> listaProf = profDao.buscarProfessores();
        List<Aluno> listaAluno = alunoDao.buscar();
        int totalAluno = listaAluno.size();
        int totalProf = listaProf.size();
        int totalAdm = lista.size();
        int totalUsers = totalAdm + totalProf + totalAluno;
        request.setAttribute("listaAdm",lista);
        request.setAttribute("totalAdm", totalAdm);
        request.setAttribute("totalUsers",totalUsers);
        request.setAttribute("listaProf",listaProf);
        request.setAttribute("totalProf",totalProf);
        request.setAttribute("listaAluno",listaAluno);
        request.setAttribute("totalAluno",totalAluno);

        request.getRequestDispatcher("/WEB-INF/view/dashboardAdm.jsp")
                .forward(request, response);
    }
}
