/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Despesa;
import br.com.evento.model.Evento;
import br.com.evento.model.Fornecedor;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author johat
 */
public class DespesaDAO implements GenericDAO {

    private Connection conexao;

    public DespesaDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Despesa oDespesa = (Despesa) objeto;
        boolean retorno = false;
        if (oDespesa.getIdDespesa() == 0) {
            retorno = inserir(oDespesa);
        } else {
            retorno = alterar(oDespesa);
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        Despesa oDespesa = (Despesa) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into despesa (valordespesa, vencimentodespesa, descricao, situacao, idfornecedor, idevento)"
                + " values (?,?,?,?,?,?)";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, oDespesa.getValorDespesa());
            stmt.setDate(2, new java.sql.Date(oDespesa.getVencimentoDespesa().getTime()));
            stmt.setString(3, oDespesa.getDescricao());
            stmt.setString(4, "A");
            stmt.setInt(5, oDespesa.getFornecedor().getIdFornecedor());
            stmt.setInt(6, oDespesa.getEvento().getIdEvento());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao cadastrar Despesa na dao! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problema no rollback da Despesa ao cadastrar na dao! " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        Despesa oDespesa = (Despesa) objeto;
        PreparedStatement stmt = null;
        String sql = "update despesa set valordespesa=? ,vencimentodespesa=?, descricao=?,"
                + "situacao=?, idfornecedor=?, idevento=? where iddespesa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, oDespesa.getValorDespesa());
            stmt.setDate(2, (Date) oDespesa.getVencimentoDespesa());
            stmt.setString(3, oDespesa.getDescricao());
            stmt.setString(4, oDespesa.getSituacao());
            stmt.setInt(5, oDespesa.getFornecedor().getIdFornecedor());
            stmt.setInt(6, oDespesa.getEvento().getIdEvento());
            stmt.setInt(7, oDespesa.getIdDespesa());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao alterar Despesa na dao! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problema no rollback da Despesa ao alterar na dao! " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }

    }

    @Override
    public Boolean excluir(int numero) {
        int iddespesa = numero;
        PreparedStatement stmt = null;

        String sql = "delete from despesa where iddespesa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, iddespesa);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problemas ao excluir a Despesa! Erro: " + ex.getMessage());

            try {
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro rolback " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idDespesa = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Despesa oDespesa = null;
        String sql = "select * from despesa where iddespesa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idDespesa);
            rs = stmt.executeQuery();
            while (rs.next()) {
                oDespesa = new Despesa();
                oDespesa.setIdDespesa(rs.getInt("iddespesa"));
                oDespesa.setValorDespesa(rs.getDouble("valordespesa"));
                oDespesa.setVencimentoDespesa(rs.getDate("vencimentodespesa"));
                oDespesa.setPagamentoDespesa(rs.getDate("pagamentodespesa"));
                oDespesa.setDescricao(rs.getString("descricao"));
                oDespesa.setSituacao(rs.getString("situacao"));

                FornecedorDAO oFornecedorDAO = new FornecedorDAO();
                oDespesa.setFornecedor((Fornecedor) oFornecedorDAO.carregar(rs.getInt("idfornecedor")));

                EventoDAO oEventoDAO = new EventoDAO();
                oDespesa.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

            }
            return oDespesa;
        } catch (Exception ex) {
            System.out.println("Problemas ao carregar Despesa na DAO! Erro:" + ex.getMessage());
            return false;
        }
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from despesa order by iddespesa";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Despesa oDespesa = new Despesa();

                oDespesa.setIdDespesa(rs.getInt("iddespesa"));
                oDespesa.setValorDespesa(rs.getDouble("valordespesa"));
                oDespesa.setVencimentoDespesa(rs.getDate("vencimentodespesa"));
                oDespesa.setPagamentoDespesa(rs.getDate("pagamentodespesa"));
                oDespesa.setDescricao(rs.getString("descricao"));
                oDespesa.setSituacao(rs.getString("situacao"));

                //busca Fornecedor
                FornecedorDAO oFornecedorDAO = null;
                try {
                    oFornecedorDAO = new FornecedorDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Fornecedor " + ex.getMessage());
                    ex.printStackTrace();
                }
                oDespesa.setFornecedor((Fornecedor) oFornecedorDAO.carregar(rs.getInt("idfornecedor")));

                //busca Evento
                EventoDAO oEventoDAO = null;
                try {
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Evento " + ex.getMessage());
                    ex.printStackTrace();
                }
                oDespesa.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

                resultado.add(oDespesa);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar despesa na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

    public Boolean pagamento(int numero, Date data) {
        int idDespesa = numero;
        Date dataPagamento = data;
        PreparedStatement stmt = null;
        String sql = "update despesa set situacao =?, pagamentodespesa=? where iddespesa=?";
        try {
            Despesa oDespesa = (Despesa) this.carregar(idDespesa);
            stmt = conexao.prepareStatement(sql);
            if (oDespesa.getSituacao().equals("A")) {
                stmt.setString(1, "P");//se situacao do pagamento atual for Aberto --> Paga
                stmt.setDate(2, (Date) dataPagamento);
            } else {
                stmt.setString(1, "A");//se situacao do pagamento atual for Paga --> Aberto
                stmt.setDate(2, null);
            }
            stmt.setInt(3, idDespesa);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problemas no pagamento na DAO! Erro: " + ex.getMessage());
            try {
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro rollback " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    public List<Object> listarPorEvento(int idEvento, int idUsuario) {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from despesa where 1=1 ";

        if (idEvento > 0) {
            sql += " and despesa.idevento = ? ";
        }

        if (idUsuario > 0) {
            sql += " and despesa.idevento in (select evento.idevento from evento where evento.idevento in (select organizadorevento.idevento"
                    + " from organizadorevento where organizadorevento.idorganizador = ? )) ";
        }

        sql += " order by iddespesa";
        try {
            stmt = conexao.prepareStatement(sql);

            if (idEvento > 0) {
                stmt.setInt(1, idEvento);
            }

            if ((idUsuario > 0) && (idEvento == 0)) {
                stmt.setInt(1, idUsuario);
            } else if ((idUsuario > 0) && (idEvento > 0)) {
                stmt.setInt(2, idUsuario);
            }

            rs = stmt.executeQuery();
            while (rs.next()) {
                Despesa oDespesa = new Despesa();

                oDespesa.setIdDespesa(rs.getInt("iddespesa"));
                oDespesa.setValorDespesa(rs.getDouble("valordespesa"));
                oDespesa.setVencimentoDespesa(rs.getDate("vencimentodespesa"));
                oDespesa.setPagamentoDespesa(rs.getDate("pagamentodespesa"));
                oDespesa.setDescricao(rs.getString("descricao"));
                oDespesa.setSituacao(rs.getString("situacao"));

                //busca Fornecedor
                FornecedorDAO oFornecedorDAO = null;
                try {
                    oFornecedorDAO = new FornecedorDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Fornecedor " + ex.getMessage());
                    ex.printStackTrace();
                }
                oDespesa.setFornecedor((Fornecedor) oFornecedorDAO.carregar(rs.getInt("idfornecedor")));

                //busca Evento
                EventoDAO oEventoDAO = null;
                try {
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Evento " + ex.getMessage());
                    ex.printStackTrace();
                }
                oDespesa.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

                resultado.add(oDespesa);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar despesa na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

    public String buscarTotalDespesa() {
        //int idOrganizadorParametro = idorganizador;
        //int idEventoParametro = idevento;
        String retorno = "";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select coalesce(sum(valordespesa),0) as valordespesa from despesa where situacao = 'P'";

        try {
            stmt = conexao.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                retorno = rs.getString("valordespesa");
            }
            retorno = retorno.replace(".", ",");

            if (retorno.equals("0")) {
                retorno = "-";
            }else{
                retorno = "R$ " + retorno;
            }

            return retorno;
        } catch (SQLException ex) {
            System.out.println("Problemas no método buscarTotalDespesa na DespesaDAO " + ex.getMessage());
            return "";
        }

    }
}
