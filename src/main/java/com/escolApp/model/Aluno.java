package com.escolApp.model;

public class Aluno {

    private int id;
    private String matricula;
    private String nome;
    private String username;
    private String email;
    private String senha;

    public Aluno(int id, String matricula, String nome, String username, String email, String senha) {
        this.id = id;
        this.matricula = matricula;
        this.nome = nome;
        this.username = username;
        this.email = email;
        this.senha = senha;
    }

    public Aluno(String matricula, String nome, String username, String email, String senha) {
        this.matricula = matricula;
        this.nome = nome;
        this.username = username;
        this.email = email;
        this.senha = senha;
    }



    public int getId() {
        return id;
    }

    public String getMatricula() {
        return matricula;
    }

    public String getNome() {
        return nome;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getSenha() {
        return senha;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String toString(){
        return "ID : " + this.id + "Matrícula: " + this.matricula + "Nome: " + this.nome + "User: " +
                this.username + "Email: " + this.email + "Senha: " + this.senha;
    }
}
