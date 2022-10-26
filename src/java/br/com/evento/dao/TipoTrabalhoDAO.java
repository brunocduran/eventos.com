/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.TipoTrabalho;
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
public class TipoTrabalhoDAO implements GenericDAO{
    
    private Connection conexao;
    
    public TipoTrabalhoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        TipoTrabalho oTipoTrabalho = (TipoTrabalho) objeto;
        boolean retorno = false;
        if (oTipoTrabalho.getIdTipoTrabalho() == 0){
            retorno = inserir(oTipoTrabalho);
        }else{
            retorno = alterar(oTipoTrabalho);
        }
        return retorno;        
    }

    @Override
    public Boolean inserir(Object objeto) {
        TipoTrabalho oTipoTrabalho = (TipoTrabalho) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into TipoTrabalho(descricao, situacao) values (?,?)";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oTipoTrabalho.getDescricao());
            stmt.setString(2, "A");
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao cadastrar o Tipo do Trabalho na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback do Tipo do trabalho ao cadastrar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }

    }

    @Override
    public Boolean alterar(Object objeto) {
        TipoTrabalho oTipoTrabalho = (TipoTrabalho) objeto;
        PreparedStatement stmt = null;
        String sql = "update TipoTrabalho set descricao=?, situacao=? where idTipoTrabalho=?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oTipoTrabalho.getDescricao());
            stmt.setString(2, oTipoTrabalho.getSituacao());
            stmt.setInt(3, oTipoTrabalho.getIdTipoTrabalho());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao alterar o Tipo do Trabalho na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback di Tipo do Trabalho ao alterar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
     public Boolean excluir(int numero) {
        int idTipoTrabalho = numero;
        PreparedStatement stmt = null;
        String sql = "update TipoTrabalho set situacao=? where idTipoTrabalho=?";
        try{
            TipoTrabalho oTipoTrabalho = (TipoTrabalho) this.carregar(idTipoTrabalho);
            stmt = conexao.prepareStatement(sql);
            if (oTipoTrabalho.getSituacao().equals("A"))
                stmt.setString(1, "I");
            else
                stmt.setString(1, "A");
            
            stmt.setInt(2, idTipoTrabalho);
            stmt.execute();
            conexao.commit();
            return true;
        }catch (Exception ex){
            System.out.println("Problema ao excluir Tipo do Trabalho na DAO! Erro: "+ex.getMessage());
            try{
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Erro no roll back ao excluir o Tipo do Trabalho na DAO!"+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
        
    }

    @Override
    public Object carregar(int numero) {
        int idTipoTrabalho = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        TipoTrabalho oTipoTrabalho = null;
        String sql = "select * from TipoTrabalho where idTipoTrabalho = ?";
        
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idTipoTrabalho);
            rs = stmt.executeQuery();
            while(rs.next()){
                oTipoTrabalho = new TipoTrabalho();
                oTipoTrabalho.setIdTipoTrabalho(rs.getInt("idTipoTrabalho"));
                oTipoTrabalho.setDescricao(rs.getString("descricao"));
                oTipoTrabalho.setSituacao(rs.getString("situacao"));
                
            }
        }catch (Exception e){
            System.out.println("Problema ao carregar o Tipo do Trabalho na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return oTipoTrabalho;
    }

    @Override
    public List<Object> listar() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        TipoTrabalho oTipoTrabalho = null;
        String sql = "select * from tipotrabalho";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                oTipoTrabalho = new TipoTrabalho();
                oTipoTrabalho.setIdTipoTrabalho(rs.getInt("idTipoTrabalho"));
                oTipoTrabalho.setDescricao(rs.getString("descricao"));
                oTipoTrabalho.setSituacao(rs.getString("situacao"));
                resultado.add(oTipoTrabalho);
                
            }
        }catch (Exception e){
            System.out.println("Problema ao listar o Tipo do Trabalho na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    
    }
    
}
