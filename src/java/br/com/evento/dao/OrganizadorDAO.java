/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Cidade;
import br.com.evento.model.Organizador;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author bruno
 */
public class OrganizadorDAO implements GenericDAO {

    private Connection conexao;

    public OrganizadorDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Boolean retorno = false;
        try {
            Organizador oOrganizador = (Organizador) objeto;
            if (oOrganizador.getIdOrganizador()== 0) {//inserção
                //verifica se já existe pessoa com este CPF cadastrada.
                int idOrganizador = this.verificarCpf(oOrganizador.getCpfCnpjPessoa());
                if (idOrganizador == 0) {
                    //se não encontrou insere
                    retorno = this.inserir(oOrganizador);
                } else {
                    //se encontrou organizador com o cpf altera
                    oOrganizador.setIdOrganizador(idOrganizador);
                    retorno = this.alterar(oOrganizador);
                }
            } else {
                retorno = this.alterar(oOrganizador);
            }
        } catch (Exception ex) {
            System.out.println("Problmas ao incluir Organizador na DAO! Erro " + ex.getMessage());
        }
        return retorno;
    }

    public int verificarCpf(String cpf) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int idOrganizador = 0;
        String sql = "select o.* from organizador o, pessoa p where o.idpessoa = p.idpessoa and p.cpfcnpjpessoa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpf);
            rs = stmt.executeQuery();
            while (rs.next()) {
                idOrganizador = rs.getInt("idorganizador");
            }
            return idOrganizador;
        } catch (SQLException ex) {
            System.out.println("Problemas ao carregar pessoa no OrganizadorDAO! Erro: " + ex.getMessage());
            return idOrganizador;
        }
    }

    @Override
    public Boolean inserir(Object objeto) {
        Organizador oOrganizador = (Organizador) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO organizador(idpessoa, situacao, permitelogin) VALUES (?, ?, ?);";
        try {
            PessoaDAO oPessoaDAO = new PessoaDAO();
            //manda informções para o cadastrar de pessoa.
            int idPessoa = oPessoaDAO.cadastrar(oOrganizador);
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idPessoa);
            stmt.setString(2, "A");
            stmt.setString(3, "S");
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao cadastrar Organizador na DAO! Erro:" + e.getMessage());
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
        Organizador oOrganizador = (Organizador) objeto;
        PreparedStatement stmt = null;
        String sql = "UPDATE organizador SET permitelogin=? WHERE idorganizador=?;";
        try {
            PessoaDAO oPessoaDAO = new PessoaDAO();
            oPessoaDAO.cadastrar(oOrganizador); //envia para classe PessoaDAO
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oOrganizador.getPermiteLogin());
            stmt.setInt(2, oOrganizador.getIdOrganizador());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao alterar Organizador na DAO! Erro: " + e.getMessage());
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
    public Boolean excluir(int numero) {
        PreparedStatement stmt = null;
        try {
            //carrega dados de admintrador
            OrganizadorDAO oOrganizadorDAO = new OrganizadorDAO();
            Organizador oOrganizador = (Organizador) oOrganizadorDAO.carregar(numero);
            String situacao = "A";//verifica e troca a situação do Organizador
            if (oOrganizador.getSituacao().equals(situacao)) {
                situacao = "I";
            } else {
                situacao = "A";
            }

            String sql = "UPDATE organizador SET situacao=? WHERE idorganizador=?;";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, situacao);
            stmt.setInt(2, oOrganizador.getIdOrganizador());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao excluir Organizador na DAO! Erro: " + e.getMessage());
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
    public Object carregar(int numero) {
        int idOrganizador = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Organizador oOrganizador = null;
        String sql = "select * from organizador o, pessoa p where o.idpessoa = p.idpessoa and o.idorganizador = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idOrganizador);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //busca cidade
                Cidade oCidade = null;
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar cidade da OrganizadorDAO! Erro " + ex.getMessage());
                }

                oOrganizador = new Organizador(rs.getInt("idorganizador"),
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
            System.out.println("Problemas ao carregar Organizador na DAO! Erro " + e.getMessage());
            e.printStackTrace();
        }
        return oOrganizador;
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select p.*, o.idorganizador, o.situacao, o.permitelogin from organizador o, pessoa p where o.idpessoa = p.idpessoa order by idpessoa";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Cidade oCidade = null;//busca cidade
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar cidade no OrganizadorDAO! Erro: " + ex.getMessage());
                }
                Organizador oOrganizador = new Organizador(rs.getInt("idorganizador"),
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
                resultado.add(oOrganizador);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar Organizador na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

}
