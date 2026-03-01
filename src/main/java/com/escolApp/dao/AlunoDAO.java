package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Aluno;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AlunoDAO {

    public int inserir(Aluno aluno){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO ALUNO (MATRICULA, NOME, USERNAME, EMAIL, SENHA) VALUES (?, ?, ?, ?, ?)");

            pstmt.setString(1, aluno.getMatricula());
            pstmt.setString(2, aluno.getNome());
            pstmt.setString(3, aluno.getUsername());
            pstmt.setString(4, aluno.getEmail());
            pstmt.setString(5, aluno.getSenha());

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

    public int atualizarMatricula(Aluno aluno, String matricula){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ALUNO SET MATRICULA = ? WHERE ID = ?");

            pstmt.setString(1, matricula);
            pstmt.setInt(2, aluno.getId());

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

    public int atualizarNome(Aluno aluno, String nome){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ALUNO SET NOME = ? WHERE ID = ?");

            pstmt.setString(1, nome);
            pstmt.setInt(2, aluno.getId());

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

    public int atualizarUsername(Aluno aluno, String user){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ALUNO SET USERNAME = ? WHERE ID = ?");

            pstmt.setString(1, user);
            pstmt.setInt(2, aluno.getId());

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

    public int atualizarEmail(Aluno aluno, String email){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ALUNO SET EMAIL = ? WHERE ID = ?");

            pstmt.setString(1, email);
            pstmt.setInt(2, aluno.getId());

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

    public int atualizarSenha(Aluno aluno, String senha){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("UPDATE ALUNO SET SENHA = ? WHERE ID = ?");

            pstmt.setString(1, senha);
            pstmt.setInt(2, aluno.getId());

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

    public boolean remover(Aluno aluno){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM ALUNO WHERE ID = ?");

            pstmt.setInt(1, aluno.getId());

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

    public List<Aluno> buscar() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO");

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

    public List<Aluno> buscarPorid(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO WHERE ID = ?");
            pstmt.setInt(1, id);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

    public List<Aluno> buscarPorMatricula(String matricula) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO WHERE MATRICULA = ?");
            pstmt.setString(1, matricula);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

    public List<Aluno> buscarPorNome(String nome) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO WHERE NOME = ?");
            pstmt.setString(1, nome);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

    public List<Aluno> buscarPorUser(String user) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO WHERE USERNAME = ?");
            pstmt.setString(1, user);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

    public List<Aluno> buscarPorEmail(String email) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO WHERE EMAIL = ?");
            pstmt.setString(1, email);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

    public List<Aluno> buscarPorSenha(String senha) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        List<Aluno> listAluno = new ArrayList<>();

        try{
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ALUNO WHERE SENHA = ?");
            pstmt.setString(1, senha);

            ResultSet rset = pstmt.executeQuery();

            while (rset.next()){
                listAluno.add(new Aluno(rset.getInt("ID"), rset.getString("MATRICULA"), rset.getString("NOME"), rset.getString("USERNAME"), rset.getString("EMAIL"), rset.getString("SENHA")));
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
            return listAluno;
        }
    }

}
