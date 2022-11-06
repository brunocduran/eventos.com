/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Evento;
import br.com.evento.model.Funcao;
import br.com.evento.model.Organizador;
import br.com.evento.model.OrganizadorEvento;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author igorb
 */
public class OrganizadorEventoDAO {

    private Connection conexao;

    public OrganizadorEventoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    public int cadastrar(Object objeto) throws ParseException {
        OrganizadorEvento oOrganizadorEvento = (OrganizadorEvento) objeto;
        int retorno = 0;
        if (oOrganizadorEvento.getIdOrganizadorEvento() == 0) {
            retorno = this.inserir(oOrganizadorEvento);
        } else {
            retorno = this.alterar(oOrganizadorEvento);
        }
        return retorno;
    }

    public int inserir(Object objeto) {
        OrganizadorEvento oOrganizadorEvento = (OrganizadorEvento) objeto;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Integer idOrganizadorEvento = null;
        String sql = "INSERT INTO organizadorevento(idevento, idorganizador, idfuncao) VALUES (?, ?, ?) returning idorganizadorevento";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, oOrganizadorEvento.getEvento().getIdEvento());
            stmt.setInt(2, oOrganizadorEvento.getOrganizador().getIdOrganizador());
            stmt.setInt(3, oOrganizadorEvento.getFuncao().getIdFuncao());
            rs = stmt.executeQuery();
            conexao.commit();

            while (rs.next()) {
                idOrganizadorEvento = rs.getInt("idorganizadorevento");
            }
        } catch (SQLException e) {
            try {
                System.out.println("Problemas ao cadastrar OrganizadorEvento na DAO! Erro:" + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return idOrganizadorEvento;
    }

    public int verificaOrgEvento(int idorganizador, int idevento) {
        int idOrganizadorParametro = idorganizador;
        int idEventoParametro = idevento;
        int retorno = 0;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select coalesce(count(evento.idevento),0) as idevento from evento, organizadorevento where evento.idevento = organizadorevento.idevento"
                + " and organizadorevento.idorganizador = ? and organizadorevento.idevento = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idOrganizadorParametro);
            stmt.setInt(2, idEventoParametro);
            rs = stmt.executeQuery();

            while (rs.next()) {
                retorno = rs.getInt("idevento");
            }
            return retorno;
        } catch (SQLException ex) {
            System.out.println("Problemas no método verificaOrgEvento na OrganizadorEventoDAO " + ex.getMessage());
            return 0;
        }

    }

    public int alterar(Object objeto) {
        OrganizadorEvento oOrganizadorEvento = (OrganizadorEvento) objeto;
        PreparedStatement stmt = null;
        Integer idOrganizadorEvento = oOrganizadorEvento.getIdOrganizadorEvento();
        String sql = "update organizadorevento set idevento=?, idorganizador=?, idfuncao=? where idorganizadorevento=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, oOrganizadorEvento.getEvento().getIdEvento());
            stmt.setInt(2, oOrganizadorEvento.getOrganizador().getIdOrganizador());
            stmt.setInt(3, oOrganizadorEvento.getFuncao().getIdFuncao());
            stmt.setInt(4, oOrganizadorEvento.getIdOrganizadorEvento());
            stmt.execute();
            conexao.commit();
        } catch (SQLException e) {
            try {
                System.out.println("Problemas ao alterar OrganizadorEvento na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return idOrganizadorEvento;
    }

    public Boolean excluir(int numero) {
        int idOrganizadorEvento = numero;
        PreparedStatement stmt = null;
        String sql = "delete from organizadorevento where idorganizadorevento=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idOrganizadorEvento);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problema ao excluir organizadorEvento! Erro: " + ex.getMessage());
            try {
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro no rollback: " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    public Object carregar(int numero) {
        int idOrganizadorEvento = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        OrganizadorEvento oOrganizadorEvento = null;
        String sql = "select * from organizadorevento where idorganizadorevento=?";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idOrganizadorEvento);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Evento oEvento = null;
                try {
                    EventoDAO oEventoDAO = new EventoDAO();
                    int idEvento = rs.getInt("idevento");
                    oEvento = (Evento) oEventoDAO.carregar(idEvento);
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar evento no OrganizadorDAO! Erro:" + ex.getMessage());
                }

                Organizador oOrganizador = null;
                try {
                    OrganizadorDAO oOrganizadorDAO = new OrganizadorDAO();
                    int idOrganizador = rs.getInt("idorganizador");
                    oOrganizador = (Organizador) oOrganizadorDAO.carregar(idOrganizador);
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar organizador no OrganizadorDAO! Erro:" + ex.getMessage());
                }

                Funcao oFuncao = null;
                try {
                    FuncaoDAO oFuncaoDAO = new FuncaoDAO();
                    int idFuncao = rs.getInt("idfuncao");
                    oFuncao = (Funcao) oFuncaoDAO.carregar(idFuncao);
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar funcao no OrganizadorDAO! Erro:" + ex.getMessage());
                }

                oOrganizadorEvento = new OrganizadorEvento(
                        rs.getInt("idorganizadorevento"),
                        oEvento,
                        oOrganizador,
                        oFuncao);

            }
            return oOrganizadorEvento;
        } catch (SQLException ex) {
            System.out.println("Problemas ao carregar organizadorevento na DAO! Erro " + ex.getMessage());
            return null;
        }
    }

    public List<OrganizadorEvento> listarOrganizadorEvento(int numero) {
        List<OrganizadorEvento> resultado = new ArrayList<>();
        int idEventoParametro = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from organizadorevento where idevento = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idEventoParametro);
            rs = stmt.executeQuery();
            while (rs.next()) {

                OrganizadorEvento oOrganizadorEvento = new OrganizadorEvento();

                oOrganizadorEvento.setIdOrganizadorEvento(rs.getInt("idorganizadorevento"));

                EventoDAO oEventoDAO = null;
                try {
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Evento da listarOrganizadorEvento na OrganizadorEventoDAO " + ex.getMessage());
                    ex.printStackTrace();
                }
                oOrganizadorEvento.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

                OrganizadorDAO oOrganizadorDAO = null;
                try {
                    oOrganizadorDAO = new OrganizadorDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Organizador da listarOrganizadorEvento na OrganizadorEventoDAO " + ex.getMessage());
                    ex.printStackTrace();
                }
                oOrganizadorEvento.setOrganizador((Organizador) oOrganizadorDAO.carregar(rs.getInt("idorganizador")));

                FuncaoDAO oFuncaoDAO = null;
                try {
                    oFuncaoDAO = new FuncaoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Funcao da listarOrganizadorEvento na OrganizadorEventoDAO " + ex.getMessage());
                    ex.printStackTrace();
                }
                oOrganizadorEvento.setFuncao((Funcao) oFuncaoDAO.carregar(rs.getInt("idfuncao")));

                resultado.add(oOrganizadorEvento);
            }
        } catch (Exception e) {
            System.out.println("Problemas ao listarOrganizadorEvento OrganizadorEventoDAO na DAO! Erro:" + e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    }

}
