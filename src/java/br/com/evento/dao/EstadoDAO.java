/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Estado;
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
public class EstadoDAO implements GenericDAO{
    
    private Connection conexao;
    
    public EstadoDAO() throws Exception{
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Estado oEstado = (Estado) objeto;
        Boolean retorno = false;
        if(oEstado.getIdEstado() == 0){
            retorno = this.inserir(oEstado);
        }else{
            retorno = this.alterar(oEstado);
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        Estado oEstado = (Estado) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into estado(nomeestado,siglaestado,situacao) values(?,?,?);";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oEstado.getNomeEstado());
            stmt.setString(2, oEstado.getSiglaEstado());
            stmt.setString(3, "A");
            stmt.execute();
            conexao.commit();
            return true;
            
        } catch(Exception e){
            try{
                System.out.println("Problemas ao cadastrar a Estado na DAO! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch(SQLException ex){
                System.out.println("Problemas ao executar rollback: "+e.getMessage());
                ex.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public Boolean alterar(Object objeto) {
        Estado oEstado = (Estado) objeto;
        PreparedStatement stmt = null;
        String sql = "update estado set nomeestado=?, siglaestado=?, situacao=? where idEstado=?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oEstado.getNomeEstado());
            stmt.setString(2, oEstado.getSiglaEstado());
            stmt.setString(3, oEstado.getSituacao());
            stmt.setInt(4, oEstado.getIdEstado());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problemas ao alterar Estado na DAO! Erro:"+ e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problemas ao executar rollback"+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean excluir(int numero) {
        int idEstado = numero;
        PreparedStatement stmt = null;
        String sql = "update estado set situacao =? where idestado=?";
        try{
            Estado oEstado = (Estado) this.carregar(idEstado);
            stmt = conexao.prepareStatement(sql);
            if(oEstado.getSituacao().equals("A"))
                stmt.setString(1, "I");//se situacao atual for Ativa --> Inativar
            else stmt.setString(1, "A");//se situacao atual for Inativo --> Ativar
            stmt.setInt(2, idEstado);
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception ex){
            System.out.println("Problemas ao excluir a Estado na Dao! Erro: "+ex.getMessage());
            try{
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Erro rollback "+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idEstado = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Estado oEstado = null;
        String sql = "select * from estado where idestado=?";
        
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idEstado);
            rs=stmt.executeQuery();
            while(rs.next()){
                oEstado = new Estado();
                oEstado.setIdEstado(rs.getInt("idestado"));
                oEstado.setNomeEstado(rs.getString("nomeestado"));
                oEstado.setSiglaEstado(rs.getString("siglaestado"));
                oEstado.setSituacao(rs.getString("situacao"));
            }
            return oEstado;
        } catch(Exception e){
            System.out.println("Problemas ao carregar Estado na DAO! Erro:"+e.getMessage());
            return false;
        }
    }

    @Override
    public List<Object> listar() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        Estado oEstado = null;
        String sql = "select * from estado order by nomeestado";
        
        try {
            stmt = conexao.prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){
                oEstado = new Estado();
                oEstado.setIdEstado(rs.getInt("idEstado"));
                oEstado.setNomeEstado(rs.getString("nomeestado"));
                oEstado.setSiglaEstado(rs.getString("siglaestado"));
                oEstado.setSituacao(rs.getString("situacao"));
                resultado.add(oEstado);
            }
        } catch(Exception e){
            System.out.println("Problemas ao lista Estado na DAO! Erro:"+e.getMessage());
            e.printStackTrace();
        }
        return resultado;
    }
    
}
