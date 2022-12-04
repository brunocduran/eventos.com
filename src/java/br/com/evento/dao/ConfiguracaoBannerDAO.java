/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.dao.EventoDAO;
import br.com.evento.dao.GenericDAO;
import br.com.evento.utils.SingleConnection;
import br.com.evento.model.ConfiguracaoBanner;
import br.com.evento.model.Evento;
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
public class ConfiguracaoBannerDAO implements GenericDAO {

    private Connection conexao;

    public ConfiguracaoBannerDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        ConfiguracaoBanner oConfiguracaoBanner = (ConfiguracaoBanner) objeto;
        Boolean retorno = false;
        if (oConfiguracaoBanner.getIdConfiguracaoBanner() == 0) {
            retorno = this.inserir(oConfiguracaoBanner);
        } else {
            retorno = this.alterar(oConfiguracaoBanner);
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        ConfiguracaoBanner oConfiguracaoBanner = (ConfiguracaoBanner) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO configuracaobanner (titulobanner, msgbanner, imagem, tipobanner, datainicial, datafinal, idevento) "
                + "values (?,?,?,?,?,?,?)";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oConfiguracaoBanner.getTituloBanner());
            stmt.setString(2, oConfiguracaoBanner.getMsgBanner());
            stmt.setString(3, oConfiguracaoBanner.getImagem());
            stmt.setString(4, oConfiguracaoBanner.getTipoBanner());
            stmt.setDate(5, new java.sql.Date(oConfiguracaoBanner.getDataInicial().getTime()));
            stmt.setDate(6, new java.sql.Date(oConfiguracaoBanner.getDataFinal().getTime()));
            stmt.setInt(7, oConfiguracaoBanner.getEvento().getIdEvento());

            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            try {
                System.out.println("Problemas ao cadastrar a Configuracao do Banner na DAO! Erro: " + ex.getMessage());
                ex.printStackTrace();
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public Boolean alterar(Object objeto) {
        ConfiguracaoBanner oConfiguracaoBanner = (ConfiguracaoBanner) objeto;
        PreparedStatement stmt = null;
        String sql = "update configuracaobanner set titulobanner=?, msgbanner=?, imagem=?, tipobanner=?, datainicial=?, datafinal=?,"
                + "idevento=? where idconfiguracaobanner = ? ";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oConfiguracaoBanner.getTituloBanner());
            stmt.setString(2, oConfiguracaoBanner.getMsgBanner());
            stmt.setString(3, oConfiguracaoBanner.getImagem());
            stmt.setString(4, oConfiguracaoBanner.getTipoBanner());
            stmt.setDate(5, new java.sql.Date(oConfiguracaoBanner.getDataInicial().getTime()));
            stmt.setDate(6, new java.sql.Date(oConfiguracaoBanner.getDataFinal().getTime()));
            stmt.setInt(7, oConfiguracaoBanner.getEvento().getIdEvento());
            stmt.setInt(8, oConfiguracaoBanner.getIdConfiguracaoBanner());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            try {
                System.out.println("Problemas ao alterar a Configuracao do Banner na DAO! Erro: " + ex.getMessage());
                ex.printStackTrace();
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro:" + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean excluir(int numero) {
        int idConfiguracaoBanner = numero;
        PreparedStatement stmt = null;

        String sql = "delete from configuracaobanner where idconfiguracaobanner=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idConfiguracaoBanner);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problemas ao excluir a Configuracao do Banner! Erro: " + ex.getMessage());

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
        int idConfiguracaoBanner = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ConfiguracaoBanner oConfiguracaoBanner = null;
        String sql = "select * from configuracaobanner where idconfiguracaobanner=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idConfiguracaoBanner);
            rs = stmt.executeQuery();
            while (rs.next()) {
                oConfiguracaoBanner = new ConfiguracaoBanner();
                oConfiguracaoBanner.setIdConfiguracaoBanner(rs.getInt("idconfiguracaobanner"));
                oConfiguracaoBanner.setTituloBanner(rs.getString("titulobanner"));
                oConfiguracaoBanner.setMsgBanner(rs.getString("msgbanner"));
                oConfiguracaoBanner.setImagem(rs.getString("imagem"));
                oConfiguracaoBanner.setTipoBanner(rs.getString("tipobanner"));
                oConfiguracaoBanner.setDataInicial(rs.getDate("datainicial"));
                oConfiguracaoBanner.setDataFinal(rs.getDate("datafinal"));

                EventoDAO oEventoDAO = new EventoDAO();
                oConfiguracaoBanner.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

            }
            return oConfiguracaoBanner;
        } catch (Exception ex) {
            System.out.println("Problemas ao carregar Configuracao do Banner na DAO! Erro:" + ex.getMessage());
            return false;
        }
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from configuracaobanner order by titulobanner";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                ConfiguracaoBanner oConfiguracaoBanner = new ConfiguracaoBanner();

