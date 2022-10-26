/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Curso;
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
public class CursoDAO implements GenericDAO {

    private Connection conexao;
    
    public CursoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Curso oCurso = (Curso) objeto;
        boolean retorno = false;
        if (oCurso.getIdCurso() == 0){
            retorno = inserir(oCurso);
        }else{
            retorno = alterar(oCurso);
        }
        return retorno;        
    }


    @Override
    public Boolean inserir(Object objeto) {
        Curso oCurso = (Curso) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO curso(nomecurso, situacao, idinstituicao) VALUES (?, ?, ?)";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oCurso.getNomeCurso());
            stmt.setString(2,"A");
            stmt.setInt(3, oCurso.getInstituicao().getIdInstituicao());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception ex){
            try{
            System.out.println("Erro ao inserir curso na dao!"+ex.getMessage());
            ex.printStackTrace();
            conexao.rollback();
            }catch(SQLException e){
                System.out.println("Problema no rollback de curso na dao!"+e.getMessage());
                e.printStackTrace();              
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        Curso oCurso = (Curso) objeto;
        PreparedStatement stmt = null;
        String sql = "update curso set nomecurso=?, idinstituicao=? where idcurso = ?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oCurso.getNomeCurso());
            stmt.setInt(2, oCurso.getInstituicao().getIdInstituicao());
            stmt.setInt(3, oCurso.getIdCurso());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try{
                System.out.println("Problema ao alterar curso na dao! Erro: "+e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("Problema no rollback de curso ao alterar na dao! "+ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        } 
    }

    @Override
    public Boolean excluir(int numero) {
        int idCurso = numero;
        PreparedStatement stmt = null;
        String sql = "update curso set situacao=? where idcurso=?";
        try{
            Curso oCurso = (Curso) this.carregar(idCurso);
            stmt = conexao.prepareStatement(sql);
            if (oCurso.getSituacao().equals("A"))
                stmt.setString(1, "I");
            else
                stmt.setString(1, "A");
            
            stmt.setInt(2, idCurso);
            stmt.execute();
            conexao.commit();
            return true;
        }catch (Exception ex){
            System.out.println("Problema ao excluir curso na DAO! Erro: "+ex.getMessage());
            try{
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Erro no roll back ao excluir curso na DAO!"+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
       int idCurso = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Curso oCurso = null;
        String sql = "select * from curso where idcurso = ?";
        try{
            stmt= conexao.prepareStatement(sql);
            stmt.setInt(1, idCurso);
            rs = stmt.executeQuery();
            while(rs.next()){
              //busca a instituicao
              Instituicao oInstituicao = null;
              try{
                   InstituicaoDAO oInstituicaoDAO = new InstituicaoDAO();
                   oInstituicao = (Instituicao) oInstituicaoDAO.carregar(rs.getInt("idinstituicao"));
              }catch(Exception ex){
                  System.out.println("Problema ao carregar instituicao na cursoDAO Erro: "+ex.getMessage());
                  ex.printStackTrace();
              }
              
              oCurso = new Curso (rs.getInt("idcurso"), rs.getString("nomecurso"),rs.getString("situacao"), oInstituicao);
              
            }
        }catch(SQLException e){
            System.out.println("Problemas ao carregar curso na cursoDAO Erro: "+e.getMessage());
            e.printStackTrace();
        }
        return oCurso;        
    }

    @Override
    public List<Object> listar() {
         List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from curso order by nomecurso";
        
        try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
              //busca a instituicao
              Instituicao oInstituicao = null;
              try{
                  InstituicaoDAO oInstituicaoDAO = new InstituicaoDAO();
                  oInstituicao = (Instituicao) oInstituicaoDAO.carregar(rs.getInt("idinstituicao"));
              }catch(Exception ex){
                  System.out.println("Problema ao listar instituicao na cursodao Erro: "+ex.getMessage());
                  ex.printStackTrace();
              }
              
              Curso oCurso = new Curso (rs.getInt("idcurso"), rs.getString("nomecurso"),rs.getString("situacao"), oInstituicao);
               
              resultado.add(oCurso);
            }
        }catch(SQLException ex){
            System.out.println("Problema ao listar fornecedor na fornecedorDAO! Erro: "+ex.getMessage());
        }
        return resultado;
    }
    
    public List<Object> listarAtivos() {
         List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from curso where situacao = 'A'";
        
        try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()){
              //busca a instituicao
              Instituicao oInstituicao = null;
              try{
                  InstituicaoDAO oInstituicaoDAO = new InstituicaoDAO();
                  oInstituicao = (Instituicao) oInstituicaoDAO.carregar(rs.getInt("idinstituicao"));
              }catch(Exception ex){
                  System.out.println("Problema ao listar instituicao na cursodao Erro: "+ex.getMessage());
                  ex.printStackTrace();
              }
              
              Curso oCurso = new Curso (rs.getInt("idcurso"), rs.getString("nomecurso"),rs.getString("situacao"), oInstituicao);
               
              resultado.add(oCurso);
            }
        }catch(SQLException ex){
            System.out.println("Problema ao listar fornecedor na fornecedorDAO! Erro: "+ex.getMessage());
        }
        return resultado;
    }
    
}
