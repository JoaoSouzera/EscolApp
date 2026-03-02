package com.escolApp.model;

import java.sql.Timestamp;

public class Observacao {
    private int id;
    private String texto;
    private Timestamp data;
    private int id_aluno;
    private int id_professor;
    private int id_disciplina;

    public Observacao(int id, String texto, Timestamp data, int id_aluno, int id_professor, int id_disciplina) {
        this.id = id;
        this.texto = texto;
        this.data = data;
        this.id_aluno = id_aluno;
        this.id_professor = id_professor;
        this.id_disciplina = id_disciplina;
    }

    public Observacao(String texto, Timestamp data, int id_aluno, int id_professor, int id_disciplina) {
        this.texto = texto;
        this.data = data;
        this.id_aluno = id_aluno;
        this.id_professor = id_professor;
        this.id_disciplina = id_disciplina;
    }
    public Observacao() {
    }

        public int getId() {
        return id;
    }

    public String getTexto() {
        return texto;
    }

    public Timestamp getData() {
        return data;
    }

    public int getId_aluno() {
        return id_aluno;
    }

    public int getId_professor() {
        return id_professor;
    }

    public int getId_disciplina() {
        return id_disciplina;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public void setData(Timestamp data) {
        this.data = data;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setId_aluno(int id_aluno) {
        this.id_aluno = id_aluno;
    }

    public void setId_professor(int id_professor) {
        this.id_professor = id_professor;
    }

    public void setId_disciplina(int id_disciplina) {
        this.id_disciplina = id_disciplina;
    }

    public String toString() {
        return "Observacao{" +
                "id=" + id +
                ", texto='" + texto + '\'' +
                ", data='" + data + '\'' +
                ", id_aluno=" + id_aluno +
                ", id_professor=" + id_professor +
                ", id_disciplina=" + id_disciplina +
                '}';
    }
}
