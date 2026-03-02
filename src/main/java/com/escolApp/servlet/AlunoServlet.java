package com.escolApp.servlet;

import com.escolApp.dao.AlunoDAO;
import com.escolApp.dao.NotaDAO;
import com.escolApp.dao.ObservacaoDAO;
import com.escolApp.dao.DisciplinaDAO;
import com.escolApp.dao.ProfessorDAO;
import com.escolApp.model.Aluno;
import com.escolApp.model.Nota;
import com.escolApp.model.Observacao;
import com.escolApp.model.Disciplina;
import com.escolApp.model.Professor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/aluno/*")
public class AlunoServlet extends HttpServlet {

    private AlunoDAO alunoDAO;
    private NotaDAO notaDAO;
    private ObservacaoDAO observacaoDAO;
    private DisciplinaDAO disciplinaDAO;
    private ProfessorDAO professorDAO;

    @Override
    public void init() throws ServletException {
        alunoDAO = new AlunoDAO();
        notaDAO = new NotaDAO();
        observacaoDAO = new ObservacaoDAO();
        disciplinaDAO = new DisciplinaDAO();
        professorDAO = new ProfessorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession(false);

        System.out.println("=== DEBUG ===");
        System.out.println("Caminho do contexto: " + request.getContextPath());
        System.out.println("Servlet Path: " + request.getServletPath());
        System.out.println("Path Info: " + request.getPathInfo());
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Session: " + (session != null ? "existe" : "não existe"));
        if (session != null) {
            System.out.println("Aluno logado: " + (session.getAttribute("alunoLogado") != null ? "sim" : "não"));
        }

        if (session == null || session.getAttribute("alunoLogado") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Aluno alunoLogado = (Aluno) session.getAttribute("alunoLogado");

        if (action == null || action.equals("/") || action.equals("/dashboard")) {
            carregarDashboard(request, response, alunoLogado);
        } else if (action.equals("/boletim")) {
            carregarBoletim(request, response, alunoLogado);
        } else if (action.equals("/observacoes")) {
            carregarObservacoes(request, response, alunoLogado);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("acao");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("alunoLogado") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("login".equals(action)) {
            realizarLogin(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void carregarDashboard(HttpServletRequest request, HttpServletResponse response, Aluno aluno)
            throws ServletException, IOException {

        List<Nota> todasNotas = notaDAO.buscarNota();
        List<Observacao> todasObservacoes = observacaoDAO.buscarObservacao();
        List<Disciplina> todasDisciplinas = disciplinaDAO.buscar();

        // Criar mapas para consulta rápida
        Map<Integer, String> mapaDisciplinas = new HashMap<>();
        for (Disciplina d : todasDisciplinas) {
            mapaDisciplinas.put(d.getId(), d.getNome());
        }

        // Filtrar apenas as notas do aluno logado
        List<Nota> notasDoAluno = new ArrayList<>();
        if (todasNotas != null) {
            for (Nota n : todasNotas) {
                if (n.getIdAluno() == aluno.getId()) {
                    notasDoAluno.add(n);
                }
            }
        }

        // Filtrar observações do aluno
        List<Observacao> observacoesDoAluno = new ArrayList<>();
        if (todasObservacoes != null) {
            for (Observacao o : todasObservacoes) {
                if (o.getId_aluno() == aluno.getId()) {
                    observacoesDoAluno.add(o);
                }
            }
        }

        // Calcular estatísticas
        int totalDisciplinas = calcularTotalDisciplinas(notasDoAluno);
        double mediaGeral = calcularMediaGeral(notasDoAluno);
        int totalObservacoes = observacoesDoAluno.size();

        // Últimas 5 notas
        List<Nota> ultimasNotas = new ArrayList<>();
        if (notasDoAluno.size() > 5) {
            ultimasNotas = notasDoAluno.subList(0, 5);
        } else {
            ultimasNotas = notasDoAluno;
        }

        // Últimas 5 observações
        List<Observacao> observacoesRecentes = new ArrayList<>();
        if (observacoesDoAluno.size() > 5) {
            observacoesRecentes = observacoesDoAluno.subList(0, 5);
        } else {
            observacoesRecentes = observacoesDoAluno;
        }

        // Resumo por disciplina para o dashboard
        List<ResumoDisciplina> resumoDisciplinas = gerarResumoDisciplinas(notasDoAluno, mapaDisciplinas);

        request.setAttribute("totalDisciplinas", totalDisciplinas);
        request.setAttribute("mediaGeral", String.format("%.1f", mediaGeral));
        request.setAttribute("totalObservacoes", totalObservacoes);
        request.setAttribute("ultimasNotas", ultimasNotas);
        request.setAttribute("observacoesRecentes", observacoesRecentes);
        request.setAttribute("resumoDisciplinas", resumoDisciplinas);
        request.setAttribute("aluno", aluno);
        request.setAttribute("mapaDisciplinas", mapaDisciplinas);

        request.getRequestDispatcher("/WEB-INF/view/Aluno/dashboardAluno.jsp").forward(request, response);
    }

    private void carregarBoletim(HttpServletRequest request, HttpServletResponse response, Aluno aluno)
            throws ServletException, IOException {

        List<Nota> todasNotas = notaDAO.buscarNota();
        List<Disciplina> todasDisciplinas = disciplinaDAO.buscar();

        // Mapa para consulta rápida de disciplinas
        Map<Integer, String> mapaDisciplinas = new HashMap<>();
        for (Disciplina d : todasDisciplinas) {
            mapaDisciplinas.put(d.getId(), d.getNome());
        }

        // Filtrar notas do aluno
        List<Nota> notasDoAluno = new ArrayList<>();
        if (todasNotas != null) {
            for (Nota n : todasNotas) {
                if (n.getIdAluno() == aluno.getId()) {
                    notasDoAluno.add(n);
                }
            }
        }

        // Mapa para agrupar notas por disciplina
        Map<Integer, List<Nota>> notasPorDisciplina = new HashMap<>();
        for (Nota n : notasDoAluno) {
            int idDisciplina = n.getIdDisciplina();
            if (!notasPorDisciplina.containsKey(idDisciplina)) {
                notasPorDisciplina.put(idDisciplina, new ArrayList<>());
            }
            notasPorDisciplina.get(idDisciplina).add(n);
        }

        // Calcular boletim
        List<ItemBoletim> boletim = new ArrayList<>();
        double somaMedias = 0;
        int totalDisciplinas = 0;

        for (Map.Entry<Integer, List<Nota>> entry : notasPorDisciplina.entrySet()) {
            int idDisciplina = entry.getKey();
            List<Nota> notas = entry.getValue();

            ItemBoletim item = new ItemBoletim();
            item.setDisciplina(mapaDisciplinas.get(idDisciplina));

            // Pegar N1 e N2 da primeira nota encontrada (assumindo que cada disciplina tem uma nota com N1 e N2)
            if (!notas.isEmpty()) {
                Nota nota = notas.get(0);
                item.setN1(nota.getN1());
                item.setN2(nota.getN2());
            }

            // Calcular média
            double media = (item.getN1() + item.getN2()) / 2;
            item.setMedia(media);

            // Definir situação
            if (media >= 6.0) {
                item.setSituacao("Aprovado");
            } else if (media >= 4.0) {
                item.setSituacao("Recuperação");
            } else {
                item.setSituacao("Reprovado");
            }

            boletim.add(item);
            somaMedias += media;
            totalDisciplinas++;
        }

        double mediaGeral = totalDisciplinas > 0 ? somaMedias / totalDisciplinas : 0;

        request.setAttribute("boletim", boletim);
        request.setAttribute("mediaGeral", String.format("%.1f", mediaGeral));
        request.setAttribute("aluno", aluno);

        request.getRequestDispatcher("/WEB-INF/view/Aluno/boletim.jsp").forward(request, response);
    }

    private void carregarObservacoes(HttpServletRequest request, HttpServletResponse response, Aluno aluno)
            throws ServletException, IOException {

        List<Observacao> todasObservacoes = observacaoDAO.buscarObservacao();
        List<Disciplina> todasDisciplinas = disciplinaDAO.buscar();
        List<Professor> todosProfessores = professorDAO.buscarProfessores();

        // Mapas para consulta rápida
        Map<Integer, String> mapaDisciplinas = new HashMap<>();
        for (Disciplina d : todasDisciplinas) {
            mapaDisciplinas.put(d.getId(), d.getNome());
        }

        Map<Integer, String> mapaProfessores = new HashMap<>();
        for (Professor p : todosProfessores) {
            mapaProfessores.put(p.getId(), p.getNome());
        }

        // Filtrar observações do aluno
        List<Observacao> observacoesDoAluno = new ArrayList<>();
        if (todasObservacoes != null) {
            for (Observacao o : todasObservacoes) {
                if (o.getId_aluno() == aluno.getId()) {
                    observacoesDoAluno.add(o);
                }
            }
        }

        request.setAttribute("observacoes", observacoesDoAluno);
        request.setAttribute("mapaDisciplinas", mapaDisciplinas);
        request.setAttribute("mapaProfessores", mapaProfessores);
        request.setAttribute("aluno", aluno);

        request.getRequestDispatcher("/WEB-INF/view/Aluno/observacoes.jsp").forward(request, response);
    }

    private void realizarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String matricula = request.getParameter("matricula");
        String senha = request.getParameter("senha");

        List<Aluno> alunos = alunoDAO.buscarPorMatricula(matricula);

        if (!alunos.isEmpty() && alunos.get(0).getSenha().equals(senha)) {
            HttpSession session = request.getSession();
            session.setAttribute("alunoLogado", alunos.get(0));
            session.setAttribute("tipoUsuario", "aluno");
            session.setAttribute("msg", "Login realizado com sucesso!");
            session.setAttribute("tipoMsg", "sucesso");

            response.sendRedirect(request.getContextPath() + "/aluno/dashboard");
        } else {
            request.setAttribute("erro", "Matrícula ou senha inválidos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private int calcularTotalDisciplinas(List<Nota> notas) {
        Map<Integer, Boolean> disciplinas = new HashMap<>();
        for (Nota n : notas) {
            disciplinas.put(n.getIdDisciplina(), true);
        }
        return disciplinas.size();
    }

    private double calcularMediaGeral(List<Nota> notas) {
        if (notas.isEmpty()) return 0;

        double soma = 0;
        int contador = 0;

        for (Nota n : notas) {
            if (n.getN1() > 0) {
                soma += n.getN1();
                contador++;
            }
            if (n.getN2() > 0) {
                soma += n.getN2();
                contador++;
            }
        }

        return contador > 0 ? soma / contador : 0;
    }

    private List<ResumoDisciplina> gerarResumoDisciplinas(List<Nota> notas, Map<Integer, String> mapaDisciplinas) {
        Map<Integer, ResumoDisciplina> resumoMap = new HashMap<>();

        for (Nota n : notas) {
            int idDisciplina = n.getIdDisciplina();
            if (!resumoMap.containsKey(idDisciplina)) {
                ResumoDisciplina resumo = new ResumoDisciplina();
                resumo.setDisciplina(mapaDisciplinas.get(idDisciplina));
                resumoMap.put(idDisciplina, resumo);
            }

            ResumoDisciplina resumo = resumoMap.get(idDisciplina);
            if (n.getN1() > 0) resumo.setN1(n.getN1());
            if (n.getN2() > 0) resumo.setN2(n.getN2());
        }

        // Calcular médias e situações
        for (ResumoDisciplina resumo : resumoMap.values()) {
            double media = (resumo.getN1() + resumo.getN2()) / 2;
            resumo.setMedia(media);

            if (media >= 6.0) {
                resumo.setSituacao("Aprovado");
            } else if (media >= 4.0) {
                resumo.setSituacao("Recuperação");
            } else {
                resumo.setSituacao("Reprovado");
            }
        }

        return new ArrayList<>(resumoMap.values());
    }

    // Classes internas para auxiliar
    public static class ItemBoletim {
        private String disciplina;
        private double n1;
        private double n2;
        private double media;
        private String situacao;

        public String getDisciplina() { return disciplina; }
        public void setDisciplina(String disciplina) { this.disciplina = disciplina; }

        public double getN1() { return n1; }
        public void setN1(double n1) { this.n1 = n1; }

        public double getN2() { return n2; }
        public void setN2(double n2) { this.n2 = n2; }

        public double getMedia() { return media; }
        public void setMedia(double media) { this.media = media; }

        public String getSituacao() { return situacao; }
        public void setSituacao(String situacao) { this.situacao = situacao; }
    }

    public static class ResumoDisciplina {
        private String disciplina;
        private double n1;
        private double n2;
        private double media;
        private String situacao;

        public String getDisciplina() { return disciplina; }
        public void setDisciplina(String disciplina) { this.disciplina = disciplina; }

        public double getN1() { return n1; }
        public void setN1(double n1) { this.n1 = n1; }

        public double getN2() { return n2; }
        public void setN2(double n2) { this.n2 = n2; }

        public double getMedia() { return media; }
        public void setMedia(double media) { this.media = media; }

        public String getSituacao() { return situacao; }
        public void setSituacao(String situacao) { this.situacao = situacao; }
    }
}