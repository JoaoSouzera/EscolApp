package com.escolApp.model;

public class Disciplina {

    private int id;
    private String nome;

    public Disciplina(int id, String nome){
        this.id = id;
        this.nome = nome;
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String toString(){
        return "ID: " + this.id + "Disciplina: " + this.nome;
    }
}
