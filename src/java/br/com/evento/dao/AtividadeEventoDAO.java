/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.AtividadeEvento;
import br.com.evento.model.Evento;
import br.com.evento.model.TipoAtividade;
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
 * @author bruno
 */
public class AtividadeEventoDAO{

    private Connection conexao;

    public AtividadeEventoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    public int cadastrar(Object objeto) throws ParseException {
        AtividadeEvento oAtividadeEvento = (AtividadeEvento) objeto;
        int retorno = 0;
        if (oAtividadeEvento.getIdAtividadeEvento() == 0) {
            retorno = this.inserir(oAtividadeEvento);
        } else {
            retorno = this.alterar(oAtividadeEvento);
        }
        return retorno;
    }

    public int inserir(Object objeto) {
        AtividadeEvento oAtividadeEvento = (AtividadeEvento) objeto;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Integer idAtividadeEvento = null;
        String sql = "INSERT INTO atividadeevento(cargahoraria, nomeatividade, resumo, dataatividade, horaatividade, idevento, idtipoatividade) VALUES (?, ?, ?, ?, ?, ?, ?) returning idatividadeevento;";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, oAtividadeEvento.getCargaHoraria());
            stmt.setString(2, oAtividadeEvento.getNomeAtividade());
            stmt.setString(3, oAtividadeEvento.getResumo());
            stmt.setDate(4, new java.sql.Date(oAtividadeEvento.getDataAtividade().getTime()));
            stmt.setString(5, oAtividadeEvento.getHoraAtividade());
            stmt.setInt(6, oAtividadeEvento.getEvento().getIdEvento());
            stmt.setInt(7, oAtividadeEvento.getTipoAtividade().getIdTipoAtividade());
            rs = stmt.executeQuery();
            conexao.commit();
            
            while (rs.next()) {
                idAtividadeEvento = rs.getInt("idatividadeevento");
            }
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao cadastrar Atividade Evento na DAO! Erro:" + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback " + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return idAtividadeEvento;
    }
    
    public int alterar(Object objeto) {
        AtividadeEvento oAtividadeEvento = (AtividadeEvento) objeto;
        PreparedStatement stmt = null;
        Integer idAtividadeEvento = oAtividadeEvento.getIdAtividadeEvento();
        String sql = "UPDATE atividadeevento SET cargahoraria=?, nomeatividade=?, resumo=?, dataatividade=?, horaatividade=?, idevento=?, idtipoatividade=? WHERE idatividadeevento=?;";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, oAtividadeEvento.getCargaHoraria());
            stmt.setString(2, oAtividadeEvento.getNomeAtividade());
            stmt.setString(3, oAtividadeEvento.getResumo());
            stmt.setDate(4, new java.sql.Date(oAtividadeEvento.getDataAtividade().getTime()));
            stmt.setString(5, oAtividadeEvento.getHoraAtividade());
            stmt.setInt(6, oAtividadeEvento.getEvento().getIdEvento());
            stmt.setInt(7, oAtividadeEvento.getTipoAtividade().getIdTipoAtividade());  
            stmt.setInt(8, oAtividadeEvento.getIdAtividadeEvento());
            stmt.execute();
            conexao.commit();
        }catch (SQLException e){
            try{
                System.out.println("Problemas ao alterar AtividadeEvento na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("problemas ao executar rollback"+ex.getMessage());
                ex.printStackTrace();
            }
        }
        return idAtividadeEvento;
    }
    
    public Boolean excluir(int numero) {
        int idAtividadeEvento = numero;
        PreparedStatement stmt = null;
        String sql = "DELETE FROM atividadeevento WHERE idatividadeevento=?;";    
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idAtividadeEvento);
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception ex){
            System.out.println("Problema ao excluir AtividadeEvento na DAO! Erro: "+ex.getMessage());
            try{
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Erro no rollback: "+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }
    
    public Object carregar(int numero) {
        int idAtividadeEvento = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        AtividadeEvento oAtividadeEvento = null;
        String sql = "select * from atividadeevento where idatividadeevento=?";
        
        try{
            stmt=conexao.prepareStatement(sql);
            stmt.setInt(1, idAtividadeEvento);
            rs=stmt.executeQuery();
            
            while(rs.next()){                
                Evento oEvento = null;
                 try{
                    EventoDAO oEventoDAO = new EventoDAO();
                    int idEvento = rs.getInt("idevento");
                    oEvento = (Evento) oEventoDAO.carregar(idEvento);
                }catch(Exception ex){
                    System.out.println("Problemas ao carregar evento no AtividadeEventoDAO! Erro:"+ex.getMessage());
                }
                 
                 TipoAtividade oTipoAtividade = null;
                 try{
                    TipoAtividadeDAO oTipoAtividadeDAO = new TipoAtividadeDAO();
                    int idTipoAtividade = rs.getInt("idtipoatividade");
                    oTipoAtividade = (TipoAtividade) oTipoAtividadeDAO.carregar(idTipoAtividade);
                }catch(Exception ex){
                    System.out.println("Problemas ao carregar TipoAtividade no AtividadeEventoDAO! Erro:"+ex.getMessage());
                }
                
                 oAtividadeEvento = new AtividadeEvento(
                         rs.getInt("idatividadeevento"),
                         rs.getDouble("cargahoraria"),
                         rs.getString("nomeatividade"),
                         rs.getString("resumo"),
                         rs.getDate("dataatividade"),
                         rs.getString("horaatividade"),
                         oEvento,
                         oTipoAtividade);
            }
            return oAtividadeEvento;
        }catch(SQLException ex){
            System.out.println("Problemas ao carregar AtividadeEvento na DAO! Erro "+ex.getMessage());
            return null;
        }
    }
    
    public List<AtividadeEvento> listarAtividadeEvento(int numero) {
        List<AtividadeEvento> resultado = new ArrayList<>();
        int idEventoParametro = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from atividadeevento where idevento = ?";        
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idEventoParametro);
            rs=stmt.executeQuery();
            while(rs.next()){
                
                AtividadeEvento oAtividadeEvento = new AtividadeEvento();
                
                oAtividadeEvento.setIdAtividadeEvento(rs.getInt("idatividadeevento"));
                oAtividadeEvento.setCargaHoraria(rs.getDouble("cargahoraria"));
                oAtividadeEvento.setNomeAtividade(rs.getString("nomeatividade"));
                oAtividadeEvento.setResumo(rs.getString("resumo"));
                oAtividadeEvento.setDataAtividade(rs.getDate("dataatividade"));
                oAtividadeEvento.setHoraAtividade(rs.getString("horaatividade"));
                
                
                EventoDAO oEventoDAO = null;
                try {
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Evento da listarAtividadeEvento na AtividadeEventoDAO " + ex.getMessage());
                    ex.printStackTrace();
                }
                oAtividadeEvento.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));
                
                
                TipoAtividadeDAO oTipoAtividadeDAO = null;
                try {
                    oTipoAtividadeDAO = new TipoAtividadeDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar TipoAtividade da listarAtividadeEvento na AtividadeEventoDAO " + ex.getMessage());
                    ex.printStackTrace();
                }
                oAtividadeEvento.setTipoAtividade((TipoAtividade) oTipoAtividadeDAO.carregar(rs.getInt("idtipoatividade")));
                
                
                resultado.add(oAtividadeEvento);
            }
        } catch(Exception e){
            System.out.println("Problemas ao listarAtividadeEvento na AtividadeEventoDAO! Erro:"+e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    }

}
