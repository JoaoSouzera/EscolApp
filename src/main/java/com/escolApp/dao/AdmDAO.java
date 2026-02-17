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
        Connection conn = null;
        PreparedStatement pstmt = null;
        try{
            conn = conexao.conectar();
            pstmt = conn.prepareStatement("INSERT INTO ADM "+
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

    public Adm buscarPorId(int id) {
        Conexao conexao = new Conexao();
        Adm adm = null;
        String sql = "SELECT * FROM adm WHERE id = ?";
        Connection conn = conexao.conectar();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                adm = new Adm(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("senha"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return adm;
    }

    // UPDATE

    public boolean atualizarUsername(int num, String username){
        Conexao conexao = new Conexao();
        Connection conn = null;
        try{
            conn = conexao.conectar();
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
            conexao.desconectar(conn);
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


    // AUTENTICAR
    public Adm autenticar(String username, String senha) {
        Conexao conexao = new Conexao();
        Adm adm = null;

        String sql = "SELECT * FROM adm WHERE username = ? AND senha = ?";

        try (
                Connection conn = conexao.conectar();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, username);
            stmt.setString(2, senha);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                adm = new Adm(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("senha")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return adm;
    }

}
