package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Disciplina;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DisciplinaDAO {

    public int inserir(Disciplina dpn){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO DISCIPLINA(NOME) VALUES (?)");

            pstmt.setString(1, dpn.getNome());

            if(pstmt.executeUpdate() > 0){
                return 1;
            }
            else {
                return 0;
            }
        }
        catch (SQLException se){
                se.printStackTrace();
                return -1;
        }
        catch (Exception e){
            e.printStackTrace();
            return -1;
        }
        finally {
            conexao.desconectar(conn);
        }
    }

    public int atualizarDisciplina(Disciplina dpn, String nome){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("UPDATE DISCIPLINA SET NOME = ? WHERE ID = ?");

            pstmt.setString(1, dpn.getNome());

            if(pstmt.executeUpdate() > 0){
                return 1;
            }
            else {
                return 0;
            }
        }
        catch (SQLException se){
            se.printStackTrace();
            return -1;
        }
        catch (Exception e){
            e.printStackTrace();
            return -1;
        }
        finally {
            conexao.desconectar(conn);
        }
    }

    public boolean remover(Disciplina dpn){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM DISCIPLINA WHERE ID = ?");

            pstmt.setString(1, dpn.getNome());

            if(pstmt.executeUpdate() > 0){
                return true;
            }
            else {
                return false;
            }
        }
        catch (SQLException se){
            se.printStackTrace();
            return false;
        }
        catch (Exception e){
            e.printStackTrace();
            return false;
        }
        finally {
            conexao.desconectar(conn);
        }
    }

    public List<Disciplina> buscar() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Disciplina> listDpn = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM DISCIPLINA");

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listDpn.add(new Disciplina(rset.getInt("ID"), rset.getString("NOME")));
            }

        }
        catch (SQLException se){
            se.printStackTrace();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            conexao.desconectar(conn);
            return listDpn;
        }
    }

    public List<Disciplina> buscarPorID(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Disciplina> listDpn = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM DISCIPLINA WHERE ID = ?");
            pstmt.setInt(1, id);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listDpn.add(new Disciplina(rset.getInt("ID"), rset.getString("NOME")));
            }

        }
        catch (SQLException se){
            se.printStackTrace();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            conexao.desconectar(conn);
            return listDpn;
        }
    }

    public List<Disciplina> buscarPorNome(String nome) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Disciplina> listDpn = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM DISCIPLINA WHERE NOME = ?");
            pstmt.setString(1, nome);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listDpn.add(new Disciplina(rset.getInt("ID"), rset.getString("NOME")));
            }

        }
        catch (SQLException se){
            se.printStackTrace();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            conexao.desconectar(conn);
            return listDpn;
        }
    }


}
