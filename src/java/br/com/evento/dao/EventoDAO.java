/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.CategoriaEvento;
import br.com.evento.model.Cidade;
import br.com.evento.model.Curso;
import br.com.evento.model.Evento;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author igorb
 */
public class EventoDAO implements GenericDAO {

   private Connection conexao;
    
    public EventoDAO() throws Exception{
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Evento oEvento = (Evento) objeto;
        Boolean retorno = false;
        if(oEvento.getIdEvento() == 0){
            retorno = this.inserir(oEvento);
        }else{
            retorno = this.alterar(oEvento);
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        Evento oEvento = (Evento) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO evento (nomeevento, valorevento, valoreventoprazo, datainicioevento, dataterminoevento, informacaoevento, situacaoevento, saldocaixa, "
                + "situacaocaixa, imagem, idcidade, idcurso, idcategoriaevento) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oEvento.getNomeEvento());
            stmt.setDouble(2, oEvento.getValorEvento());
            stmt.setDouble(3, oEvento.getValorEventoPrazo());
            stmt.setDate(4, new java.sql.Date(oEvento.getDataInicioEvento().getTime()));
            stmt.setDate(5, new java.sql.Date(oEvento.getDataTerminoEvento().getTime()));
            stmt.setString(6, oEvento.getInformacaoEvento());
            stmt.setString(7, oEvento.getSituacaoEvento());
            stmt.setDouble(8, oEvento.getSaldoCaixa());
            stmt.setString(9, oEvento.getSituacaoCaixa());
            stmt.setString(10, oEvento.getImagem());
            stmt.setInt(11, oEvento.getCidade().getIdCidade());
            stmt.setInt(12, oEvento.getCurso().getIdCurso());
            stmt.setInt(13, oEvento.getCategoriaEvento().getIdCategoriaEvento());

            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            try {
                System.out.println("Problemas ao cadastrar a Evento na DAO! Erro: " + ex.getMessage());
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
        Evento oEvento = (Evento) objeto;
        PreparedStatement stmt = null;
        String sql = "UPDATE evento set nomeevento=?, valorevento=?, valoreventoprazo=?, datainicioevento=?, dataterminoevento=?, informacaoevento=?, situacaoevento=?, "
                + "saldocaixa=?, situacaocaixa=?, imagem=?, idcidade=?, idcurso=?, idcategoriaevento=? WHERE idevento = ?";
        try {
            stmt = conexao.prepareStatement(sql);
             stmt.setString(1, oEvento.getNomeEvento());
            stmt.setDouble(2, oEvento.getValorEvento());
            stmt.setDouble(3, oEvento.getValorEventoPrazo());
            stmt.setDate(4, new java.sql.Date(oEvento.getDataInicioEvento().getTime()));
            stmt.setDate(5, new java.sql.Date(oEvento.getDataTerminoEvento().getTime()));
            stmt.setString(6, oEvento.getInformacaoEvento());
            stmt.setString(7, oEvento.getSituacaoEvento());
            stmt.setDouble(8, oEvento.getSaldoCaixa());
            stmt.setString(9, oEvento.getSituacaoCaixa());
            stmt.setString(10, oEvento.getImagem());
            stmt.setInt(11, oEvento.getCidade().getIdCidade());
            stmt.setInt(12, oEvento.getCurso().getIdCurso());
            stmt.setInt(13, oEvento.getCategoriaEvento().getIdCategoriaEvento());
            stmt.setInt(14, oEvento.getIdEvento());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            try {
                System.out.println("Problemas ao alterar a evento na DAO! Erro: " + ex.getMessage());
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
        int idEvento = numero;
        PreparedStatement stmt = null;
        String sql = "update evento set situacao =? where idevento=?";
        try {
            Evento oEvento = (Evento) this.carregar(idEvento);
            stmt = conexao.prepareStatement(sql);
            if (oEvento.getSituacaoEvento().equals("A")) {
                stmt.setString(1, "I");//se situacao atual for Ativa --> Inativar
            } else {
                stmt.setString(1, "A");//se situacao atual for Inativo --> Ativar
            }
            stmt.setInt(2, idEvento);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problemas ao excluir a Evento na DAO! Erro: " + ex.getMessage());
            try {
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro rollback " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idEvento = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Evento oEvento = null;
        String sql = "select * from evento where idevento=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idEvento);
            rs = stmt.executeQuery();
            while (rs.next()) {
                oEvento = new Evento();
                oEvento.setIdEvento(rs.getInt("idevento"));                        
                oEvento.setNomeEvento(rs.getString("nomeevento"));
                oEvento.setValorEvento(rs.getDouble("valorevento"));
                oEvento.setValorEventoPrazo(rs.getDouble("valorevento"));
                oEvento.setDataInicioEvento(rs.getDate("datainicioevento"));
                oEvento.setDataTerminoEvento(rs.getDate("dataterminoevento"));
                oEvento.setInformacaoEvento(rs.getString("informacaoevento"));
                oEvento.setSituacaoEvento(rs.getString("situacaoevento"));
                oEvento.setSaldoCaixa(rs.getDouble("saldocaixa"));
                oEvento.setSituacaoCaixa(rs.getString("situacaocaixa"));
                oEvento.setImagem(rs.getString("imagem"));  
                
                CidadeDAO oCidadeDAO = new CidadeDAO();
                oEvento.setCidade((Cidade) oCidadeDAO.carregar(rs.getInt("idcidade")));
                
                CursoDAO oCursoDAO = new CursoDAO();
                oEvento.setCurso((Curso) oCursoDAO.carregar(rs.getInt("idcurso")));
                
                CategoriaEventoDAO oCategoriaEventoDAO = new CategoriaEventoDAO();
                oEvento.setCategoriaEvento((CategoriaEvento) oCategoriaEventoDAO.carregar(rs.getInt("idcategoriaevento")));
                
                //Depois fazer o carregar de participantes e atividades daquele evento
      
            }
            return oEvento;
        } catch (Exception ex) {
            System.out.println("Problemas ao carregar Evento na DAO! Erro:" + ex.getMessage());
            return false;
        }
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from evento order by nomeevento";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Evento oEvento = new Evento();
                
               oEvento.setIdEvento(rs.getInt("idEvento"));                        
                oEvento.setNomeEvento(rs.getString("nomeEvento"));
                oEvento.setValorEvento(rs.getDouble("valorEvento"));
                oEvento.setValorEventoPrazo(rs.getDouble("valorEvento"));
                oEvento.setDataInicioEvento(rs.getDate("dataInicioEvento"));
                oEvento.setDataTerminoEvento(rs.getDate("dataTerminoEvento"));
                oEvento.setInformacaoEvento(rs.getString("informacaoEvento"));
                oEvento.setSituacaoEvento(rs.getString("situacaoEvento"));
                oEvento.setSaldoCaixa(rs.getDouble("saldoCaixa"));
                oEvento.setSituacaoCaixa(rs.getString("situacaoCaixa"));
                oEvento.setImagem(rs.getString("imagem"));  
        
                CidadeDAO oCidadeDAO = null;
                try {
                    oCidadeDAO = new CidadeDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar cidade " + ex.getMessage());
                    ex.printStackTrace();
                }
                oEvento.setCidade((Cidade) oCidadeDAO.carregar(rs.getInt("idcidade")));
                
                
                CursoDAO oCursoDAO = null;
                try {
                    oCursoDAO = new CursoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar curso " + ex.getMessage());
                    ex.printStackTrace();
                }              
                
                oEvento.setCurso((Curso) oCursoDAO.carregar(rs.getInt("idcurso")));     
               
                
                CategoriaEventoDAO oCategoriaEventoDAO = null;
                 try {
                    oCategoriaEventoDAO = new CategoriaEventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar curso " + ex.getMessage());
                    ex.printStackTrace();
                }   
                 
                oEvento.setCategoriaEvento((CategoriaEvento) oCategoriaEventoDAO.carregar(rs.getInt("idcategoriaevento")));   
                
                resultado.add(oEvento);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar Cidade na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }
    
    
     public List<Object> listarEventoOrganizador(int idOrganizador) {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select evento.* from evento, organizadorevento where evento.idevento = organizadorevento.idevento" +
            "and organizadorevento.idorganizador = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idOrganizador);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Evento oEvento = new Evento();
                
               oEvento.setIdEvento(rs.getInt("idevento"));                        
                oEvento.setNomeEvento(rs.getString("nomeevento"));
                oEvento.setValorEvento(rs.getDouble("valorevento"));
                oEvento.setValorEventoPrazo(rs.getDouble("valorevento"));
                oEvento.setDataInicioEvento(rs.getDate("datainicioevento"));
                oEvento.setDataTerminoEvento(rs.getDate("dataterminoevento"));
                oEvento.setInformacaoEvento(rs.getString("informacaoevento"));
                oEvento.setSituacaoEvento(rs.getString("situacaoevento"));
                oEvento.setSaldoCaixa(rs.getDouble("saldocaixa"));
                oEvento.setSituacaoCaixa(rs.getString("situacaocaixa"));
                oEvento.setImagem(rs.getString("imagem"));  
        
                CidadeDAO oCidadeDAO = null;
                try {
                    oCidadeDAO = new CidadeDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar cidade " + ex.getMessage());
                    ex.printStackTrace();
                }
                oEvento.setCidade((Cidade) oCidadeDAO.carregar(rs.getInt("idcidade")));
                
                
                CursoDAO oCursoDAO = null;
                try {
                    oCursoDAO = new CursoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar curso " + ex.getMessage());
                    ex.printStackTrace();
                }              
                
                oEvento.setCurso((Curso) oCursoDAO.carregar(rs.getInt("idcurso")));     
                
                //FALTA FAZER DA CATEGORIA EVENTO - ESPERAR A DAO FICAR PRONTA  
                
                
                resultado.add(oEvento);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listarEventoOrganizador Cidade na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }
     
    
    
    
}
