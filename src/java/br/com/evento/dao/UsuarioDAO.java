/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.util.List;
import br.com.evento.model.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author igorb
 */
public class UsuarioDAO {
    private Connection conexao;
    
    public UsuarioDAO() throws Exception{
        conexao = SingleConnection.getConnection();
    }
    
    /*CRIAR PRIMERO O LISTAR DE ACORDO COM O USUARIO E SENHA PRA BUSCAR OS TIPOS*/
    public List<Usuario> listar (String login, String senha){
        List<Usuario> lstUsuarios = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from usuario u where u.login = ? and u.senha = ?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, login);
            stmt.setString(2, senha);
            rs = stmt.executeQuery();
            while(rs.next()){
                Usuario oUsuario = new Usuario(
                        rs.getInt("idpessoa"), 
                        rs.getInt("id"), 
                        rs.getString("nomerazaopessoa"), 
                        rs.getString("cpfcnpjpessoa"), 
                        rs.getString("login"), 
                        rs.getString("senha"), 
                        rs.getString("tipo")
                );
                lstUsuarios.add(oUsuario);
            }
            
        }catch(SQLException ex){
        System.out.println("Problema ao listar usuario na DAO! Erro: "+ex.getMessage());
        }
        return lstUsuarios;
    }
    
    public Usuario logar(String login, String senha, String tipo){
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario oUsuario = null;
        String sql = "";
        if (tipo.equals("")){
            sql = "select * from usuario u where u.login = ? and u.senha = ?";            
        }else{
            sql = "select * from usuario u where u.login = ? and u.senha = ? and u.tipo = ?";            
        }
            
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, login);
            stmt.setString(2, senha);
            if (!tipo.equals("")){
                stmt.setString(3, tipo);
            }
            rs = stmt.executeQuery();
            
            while(rs.next()){
                oUsuario = new Usuario( rs.getInt("idpessoa"), 
                        rs.getInt("id"), 
                        rs.getString("nomerazaopessoa"), 
                        rs.getString("cpfcnpjpessoa"), 
                        rs.getString("login"), 
                        rs.getString("senha"), 
                        rs.getString("tipo"));
            }
            return oUsuario;
        }catch(SQLException ex){
            System.out.println("Problema ao carregar usuario  na usuarioDAO! Erro: "+ex.getMessage());
            ex.printStackTrace();
            return null;
        }
    }
    
    
    
    
}
