package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Professor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfessorDAO {
    // CREATE
    public boolean inserirProfessor(Professor prof){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PROFESSOR "+
                    "(ID,NOME,USERNAME,EMAIL,SENHA,ID_DISCIPLINA) VALUES (?,?,?,?,?,?)");
            pstmt.setInt(1,prof.getId());
            pstmt.setString(2, prof.getNome());
            pstmt.setString(3, prof.getUsername());
            pstmt.setString(4, prof.getEmail());
            pstmt.setString(5, prof.getSenha());
            pstmt.setInt(6,prof.getIdDisciplina());
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
    public List<Professor> buscarProfessores(){
        Conexao conexao = new Conexao();
        List<Professor> lista = new ArrayList<>();
        try{
            Connection conn = conexao.conectar();
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("SELECT * FROM PROFESSOR");
            while (rset.next()){
                lista.add(new Professor(rset.getInt("ID"),rset.getString("NOME"),
                        rset.getString("USERNAME"),rset.getString("EMAIL"),
                        rset.getString("SENHA"),rset.getInt("ID_DISCIPLINA")));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            conexao.desconectar(conexao.conectar());
        }
        return null;
    }
    // UPDATE
    public boolean alterarSenha (int num, String senha){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE PROFESSOR SET SENHA = ? WHERE ID = ?");
            pstmt.setString(1, senha);
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
    public boolean removerProfessor(int num){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            String remover = "DELETE FROM PROFESSOR WHERE ID = ?";
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