                oConfiguracaoBanner.setIdConfiguracaoBanner(rs.getInt("idconfiguracaobanner"));
                oConfiguracaoBanner.setTituloBanner(rs.getString("titulobanner"));
                oConfiguracaoBanner.setMsgBanner(rs.getString("msgbanner"));
                oConfiguracaoBanner.setImagem(rs.getString("imagem"));
                oConfiguracaoBanner.setTipoBanner(rs.getString("tipobanner"));
                oConfiguracaoBanner.setDataInicial(rs.getDate("datainicial"));
                oConfiguracaoBanner.setDataFinal(rs.getDate("datafinal"));

                EventoDAO oEventoDAO = null;
                try {
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar evento " + ex.getMessage());
                    ex.printStackTrace();
                }
                oConfiguracaoBanner.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

                resultado.add(oConfiguracaoBanner);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar configuracao do banner na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

    public List<Object> listarHome(String tipoBanner) {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from configuracaobanner where tipobanner = ? and configuracaobanner.datafinal >= cast('TODAY' as date)";

        if (tipoBanner.equalsIgnoreCase("S") || tipoBanner.equalsIgnoreCase("I")) {
            sql += " order by configuracaobanner.datainicial limit 1";
        }
        else{
            sql += " order by configuracaobanner.datainicial";     
        }
        
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, tipoBanner);
            rs = stmt.executeQuery();

            while (rs.next()) {
                ConfiguracaoBanner oConfiguracaoBanner = new ConfiguracaoBanner();

                oConfiguracaoBanner.setIdConfiguracaoBanner(rs.getInt("idconfiguracaobanner"));
                oConfiguracaoBanner.setTituloBanner(rs.getString("titulobanner"));
                oConfiguracaoBanner.setMsgBanner(rs.getString("msgbanner"));
                oConfiguracaoBanner.setImagem(rs.getString("imagem"));
                oConfiguracaoBanner.setTipoBanner(rs.getString("tipobanner"));
                oConfiguracaoBanner.setDataInicial(rs.getDate("datainicial"));
                oConfiguracaoBanner.setDataFinal(rs.getDate("datafinal"));

                EventoDAO oEventoDAO = null;
                try {
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar evento " + ex.getMessage());
                    ex.printStackTrace();
                }
                oConfiguracaoBanner.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

                resultado.add(oConfiguracaoBanner);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar configuracao do banner na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

    public int verificaCadastroBanner(Date datainicial, Date datafinal, String tipoBanner, int idConfiguracaoBanner) {
        //int idOrganizadorParametro = idorganizador;
        //int idEventoParametro = idevento;
        int retorno = 0;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        /*String sql = "select coalesce(count(configuracaobanner.idconfiguracaobanner),0) as idconfiguracaobanner from configuracaobanner "
                + "where ((configuracaobanner.datainicial between ? and ?) or"
                + "(configuracaobanner.datafinal between ? and ?))"
                + "and configuracaobanner.tipobanner = ?";*/
        
        String sql = "select coalesce(count(configuracaobanner.idconfiguracaobanner),0) as idconfiguracaobanner from configuracaobanner "
                + "where ((? between configuracaobanner.datainicial and configuracaobanner.datafinal) or"
                + "(? between configuracaobanner.datainicial and configuracaobanner.datafinal)"
                + "or ((configuracaobanner.datainicial between ? and ?)"
                + " or (configuracaobanner.datafinal between ? and ?))"
                + ")"
                + "and configuracaobanner.tipobanner = ?";

        if (idConfiguracaoBanner > 0) {
            sql = sql + " and configuracaobanner.idconfiguracaobanner <> ?";
        }

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDate(1, datainicial);
            stmt.setDate(2, datafinal);
            stmt.setDate(3, datainicial);
            stmt.setDate(4, datafinal);
            stmt.setDate(5, datainicial);
            stmt.setDate(6, datafinal);
            stmt.setString(7, tipoBanner);
           // stmt.setDate(3, datainicial);
            //stmt.setDate(4, datafinal);
            //stmt.setString(5, tipoBanner);
            
            if (idConfiguracaoBanner > 0) {
                stmt.setInt(8, idConfiguracaoBanner);
            }

            rs = stmt.executeQuery();

            while (rs.next()) {
                retorno = rs.getInt("idconfiguracaobanner");
            }
            return retorno;
        } catch (SQLException ex) {
            System.out.println("Problemas no método verificaCadastroBanner na ConfiguracaoBannerDAO " + ex.getMessage());
            return 0;
        }

    }
    
     public int[] configuracoesBanner(String tipoBanner) {
        int retorno[] = new int[2];
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select cast(min(configuracaobanner.idconfiguracaobanner) as integer) as min_idconfiguracaobanner,"
                + "cast(count(configuracaobanner.idconfiguracaobanner) as integer) as qtd_configuracaobanner "
                + "from configuracaobanner where tipobanner = ? and configuracaobanner.datafinal >= cast('TODAY' as date)";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, tipoBanner);
            rs = stmt.executeQuery();

            while (rs.next()) {
                retorno[0] = rs.getInt("min_idconfiguracaobanner");
                retorno[1] = rs.getInt("qtd_configuracaobanner");
               
            }
        } catch (SQLException ex) {
            retorno[0] = 0;
            retorno[1] = 0;
            System.out.println("Problemas ao listar configuracao do listarHomeMinimo na DAO! Erro: " + ex.getMessage());
        }
        return retorno;
    }

}
