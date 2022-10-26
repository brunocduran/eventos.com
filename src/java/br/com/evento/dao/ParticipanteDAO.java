/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Cidade;
import br.com.evento.model.Participante;
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
public class ParticipanteDAO implements GenericDAO{
    
    private Connection conexao;

    public ParticipanteDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }
    
    @Override
    public Boolean cadastrar(Object objeto) {
        Boolean retorno = false;
        try {
            Participante oParticipante = (Participante) objeto;
            if (oParticipante.getIdParticipante() == 0) {                
                int idParticipante = this.verificarCpf(oParticipante.getCpfCnpjPessoa());
                if (idParticipante == 0) {                    
                    retorno = this.inserir(oParticipante);
                } else {                    
                    oParticipante.setIdParticipante(idParticipante);
                    retorno = this.alterar(oParticipante);
                }
            } else {
                retorno = this.alterar(oParticipante);
            }
        } catch (Exception ex) {
            System.out.println("Problmas ao incluir Participante na DAO! Erro " + ex.getMessage());
        }
        return retorno;
    }
    
    public int verificarCpf(String cpf) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int idParticipante = 0;
        String sql = "select pa.* from participante pa, pessoa p where pa.idpessoa = p.idpessoa and p.cpfcnpjpessoa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpf);
            rs = stmt.executeQuery();
            while (rs.next()) {
                idParticipante = rs.getInt("idparticipante");
            }
            return idParticipante;
        } catch (SQLException ex) {
            System.out.println("Problemas ao carregar pessoa! Erro: " + ex.getMessage());
            return idParticipante;
        }
    }

    @Override
    public Boolean inserir(Object objeto) {
        Participante oParticipante = (Participante) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO participante(idpessoa, sexoparticipante, situacao, permitelogin) VALUES (?, ?, ?, ?);";
        try {
            PessoaDAO oPessoaDAO = new PessoaDAO();            
            int idPessoa = oPessoaDAO.cadastrar(oParticipante);
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idPessoa);
            stmt.setString(2, oParticipante.getSexoParticipante());
            stmt.setString(3, "A");
            stmt.setString(4, "S");
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao cadastrar Participante na DAO! Erro:" + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        Participante oParticipante = (Participante) objeto;
        PreparedStatement stmt = null;
        String sql = "update participante set sexoparticipante = ? where idParticipante = ?";

        try {
            PessoaDAO oPessoaDAO = new PessoaDAO();
            oPessoaDAO.cadastrar(oParticipante);
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oParticipante.getSexoParticipante());
            stmt.setInt(2, oParticipante.getIdParticipante());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao Alterar Participante na DAO! Erro: " + e.getMessage());
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
            ParticipanteDAO oParticipanteDAO = new ParticipanteDAO();
            Participante oParticipante = (Participante) oParticipanteDAO.carregar(numero);
            String situacao = "A";
            if (oParticipante.getSituacao().equals(situacao)) {
                situacao = "I";
            } else {
                situacao = "A";
            }

            String sql = "update participante set situacao = ? where idParticipante = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, situacao);
            stmt.setInt(2, oParticipante.getIdParticipante());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao Excluir Participante na DAO! Erro: " + e.getMessage());
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
        int idParticipante = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Participante oParticipante = null;
        String sql = "select * from participante pa, pessoa p where pa.idpessoa = p.idpessoa and pa.idparticipante = ?";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idParticipante);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Cidade oCidade = null;
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ao Carregar Cidade na Participante DAO! Erro: " + ex.getMessage());
                }

                oParticipante = new Participante(rs.getInt("idparticipante"),
                        rs.getString("sexoparticipante"),   
                        rs.getString("permitelogin"),
                        rs.getString("situacao"),
                        rs.getInt("idpessoa"),
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade);
            }
        } catch (SQLException e) {
            System.out.println("Problemas ao Carregar Participante na DAO! Erro: " + e.getMessage());
            e.printStackTrace();
        }
        return oParticipante;
    }

   
    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select p.*, pa.idparticipante, pa.sexoparticipante, pa.situacao, pa.permitelogin from participante pa, pessoa p "
                + "where pa.idpessoa = p.idpessoa order by idPessoa";

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Cidade oCidade = null;
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ai Listar Cidade na Participante na DAO! Erro: " + ex.getMessage());
                }

                Participante oParticipante = new Participante(rs.getInt("idparticipante"),
                        rs.getString("sexoparticipante"),
                        rs.getString("permitelogin"),
                        rs.getString("situacao"),
                        rs.getInt("idpessoa"),
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade);
                resultado.add(oParticipante);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ai Listar Participante na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }
    
    public List<Object> listarAtivos() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select p.*, pa.idparticipante, pa.sexoparticipante, pa.situacao, pa.permitelogin from participante pa, pessoa p "
                + "where pa.idpessoa = p.idpessoa and pa.situacao = 'A' order by idPessoa";

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Cidade oCidade = null;
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ai Listar Cidade na Participante na DAO! Erro: " + ex.getMessage());
                }

                Participante oParticipante = new Participante(rs.getInt("idparticipante"),
                        rs.getString("sexoparticipante"),
                        rs.getString("permitelogin"),
                        rs.getString("situacao"),
                        rs.getInt("idpessoa"),
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade);
                resultado.add(oParticipante);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ai Listar Participante na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }
    
}
