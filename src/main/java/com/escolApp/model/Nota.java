package com.escolApp.model;

public class Nota {
    private int id;
    private double n1;
    private double n2;
    private int idAluno;
    private int idDisciplina;

    // CONSTRUTOR

    public Nota(int id, double n1, double n2, int idAluno, int idDisciplina) {
        this.id = id;
        this.n1 = n1;
        this.n2 = n2;
        this.idAluno = idAluno;
        this.idDisciplina = idDisciplina;
    }

    // GETTER

    public int getId() {
        return id;
    }

    public double getN1() {
        return n1;
    }

    public double getN2() {
        return n2;
    }

    public int getIdAluno() {
        return idAluno;
    }

    public int getIdDisciplina() {
        return idDisciplina;
    }
    // SETTER

    public void setN1(double n1) {
        this.n1 = n1;
    }
    public void setN2(double n2) {
        this.n2 = n2;
    }

    // toString
    public String toString() {
        return "Nota{" +
                "id=" + id +
                ", n1=" + n1 +
                ", n2=" + n2 +
                ", idAluno='" + idAluno + '\'' +
                ", idDisciplina=" + idDisciplina +
                '}';
    }
}
