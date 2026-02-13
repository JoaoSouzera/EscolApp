package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Nota;
import com.escolApp.model.Professor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotaDAO {
    // CREATE
    public boolean inserirNota(Nota nota){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO NOTA "+
                    "(ID,N1,N2,ID_ALUNO,ID_DISCIPLINA) VALUES (?,?,?,?,?)");
            pstmt.setInt(1, nota.getId());
            pstmt.setDouble(2,nota.getN1());
            pstmt.setDouble(3,nota.getN2());
            pstmt.setInt(4,nota.getIdAluno());
            pstmt.setInt(5,nota.getIdDisciplina());
            if (pstmt.executeUpdate() > 0){
                return true;
            }
            else {
                return false;
            }
        } catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            conexao.desconectar(conexao.conectar());
        }
    }

    // READ
    public List<Nota> buscarNota(){
        Conexao conexao = new Conexao();
        List<Nota> notas = new ArrayList<>();
        try {
            Connection conn = conexao.conectar();
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("SELECT * FROM NOTA");
            while (rset.next()){
                notas.add(new Nota(rset.getInt("ID"),rset.getDouble("N1"),
                        rset.getDouble("N2"),rset.getInt("ID_ALUNO"),
                        rset.getInt("ID_DISCIPLINA")));
            }
            return notas;
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            conexao.desconectar(conexao.conectar());
        }
        return null;
    }

    // UPDATE
    public boolean atualizarN1(int num, double n1){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE NOTA SET N1 = ? WHERE ID = ?");
            pstmt.setDouble(1, n1);
            pstmt.setInt(2, num);
            if (pstmt.executeUpdate() > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            conexao.desconectar(conexao.conectar());
        }
    }

    // UPDATE
    public boolean atualizarN2(int num, double n2){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE NOTA SET N2 = ? WHERE ID = ?");
            pstmt.setDouble(1, n2);
            pstmt.setInt(2, num);
            if (pstmt.executeUpdate() > 0) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            conexao.desconectar(conexao.conectar());
        }
    }

    // DELETE
    public boolean removerNota(int num){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            String remover = "DELETE FROM NOTA WHERE ID = ?";
            PreparedStatement pstmt = conn.prepareStatement(remover);
            pstmt.setInt(1,num);
            if (pstmt.executeUpdate() > 0){
                return true;
            }
            else{
                return false;
            }
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            conexao.desconectar(conexao.conectar());
        }
    }
}
