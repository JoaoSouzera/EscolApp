package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Adm;
import com.escolApp.model.Nota;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdmDAO {

    // CREATE
    public boolean inserirAdm(Adm adm){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO ADM "+
                    "(USERNAME,EMAIL,SENHA) VALUES (?,?,?)");
            pstmt.setString(1, adm.getUsername());
            pstmt.setString(2, adm.getEmail());
            pstmt.setString(3,adm.getSenha());
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

    public List<Adm> buscarAdm(){
        Conexao conexao = new Conexao();
        List<Adm> lista = new ArrayList<>();
        try {
            Connection conn = conexao.conectar();
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("SELECT * FROM ADM");
            while (rset.next()){
                lista.add(new Adm(rset.getInt("ID"),rset.getString("USERNAME"),
                        rset.getString("EMAIL"),rset.getString("SENHA")));
            }
            return lista;
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            conexao.desconectar(conexao.conectar());
        }
        return null;
    }

    // UPDATE

    public boolean atualizarUsername(int num, String username){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ADM SET USERNAME = ? WHERE ID = ?");
            pstmt.setString(1,username);
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
    public boolean atualizarEmail(int num, String email){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ADM SET EMAIL = ? WHERE ID = ?");
            pstmt.setString(1,email);
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
    public boolean atualizarSenha(int num, String senha){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ADM SET SENHA = ? WHERE ID = ?");
            pstmt.setString(1,senha);
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
    public boolean removerAdm(int num){
        Conexao conexao = new Conexao();
        try{
            Connection conn = conexao.conectar();
            String remover = "DELETE FROM ADM WHERE ID = ?";
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
