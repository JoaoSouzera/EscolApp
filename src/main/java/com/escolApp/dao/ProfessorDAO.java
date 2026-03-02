package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Adm;
import com.escolApp.model.Professor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfessorDAO {
    // CREATE
    public boolean inserirProfessor(Professor prof){ // TESTADO! FUNCIONANDO...
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PROFESSOR "+
                    "(NOME,USERNAME,EMAIL,SENHA,ID_DISCIPLINA) VALUES (?,?,?,?,?)");
            pstmt.setString(1, prof.getNome());
            pstmt.setString(2, prof.getUsername());
            pstmt.setString(3, prof.getEmail());
            pstmt.setString(4, prof.getSenha());
            pstmt.setInt(5,prof.getIdDisciplina());
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
    public List<Professor> buscarProfessores(){ // TESTADO! FUNCIONANDO...
        Conexao conexao = new Conexao();
        Connection conn = null;
        List<Professor> lista = new ArrayList<>();
        try{
            conn = conexao.conectar();
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("SELECT * FROM PROFESSOR");
            while (rset.next()){
                lista.add(new Professor(rset.getInt("ID"),rset.getString("NOME"),
                        rset.getString("USERNAME"),rset.getString("EMAIL"),
                        rset.getString("SENHA"),rset.getInt("ID_DISCIPLINA")));
            }
            return lista;
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            conexao.desconectar(conn);
        }
        return null;
    }
    // UPDATE
    public boolean alterarSenha (int num, String senha){ //TESTADO! FUNCIONANDO...
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
    public boolean removerProfessor(int num){ // TESTADO! FUNCIONANDO...
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


    // AUTENTICAR
    public Professor autenticar(String username, String senha) {
        Conexao conexao = new Conexao();
        Professor prof = null;

        String sql = "SELECT * FROM professor WHERE username = ? AND senha = ?";

        try (
                Connection conn = conexao.conectar();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, username);
            stmt.setString(2, senha);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                prof = new Professor(rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("senha"),
                        rs.getInt("id_disciplina")
                );
            }
            return prof;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return prof;
    }

}
