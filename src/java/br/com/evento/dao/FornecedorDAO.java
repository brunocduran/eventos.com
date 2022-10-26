/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Cidade;
import br.com.evento.model.Fornecedor;
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
 * @author igorb
 */
public class FornecedorDAO implements GenericDAO {
    
    private Connection conexao;
    
    public FornecedorDAO() throws Exception{      
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Boolean retorno = false;
        try{
            Fornecedor oFornecedor = (Fornecedor) objeto;
            if (oFornecedor.getIdFornecedor() == 0){//insercao
                //verifica se ja existe pessoa com esse cpf cadastrado
                int idFornecedor = this.verificarCpf(oFornecedor.getCpfCnpjPessoa());
                if (idFornecedor == 0){
                    retorno = this.inserir(oFornecedor);
                }else{
                    //se encontrou fornecedor com o cpf altera
                    oFornecedor.setIdFornecedor(idFornecedor);
                    retorno = this.alterar(oFornecedor);
                }               
            }else{
                retorno = this.alterar(oFornecedor);
            }
        }catch(Exception ex){
            System.out.println("Problema incluir fornecedor na dao! Erro: "+ex.getMessage());
        }
       return retorno;    
    }
    
    public int verificarCpf(String cpf) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int idFornecedor = 0;
        String sql = "select f.* from fornecedor f, pessoa p where f.idpessoa = p.idpessoa and p.cpfcnpjpessoa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpf);
            rs = stmt.executeQuery();
            while (rs.next()) {
                idFornecedor = rs.getInt("idfornecedor");
            }
            return idFornecedor;
        } catch (SQLException ex) {
            System.out.println("Problemas ao carregar pessoa! Erro: " + ex.getMessage());
            return idFornecedor;
        }
    }

    @Override
    public Boolean inserir(Object objeto) {
        Fornecedor oFornecedor = (Fornecedor) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO fornecedor (idpessoa, situacao, permitelogin, idtipotrabalho) VALUES (?, ?, ?, ?)";
        try{
            PessoaDAO oPessoaDAO = new PessoaDAO();
            //manda as informacoes para o cadastro de pessoa
            int idPessoa = oPessoaDAO.cadastrar(oFornecedor);
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idPessoa);
            stmt.setString(2, "A");
            stmt.setString(3, "N");
            stmt.setInt(4, oFornecedor.getTipoTrabalho().getIdTipoTrabalho());
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception e){
            try {
                System.out.println("Problemas ao cadastrar Fornecedor na DAO! Erro:" + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback na fornecedorDAo metodo inserir erro " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;          
        } 
    }

    @Override
    public Boolean alterar(Object objeto) {
        Fornecedor oFornecedor = (Fornecedor) objeto;
        PreparedStatement stmt = null;
        String sql = "update fornecedor set idtipotrabalho = ? where idfornecedor = ?";
        
        try{
            PessoaDAO oPessoaDAO = new PessoaDAO();
            oPessoaDAO.cadastrar(oFornecedor); //envia para classe PessoaDAO
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, oFornecedor.getTipoTrabalho().getIdTipoTrabalho());
            stmt.setInt(2, oFornecedor.getIdFornecedor());
            stmt.execute();
            conexao.commit();
            return true;            
        }catch (Exception e){
           try {
                System.out.println("Problema ao alterar fornecedor na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback fornecedor alterar dao erro " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;    
        }  
    }

    @Override
    public Boolean excluir(int numero) {
    PreparedStatement stmt = null;
        try {
            //carrega dados de fornecedor
            FornecedorDAO oFornecedorDAO = new FornecedorDAO();
            Fornecedor oFornecedor = (Fornecedor) oFornecedorDAO.carregar(numero);
            String situacao = "A";//verifica e troca a situação do fornecedor
            if (oFornecedor.getSituacaoFornecedor().equals(situacao)) {
                situacao = "I";
            } else {
                situacao = "A";
            }

            String sql = "UPDATE fornecedor SET situacao=? WHERE idfornecedor=?;";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, situacao);
            stmt.setInt(2, oFornecedor.getIdFornecedor());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao excluir Fornecedor na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback excluir fornecedor dao erro " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }  
    
    }

    @Override
    public Object carregar(int numero) {
        int idFornecedor = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Fornecedor oFornecedor = null;
        String sql = "select * from fornecedor f, pessoa p where f.idpessoa = p.idpessoa and f.idfornecedor = ?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idFornecedor);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                //busca a cidade
                Cidade oCidade = null;
                try{
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                }catch(Exception ex){
                    System.out.println("Problema ao carregar cidade da administradorDAo metodo carregar erro");
                }
                //busca o tipotrabalho
                TipoTrabalho oTipoTrabalho = null;
                try{
                    TipoTrabalhoDAO oTipoTrabalhoDAO = new TipoTrabalhoDAO();
                    oTipoTrabalho = (TipoTrabalho) oTipoTrabalhoDAO.carregar(rs.getInt("idtipotrabalho"));
                }catch(Exception ex){
                    System.out.println("Problema ao carregar tipotrabalho da administradorDAo metodo carregar erro");
                }
                
                oFornecedor = new Fornecedor(
                        rs.getInt("idfornecedor"), 
                        rs.getString("situacao"), 
                        rs.getString("permitelogin"), 
                        oTipoTrabalho, 
                        rs.getInt("idpessoa"), 
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade); 
            } 
        }catch(SQLException e) {
            System.out.println("Problemas ao carregar Fornecedor na DAO! Erro " + e.getMessage());
            e.printStackTrace();
        }
        return oFornecedor;
            
       }
    
   @Override
   public List<Object> listar() {
   List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select p.*, c.idfornecedor, c.situacao, c.permitelogin, c.idtipotrabalho from fornecedor c, pessoa p where c.idpessoa = p.idpessoa order by idpessoa";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
               //busca a cidade
                Cidade oCidade = null;
                try{
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                }catch(Exception ex){
                    System.out.println("Problema ao carregar cidade da administradorDAo metodo carregar erro");
                }
                //busca o tipotrabalho
                TipoTrabalho oTipoTrabalho = null;
                try{
                    TipoTrabalhoDAO oTipoTrabalhoDAO = new TipoTrabalhoDAO();
                    oTipoTrabalho = (TipoTrabalho) oTipoTrabalhoDAO.carregar(rs.getInt("idtipotrabalho"));
                }catch(Exception ex){
                    System.out.println("Problema ao carregar tipotrabalho da administradorDAo metodo carregar erro");
                }
                
                Fornecedor oFornecedor = new Fornecedor(
                        rs.getInt("idfornecedor"), 
                        rs.getString("situacao"), 
                        rs.getString("permitelogin"), 
                        oTipoTrabalho, 
                        rs.getInt("idpessoa"), 
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade); 
                resultado.add(oFornecedor);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar fornecedor na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }
   
      public List<Object> listarAtivos() {
   List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select p.*, c.idfornecedor, c.situacao, c.permitelogin, c.idtipotrabalho from fornecedor c, pessoa p where c.idpessoa = p.idpessoa and c.situacao = 'A' order by idpessoa";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
               //busca a cidade
                Cidade oCidade = null;
                try{
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                }catch(Exception ex){
                    System.out.println("Problema ao carregar cidade da fornecedorDAO metodo carregar erro");
                }
                //busca o tipotrabalho
                TipoTrabalho oTipoTrabalho = null;
                try{
                    TipoTrabalhoDAO oTipoTrabalhoDAO = new TipoTrabalhoDAO();
                    oTipoTrabalho = (TipoTrabalho) oTipoTrabalhoDAO.carregar(rs.getInt("idtipotrabalho"));
                }catch(Exception ex){
                    System.out.println("Problema ao carregar tipotrabalho da administradorDAo metodo carregar erro");
                }
                
                Fornecedor oFornecedor = new Fornecedor(
                        rs.getInt("idfornecedor"), 
                        rs.getString("situacao"), 
                        rs.getString("permitelogin"), 
                        oTipoTrabalho, 
                        rs.getInt("idpessoa"), 
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade); 
                resultado.add(oFornecedor);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar fornecedor na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }


}
    

