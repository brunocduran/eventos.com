/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.CategoriaEvento;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author johat
 */
public class CategoriaEventoDAO implements GenericDAO{

    private Connection conexao;
    public CategoriaEventoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }
    
    @Override
    public Boolean cadastrar(Object objeto) {
        CategoriaEvento oCategoriaEvento = (CategoriaEvento) objeto;
        boolean retorno = false;
        if (oCategoriaEvento.getIdCategoriaEvento()== 0){
            retorno = inserir(oCategoriaEvento);
        }else{
            retorno = alterar(oCategoriaEvento);
        }
        return retorno; 
    }

    @Override
    public Boolean inserir(Object objeto) {
         CategoriaEvento oCategoriaEvento = (CategoriaEvento) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into categoriaevento (nome, situacao) values (?,?)";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oCategoriaEvento.getNome());
            stmt.setString(2, "A");

            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao cadastrar Categoria de Evento na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback de Categoria de Evento ao cadastrar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        CategoriaEvento oCategoriaEvento = (CategoriaEvento) objeto;
        PreparedStatement stmt = null;
        String sql = "update categoriaevento set nome=? ,situacao=? where ididcategoriaevento=?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oCategoriaEvento.getNome());
            stmt.setString(2, oCategoriaEvento.getSituacao());
            stmt.setInt(3, oCategoriaEvento.getIdCategoriaEvento());
            
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao alterar Categoria de Evento na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback de Categoria de Evento ao alterar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean excluir(int numero) {
        int idCategoriaEvento = numero;
        PreparedStatement stmt = null;
        String sql = "update instituicao set situacao=? where idinstituicao=?";
        try{
            CategoriaEvento oCategoriaEvento = (CategoriaEvento) this.carregar(idCategoriaEvento);
            stmt = conexao.prepareStatement(sql);
            if (oCategoriaEvento.getSituacao().equals("A"))
                stmt.setString(1, "I");
            else
                stmt.setString(1, "A");
            
            stmt.setInt(2, idCategoriaEvento);
            stmt.execute();
            conexao.commit();
            return true;
        }catch (Exception ex){
            System.out.println("Problema ao excluir Categoria de Evento na DAO! Erro: "+ex.getMessage());
            try{
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Erro no roll back ao excluir Categoria de Evento na DAO!"+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idCategoriaEvento = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        CategoriaEvento oCategoriaEvento = null;
        String sql = "select * from categoriaevento where ididcategoriaevento = ?";      
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idCategoriaEvento);
            rs = stmt.executeQuery();
            while(rs.next()){
                oCategoriaEvento = new CategoriaEvento();
                oCategoriaEvento.setIdCategoriaEvento(rs.getInt("ididcategoriaevento"));
                oCategoriaEvento.setNome(rs.getString("nome"));
                oCategoriaEvento.setSituacao(rs.getString("situacao"));
                
            }
        }catch (Exception e){
            System.out.println("Problema ao carregar Categoria de Evento na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return oCategoriaEvento;
    }

    @Override
    public List<Object> listar() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        CategoriaEvento oCategoriaEvento = null;
        String sql = "select * from categoriaevento";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                    oCategoriaEvento =  new CategoriaEvento();
                    oCategoriaEvento.setIdCategoriaEvento(rs.getInt("idcategoriaevento"));
                    oCategoriaEvento.setNome(rs.getString("nome"));
                    oCategoriaEvento.setSituacao(rs.getString("situacao"));
                    resultado.add(oCategoriaEvento);
                    
            }
        }catch (Exception e){
            System.out.println("Problema ao listar Categoria de Evento na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    }
    
    
    public List<Object> listarAtivos() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        CategoriaEvento oCategoriaEvento = null;
        String sql = "select * from categoriaevento where situacao = 'A'";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                    oCategoriaEvento =  new CategoriaEvento();
                    oCategoriaEvento.setIdCategoriaEvento(rs.getInt("idcategoriaevento"));
                    oCategoriaEvento.setNome(rs.getString("nome"));
                    oCategoriaEvento.setSituacao(rs.getString("situacao"));
                    resultado.add(oCategoriaEvento);
                    
            }
        }catch (Exception e){
            System.out.println("Problema ao listar Categoria de Evento na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    }
    
}
