/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Instituicao;
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
public class InstituicaoDAO implements GenericDAO {
    
       private Connection conexao;    
    public InstituicaoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Instituicao oInstituicao = (Instituicao) objeto;
        boolean retorno = false;
        if (oInstituicao.getIdInstituicao() == 0){
            retorno = inserir(oInstituicao);
        }else{
            retorno = alterar(oInstituicao);
        }
        return retorno;        
    }

    @Override
    public Boolean inserir(Object objeto) {
        Instituicao oInstituicao = (Instituicao) objeto;
        PreparedStatement stmt = null;
        String sql = "insert into instituicao (nomeInstituicao, cnpj, situacao,imagem) values (?,?,?,?)";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oInstituicao.getNomeInstituicao());
            stmt.setString(2, oInstituicao.getCnpj());
            stmt.setString(3, "A");
            stmt.setString(4, oInstituicao.getImagem());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao cadastrar instituicao na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback de instituicao ao cadastrar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        Instituicao oInstuicao = (Instituicao) objeto;
        PreparedStatement stmt = null;
        String sql = "update instituicao set nomeInstituicao=?, cnpj=?, situacao=?, imagem=? where idInstituicao = ?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oInstuicao.getNomeInstituicao());
            stmt.setString(2, oInstuicao.getCnpj());
            stmt.setString(3, oInstuicao.getSituacao());
            stmt.setString(4, oInstuicao.getImagem());
            stmt.setInt(5, oInstuicao.getIdInstituicao());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao alterar instituicao na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback de instituicao ao alterar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        } 
    }

    @Override
    public Boolean excluir(int numero) {
        int idInstituicao = numero;
        PreparedStatement stmt = null;
        String sql = "update instituicao set situacao=? where idinstituicao=?";
        try{
            Instituicao oInstituicao = (Instituicao) this.carregar(idInstituicao);
            stmt = conexao.prepareStatement(sql);
            if (oInstituicao.getSituacao().equals("A"))
                stmt.setString(1, "I");
            else
                stmt.setString(1, "A");
            
            stmt.setInt(2, idInstituicao);
            stmt.execute();
            conexao.commit();
            return true;
        }catch (Exception ex){
            System.out.println("Problema ao excluir instituicao na DAO! Erro: "+ex.getMessage());
            try{
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Erro no roll back ao excluir instituicao na DAO!"+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idInstituicao = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Instituicao oInstituicao = null;
        String sql = "select * from instituicao where idinstituicao = ?";      
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idInstituicao);
            rs = stmt.executeQuery();
            while(rs.next()){
                oInstituicao = new Instituicao();
                oInstituicao.setIdInstituicao(rs.getInt("idinstituicao"));
                oInstituicao.setNomeInstituicao(rs.getString("nomeinstituicao"));
                oInstituicao.setCnpj(rs.getString("cnpj"));
                oInstituicao.setSituacao(rs.getString("situacao"));  
                oInstituicao.setImagem(rs.getString("imagem"));
            }
        }catch (Exception e){
            System.out.println("Problema ao carregar situacao na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return oInstituicao;  
    }

    @Override
    public List<Object> listar() {
     PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        Instituicao oInstituicao = null;
        String sql = "select * from instituicao";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                oInstituicao = new Instituicao();
                oInstituicao.setIdInstituicao(rs.getInt("idinstituicao"));
                oInstituicao.setNomeInstituicao(rs.getString("nomeinstituicao"));
                oInstituicao.setCnpj(rs.getString("cnpj"));
                oInstituicao.setSituacao(rs.getString("situacao")); 
                oInstituicao.setImagem(rs.getString("imagem"));
                resultado.add(oInstituicao);             
            }
        }catch (Exception e){
            System.out.println("Problema ao listar instituicao na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return resultado; 
    }
    
    public List<Object> listarCarrossel() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        Instituicao oInstituicao = null;
        String sql = "select * from instituicao where situacao='A' and coalesce(imagem,'') <> 'http://localhost:8080/Evento/InstituicaoListar'"; /*lista somente as ativas no carrossel da pagina inicial*/
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                oInstituicao = new Instituicao();
                oInstituicao.setIdInstituicao(rs.getInt("idinstituicao"));
                oInstituicao.setNomeInstituicao(rs.getString("nomeinstituicao"));
                oInstituicao.setCnpj(rs.getString("cnpj"));
                oInstituicao.setSituacao(rs.getString("situacao")); 
                oInstituicao.setImagem(rs.getString("imagem"));
                resultado.add(oInstituicao);             
            }
        }catch (Exception e){
            System.out.println("Problema ao listar instituicao na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return resultado; 
    }
    
    public List<Object> listarAtivos() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        Instituicao oInstituicao = null;
        String sql = "select * from instituicao where situacao = 'A'";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
                oInstituicao = new Instituicao();
                oInstituicao.setIdInstituicao(rs.getInt("idinstituicao"));
                oInstituicao.setNomeInstituicao(rs.getString("nomeinstituicao"));
                oInstituicao.setCnpj(rs.getString("cnpj"));
                oInstituicao.setSituacao(rs.getString("situacao")); 
                oInstituicao.setImagem(rs.getString("imagem"));
                resultado.add(oInstituicao);             
            }
        }catch (Exception e){
            System.out.println("Problema ao listar instituicao na dao! Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return resultado; 
    }
    
    
}
