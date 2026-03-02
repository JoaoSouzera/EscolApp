package com.escolApp.servlet;

import com.escolApp.dao.AlunoDAO;
import com.escolApp.dao.NotaDAO;
import com.escolApp.dao.ObservacaoDAO;
import com.escolApp.dao.ProfessorDAO;
import com.escolApp.model.Aluno;
import com.escolApp.model.Nota;
import com.escolApp.model.Observacao;
import com.escolApp.model.Professor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/professor")
public class ProfessorServlet extends HttpServlet {
    ProfessorDAO profDao = new ProfessorDAO();
    AlunoDAO alunoDao = new AlunoDAO();
    NotaDAO notaDao = new NotaDAO();
    ObservacaoDAO obsDao = new ObservacaoDAO();


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        String acao = request.getParameter("acao");

        if (acao == null || acao.equals("dashboard")) {
            dashboard(request, response);
        } else if (acao.equals("buscarAluno")) {
            buscarAluno(request, response);
        } else if (acao.equals("listarNotas")) {
            listarNotas(request, response);
        } else if (acao.equals("listarObservacoes")) {
            listarObservacoes(request, response);
        } else {
            dashboard(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        String acao = request.getParameter("acao");

        switch (acao) {
            case "lancarNota":
                lancarNota(request, response);
                break;
            case "editarN1":
                editarN1(request, response);
                break;
            case "editarN2":
                editarN2(request, response);
                break;
            case "removerNota":
                removerNota(request, response);
                break;
            case "enviarObservacao":
                enviarObservacao(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard");
        }
    }
        // ==================== MÉTODOS PRINCIPAIS ====================

    private void dashboard (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            HttpSession session = request.getSession();
            Professor profLogado = (Professor) session.getAttribute("professorLogado");

            if (profLogado == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            // Buscar todos os alunos (para o formulário de busca)
            List<Aluno> todosAlunos = alunoDao.buscar();

            // Buscar notas da disciplina do professor
            List<Nota> todasNotas = notaDao.buscarNota();
            List<Nota> notasDaDisciplina = new java.util.ArrayList<>();

            for (Nota n : todasNotas) {
                if (n.getIdDisciplina() == profLogado.getIdDisciplina()) {
                    notasDaDisciplina.add(n);
                }
            }

            // Buscar observações do professor
            List<Observacao> observacoes = obsDao.buscarObservacao();
            List<Observacao> obsDoProfessor = new java.util.ArrayList<>();

            for (Observacao o : observacoes) {
                if (o.getId_professor() == profLogado.getId()) {
                    obsDoProfessor.add(o);
                }
            }

            request.setAttribute("listaAlunos", todosAlunos);
            request.setAttribute("listaNotas", notasDaDisciplina);
            request.setAttribute("listaObs", obsDoProfessor);
            request.setAttribute("disciplinaId", profLogado.getIdDisciplina());
            request.setAttribute("professorId", profLogado.getId());

            request.getRequestDispatcher("/WEB-INF/view/dashboardProfessor.jsp").forward(request, response);
    }
        // ==================== BUSCAR ALUNO POR MATRÍCULA ====================

    private void buscarAluno (HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{

            String matricula = request.getParameter("matricula");

            List<Aluno> alunos = alunoDao.buscarPorMatricula(matricula);

            HttpSession session = request.getSession();

            if (alunos != null && !alunos.isEmpty()) {
                session.setAttribute("alunoBuscado", alunos.get(0));
                session.setAttribute("msg", "Aluno encontrado: " + alunos.get(0).getNome());
                session.setAttribute("tipoMsg", "sucesso");
            } else {
                session.setAttribute("alunoBuscado", null);
                session.setAttribute("msg", "Aluno com matrícula " + matricula + " não encontrado!");
                session.setAttribute("tipoMsg", "erro");
            }

            response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard#busca");
    }

        // ==================== NOTAS ====================
    private void lancarNota(HttpServletRequest request, HttpServletResponse response)
                throws IOException {

            HttpSession session = request.getSession();
            Professor profLogado = (Professor) session.getAttribute("professorLogado");

            double n1 = Double.parseDouble(request.getParameter("n1"));
            double n2 = Double.parseDouble(request.getParameter("n2"));
            int idAluno = Integer.parseInt(request.getParameter("idAluno"));

            Nota nota = new Nota(0, n1, n2, idAluno, profLogado.getIdDisciplina());

            boolean inserido = notaDao.inserirNota(nota);

            if (inserido) {
                session.setAttribute("msg", "Notas lançadas com sucesso para o aluno!");
                session.setAttribute("tipoMsg", "sucesso");
            } else {
                session.setAttribute("msg", "Erro ao lançar notas!");
                session.setAttribute("tipoMsg", "erro");
            }

            response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard#notas");
    }

    private void editarN1(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int idNota = Integer.parseInt(request.getParameter("idNota"));
        double n1 = Double.parseDouble(request.getParameter("n1"));

        boolean atualizado = notaDao.atualizarN1(idNota, n1);

        if (atualizado) {
            request.getSession().setAttribute("msg", "Nota N1 atualizada com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        } else {
            request.getSession().setAttribute("msg", "Erro ao atualizar N1!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard#notas");
    }
    private void editarN2(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int idNota = Integer.parseInt(request.getParameter("idNota"));
        double n2 = Double.parseDouble(request.getParameter("n2"));

        boolean atualizado = notaDao.atualizarN2(idNota, n2);

        if (atualizado) {
            request.getSession().setAttribute("msg", "Nota N2 atualizada com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        } else {
            request.getSession().setAttribute("msg", "Erro ao atualizar N2!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard#notas");
    }
    private void removerNota(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int idNota = Integer.parseInt(request.getParameter("idNota"));

        boolean removido = notaDao.removerNota(idNota);

        if (removido) {
            request.getSession().setAttribute("msg", "Nota removida com sucesso!");
            request.getSession().setAttribute("tipoMsg", "sucesso");
        } else {
            request.getSession().setAttribute("msg", "Erro ao remover nota!");
            request.getSession().setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard#notas");
    }
    private void listarNotas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Professor profLogado = (Professor) session.getAttribute("professorLogado");

        List<Nota> todasNotas = notaDao.buscarNota();
        List<Nota> notasDaDisciplina = new java.util.ArrayList<>();

        for (Nota n : todasNotas) {
            if (n.getIdDisciplina() == profLogado.getIdDisciplina()) {
                notasDaDisciplina.add(n);
            }
        }

        request.setAttribute("listaNotas", notasDaDisciplina);

        dashboard(request, response);
    }
    // ==================== OBSERVAÇÕES ====================

    private void enviarObservacao(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        Professor profLogado = (Professor) session.getAttribute("professorLogado");

        String texto = request.getParameter("texto");
        int idAluno = Integer.parseInt(request.getParameter("idAluno"));

        Observacao obs = new Observacao();
        obs.setTexto(texto);
        obs.setData(new Timestamp(System.currentTimeMillis()));
        obs.setId_aluno(idAluno);
        obs.setId_professor(profLogado.getId());
        obs.setId_disciplina(profLogado.getIdDisciplina());

        boolean inserido = obsDao.inserirObservacao(obs);

        if (inserido) {
            session.setAttribute("msg", "Observação enviada com sucesso!");
            session.setAttribute("tipoMsg", "sucesso");
        } else {
            session.setAttribute("msg", "Erro ao enviar observação!");
            session.setAttribute("tipoMsg", "erro");
        }

        response.sendRedirect(request.getContextPath() + "/professor?acao=dashboard#observacoes");
    }
    private void listarObservacoes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Professor profLogado = (Professor) session.getAttribute("professorLogado");

        List<Observacao> todasObs = obsDao.buscarObservacao();
        List<Observacao> obsDoProfessor = new java.util.ArrayList<>();

        for (Observacao o : todasObs) {
            if (o.getId_professor() == profLogado.getId()) {
                obsDoProfessor.add(o);
            }
        }

        request.setAttribute("listaObs", obsDoProfessor);

        dashboard(request, response);
    }
}