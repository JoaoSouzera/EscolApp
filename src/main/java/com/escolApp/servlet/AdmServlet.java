package com.escolApp.servlet;

import com.escolApp.dao.AdmDAO;
import com.escolApp.dao.ProfessorDAO;
import com.escolApp.model.Adm;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {

        String acao = request.getParameter("acao");
//        if ("listar".equals(acao)){
//            listar(request,response);
//        }
//        else if("novo".equals(acao)){
//            request.getRequestDispatcher("WEB-INF/view/form-adm.jsp").forward(request,response);
//        }
        if ("remover".equals(acao)) {
            remover(request,response);
        } else if ("editar".equals(acao)) {
            editar(request,response);
        } else if ("dashboard".equals(acao)) {
            dashboard(request,response);
        }else {
            dashboard(request,response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        String acao = request.getParameter("acao");
        if("inserirUsuario".equals(acao)){
            salvarUsuario(request,response);
        } else if ("remover".equals(acao)) {
            remover(request,response);
        } else if("editar".equals(acao)){
            editar(request,response);
        }
    }

    // REGISTRAR USUÁRIO NO BANCO
    private void salvarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipo");

        if ("adm".equals(tipo)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            Adm adm = new Adm(username,email, senha);

            dao.inserirAdm(adm);
        }
        else if ("professor".equals(tipo)) {
            String nome = request.getParameter("nomeProfessor");
            String username = request.getParameter("usernameProfessor");
            String email = request.getParameter("emailProfessor");
            String senha  =request.getParameter("senhaProfessor");
            int idDisciplina = Integer.parseInt(request.getParameter("idDisciplina"));

            Professor prof = new Professor(nome,username,email,senha,idDisciplina);
            profDao.inserirProfessor(prof);
        }
//        else if ("aluno".equals(tipo)) {
//            salvarAluno(request);
//        }

        // volta para o dashboard
        response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
    }






    // LER ADM'S
//    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException,
//            IOException {
//        List<Adm> lista = dao.buscarAdm();
//        request.setAttribute("listaAdm",lista);
//        response.sendRedirect(request.getContextPath()+"/adm?acao=dashboard");
//    }





    // REMOVER ADM

    private void remover(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()){
            int id = Integer.parseInt(idParam);
            boolean removido = dao.removerAdm(id);
            request.setAttribute("removido", removido);
        }
        // dash recalcula tudo de novo
        response.sendRedirect(request.getContextPath()+"/adm?acao=dashboard");
    }








    // EDITAR ADM

    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException{

        // Mostra o formulario com os valores antigos (GET) e atualiza (POST) no mesmo método.
        if (request.getMethod().equalsIgnoreCase("GET")) {
            // Mostra o formulário com os valores antigos
            int id = Integer.parseInt(request.getParameter("id"));
            Adm adm = dao.buscarPorId(id);
            request.setAttribute("adm", adm);
            request.getRequestDispatcher("/WEB-INF/view/editar-adm.jsp")
                    .forward(request, response);
        } else if (request.getMethod().equalsIgnoreCase("POST")) {
            // Recebe os dados do formulário e atualiza
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            dao.atualizarUsername(id, username);
            dao.atualizarEmail(id, email);
            if (senha != null && !senha.isEmpty()) {
                dao.atualizarSenha(id, senha);
            }
            // Redireciona de volta para a lista ou menu
            response.sendRedirect(request.getContextPath() + "/adm?acao=dashboard");
        }
    }


    // DASHBOARD INICIAL
    private void dashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException{
        List<Adm> lista = dao.buscarAdm();
        List<Professor> listaProf = profDao.buscarProfessores();
        int totalProf = listaProf.size();
        int totalAdm = lista.size();
        request.setAttribute("listaAdm",lista);
        request.setAttribute("totalAdm", totalAdm);

        request.setAttribute("listaProf",listaProf);
        request.setAttribute("totalProf",totalProf);

        request.getRequestDispatcher("/WEB-INF/view/dashboardAdm.jsp")
                .forward(request, response);
    }
}
