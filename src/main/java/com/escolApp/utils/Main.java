package com.escolApp.utils;

import com.escolApp.conexao.Conexao;
import com.escolApp.dao.AdmDAO;
import com.escolApp.dao.NotaDAO;
import com.escolApp.dao.ProfessorDAO;
import com.escolApp.model.Nota;
import com.escolApp.model.Professor;

import javax.lang.model.util.ElementScanner6;
import java.sql.ResultSet;
import java.util.List;

public class Main {
    public static void main(String[] args) {
//        System.out.println(System.getenv("DB_URL"));
//        Conexao con1 = new Conexao();
//        if(con1.conectar() == null){
//            System.out.println("Não conectou");
//            System.out.println(con1.conectar());
//        }
//        else {
//            System.out.println("Conectou");
//            System.out.println(con1.conectar());
//        }
//        con1.desconectar(con1.conectar());


//        ProfessorDAO prof = new ProfessorDAO();
//        Professor prof1 = new Professor(6, "Matheus Rezende", "Matheus", "mat.data", "123",
//                6);
//        NotaDAO nota =  new NotaDAO();
//        Nota notas = new Nota(1,4.5,7.8,1,3);
//      TESTE NOTA
//        if (nota.inserirNota(notas)){
//            System.out.println("Inserido!");
//        }
//        else {
//            System.out.println("Não foi inserido");
//        }
//        List<Nota> not = nota.buscarNota();
//        for (int i = 0; i < not.size(); i++){
//            System.out.println(not.get(i));
//        }
//        if (nota.atualizarN1(1,6.5)){
//            System.out.println("ATUALIZADO");
//        }else {
//            System.out.println("ERRO");
//        }
//        if (nota.removerNota(1)){
//            System.out.println("REMOVIDO");
//        }
//        else {
//            System.out.println("ERRO");
//        }

        // TESTE PROFESSOR
//        if (prof.inserirProfessor(prof1)){
//            System.out.println("INSERIDO");
//        }
//        else{
//            System.out.println("ERRO");
//        }
//        List<Professor> professores = prof.buscarProfessores();
//        for (int i = 0; i < professores.size(); i++){
//            System.out.println(professores.get(i));
//        }

//        if (prof.alterarSenha(prof1.getId(),"1234")){
//            System.out.println("Alterado");
//        }
//        else{
//            System.out.println("ERRO");
//        }

//        if (prof.removerProfessor(prof1.getId())){
//            System.out.println("REMOVIDO");
//        }
//        else{
//            System.out.println("ERRO");
//        }
//    }

        AdmDAO adm = new AdmDAO();

        adm.buscarAdm();
    }
}
