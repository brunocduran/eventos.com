package br.com.evento.dao;

import br.com.evento.model.Funcao;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FuncaoDAO implements GenericDAO {

    private Connection conexao;

    public FuncaoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Boolean retorno = false;
        try {
            Funcao oFuncao = (Funcao) objeto;
            if (oFuncao.getIdFuncao() == 0) {
                retorno = this.inserir(oFuncao);
            } else {
                retorno = this.alterar(oFuncao);
            }
        } catch (Exception ex) {
            System.out.println("Problemas ao Cadastrar Funcao na DAO! Erro: " + ex.getMessage());
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        Funcao oFuncao = (Funcao) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into funcao (descricao,situacao) values (?,?)";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oFuncao.getDescricao());
            stmt.setString(2, "A");
            stmt.execute();
            conexao.commit();
            return true;

        } catch (Exception e) {
            try {
                System.out.println("Problemas ao cadastrar Funcao na DAO! Erro: " + e.getMessage());
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
        Funcao oFuncao = (Funcao) objeto;
        PreparedStatement stmt = null;
        String sql = "update funcao set descricao = ? where idfuncao = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oFuncao.getDescricao());
            stmt.setInt(2, oFuncao.getIdFuncao());
            stmt.execute();
            conexao.commit();
            return true;

        } catch (Exception e) {
            try {
                System.out.println("Problemas ao alterar Funcao na DAO! Erro: " + e.getMessage());
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
            FuncaoDAO oFuncaoDAO = new FuncaoDAO();
            Funcao oFuncao = (Funcao) oFuncaoDAO.carregar(numero);
            String situacao = "A";
            if (oFuncao.getSituacao().equals(situacao)) {
                situacao = "I";
            } else {
                situacao = "A";
            }

            String sql = "update funcao set situacao = ? where idFuncao = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, situacao);
            stmt.setInt(2, oFuncao.getIdFuncao());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao Excluir Funcao na DAO! Erro: " + e.getMessage());
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
        int idFuncao = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Funcao oFuncao = null;
        String sql = "select * from funcao f where f.idfuncao = ?";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idFuncao);
            rs = stmt.executeQuery();
            while (rs.next()) {
                oFuncao = new Funcao(rs.getInt("idfuncao"),
                        rs.getString("descricao"),
                        rs.getString("situacao"));
            }
        } catch (SQLException e) {
            System.out.println("Problemas ao Carregar Funcao na DAO! Erro: " + e.getMessage());
            e.printStackTrace();
        }
        return oFuncao;
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from funcao";

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Funcao oFuncao = new Funcao(rs.getInt("idfuncao"),
                        rs.getString("descricao"),
                        rs.getString("situacao"));
                resultado.add(oFuncao);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ai Listar Funcao na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

}
