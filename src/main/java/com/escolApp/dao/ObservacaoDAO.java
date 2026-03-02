package com.escolApp.dao;

import com.escolApp.conexao.Conexao;
import com.escolApp.model.Observacao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ObservacaoDAO {
    public boolean inserirObservacao(Observacao obs){
        Conexao conexao = new Conexao();
        Connection conn = null;
        try {
            conn = conexao.conectar();
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO observacao (TEXTO,DATA,ID_ALUNO," +
                    "ID_PROFESSOR,ID_DISCIPLINA) VALUES (?,?,?,?,?)");
            pstmt.setString(1,obs.getTexto());
            pstmt.setTimestamp(2,obs.getData());
            pstmt.setInt(3,obs.getId_aluno());
            pstmt.setInt(4,obs.getId_professor());
            pstmt.setInt(5,obs.getId_disciplina());
            if (pstmt.executeUpdate() > 0){
                return true;
            }
            else {
                return false;
            }
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            conexao.desconectar(conn);
        }
    }

    public List<Observacao> buscarObservacao(){
        Conexao conexao = new Conexao();
        Connection conn = null;
        List<Observacao> listaObs = new ArrayList<>();
        try{
            conn = conexao.conectar();
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery("SELECT * FROM OBSERVACAO");
            while (rset.next()){
                listaObs.add(new Observacao(rset.getInt("ID"),rset.getString("TEXTO"),
                        rset.getTimestamp("DATA"), rset.getInt("ID_ALUNO"), rset.getInt("ID_PROFESSOR"),
                        rset.getInt("ID_DISCIPLINA")));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            conexao.desconectar(conn);
        }
        return null;
    }
}
