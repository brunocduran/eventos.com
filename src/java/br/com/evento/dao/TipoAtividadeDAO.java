/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.TipoAtividade;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author jgcoc
 */
public class TipoAtividadeDAO implements GenericDAO{
    
    private Connection conexao;

    public TipoAtividadeDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Boolean retorno = false;
        try {
            TipoAtividade oTipoAtividade = (TipoAtividade) objeto;
            if (oTipoAtividade.getIdTipoAtividade() == 0) {
                retorno = this.inserir(oTipoAtividade);
            } else {
                retorno = this.alterar(oTipoAtividade);
            }
        } catch (Exception ex) {
            System.out.println("Problemas ao Cadastrar Tipo Atividade na DAO! Erro: " + ex.getMessage());
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        TipoAtividade oTipoAtividade = (TipoAtividade) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into tipoatividade (descricao,situacao) values (?,?)";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oTipoAtividade.getDescricao());
            stmt.setString(2, "A");
            stmt.execute();
            conexao.commit();
            return true;

        } catch (Exception e) {
            try {
                System.out.println("Problemas ao cadastrar Tipo Atividade na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        TipoAtividade oTipoAtividade = (TipoAtividade) objeto;
        PreparedStatement stmt = null;
        String sql = "update tipoatividade set descricao = ? where idtipoatividade = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oTipoAtividade.getDescricao());
            stmt.setInt(2, oTipoAtividade.getIdTipoAtividade());
            stmt.execute();
            conexao.commit();
            return true;

        } catch (Exception e) {
            try {
                System.out.println("Problemas ao alterar Tipo Atividade na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean excluir(int numero) {
        PreparedStatement stmt = null;
        try {
            TipoAtividadeDAO oTipoAtividadeDAO = new TipoAtividadeDAO();
            TipoAtividade oTipoAtividade = (TipoAtividade) oTipoAtividadeDAO.carregar(numero);
            String situacao = "A";
            if (oTipoAtividade.getSituacao().equals(situacao)) {
                situacao = "I";
            } else {
                situacao = "A";
            }

            String sql = "update tipoatividade set situacao = ? where idTipoAtividade = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, situacao);
            stmt.setInt(2, oTipoAtividade.getIdTipoAtividade());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao Excluir Tipo Atividade na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idTipoAtividade = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        TipoAtividade oTipoAtividade = null;
        String sql = "select * from tipoatividade t where t.idtipoatividade = ?";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idTipoAtividade);
            rs = stmt.executeQuery();
            while (rs.next()) {
                oTipoAtividade = new TipoAtividade(rs.getInt("idtipoatividade"),
                        rs.getString("descricao"),
                        rs.getString("situacao"));
            }
        } catch (SQLException e) {
            System.out.println("Problemas ao Carregar Tipo Atividade na DAO! Erro: " + e.getMessage());
            e.printStackTrace();
        }
        return oTipoAtividade;
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from tipoatividade";

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                TipoAtividade oTipoAtividade = new TipoAtividade(rs.getInt("idtipoatividade"),
                        rs.getString("descricao"),
                        rs.getString("situacao"));
                resultado.add(oTipoAtividade);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ai Listar Tipo Atividade na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }
    
}
