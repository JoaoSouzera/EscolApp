package com.escolApp.utils;

import com.escolApp.conexao.Conexao;

public class Main {
    public static void main(String[] args) {
        System.out.println(System.getenv("DB_URL"));
        Conexao con1 = new Conexao();
        if(con1.conectar() == null){
            System.out.println("Não conectou");
            System.out.println(con1.conectar());
        }
        else {
            System.out.println("Conectou");
            System.out.println(con1.conectar());
        }
        con1.desconectar(con1.conectar());
    }
}
