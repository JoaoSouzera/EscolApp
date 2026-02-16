package com.escolApp.model;

public class Professor {
    private int id;
    private String nome;
    private String username;
    private String email;
    private String senha;
    private int idDisciplina;

    // Construtor
    public Professor(int id, String nome, String username, String email, String senha, int idDisciplina) {
        this.id = id;
        this.nome = nome;
        this.username = username;
        this.email = email;
        this.senha = senha;
        this.idDisciplina = idDisciplina;
    }

    public Professor(String nome, String username, String email, String senha, int idDisciplina) {
        this.nome = nome;
        this.username = username;
        this.email = email;
        this.senha = senha;
        this.idDisciplina = idDisciplina;
    }
    // GETTER

    public int getId() {
        return id;
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

    public int getIdDisciplina() {
        return idDisciplina;
    }

    // SETTER

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

    // toString

    public String toString() {
        return "Professor{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", senha='" + senha + '\'' +
                ", id_disciplina=" + idDisciplina +
                '}';
    }
}
