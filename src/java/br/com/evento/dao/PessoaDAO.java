/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.dao;

import br.com.evento.model.Cidade;
import br.com.evento.model.Pessoa;
import br.com.evento.utils.Conversao;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;

/**
 *
 * @author bruno
 */
public class PessoaDAO {

    private Connection conexao;

    public PessoaDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    public int cadastrar(Object objeto) throws ParseException {
        Pessoa oPessoa = (Pessoa) objeto;
        int retorno = 0;
        if (oPessoa.getIdPessoa() == 0) {
            Pessoa objPessoa = this.carregarCpf(oPessoa.getCpfCnpjPessoa());
            if (objPessoa.getIdPessoa() == 0) {
                retorno = this.inserir(oPessoa);
            } else {
                retorno = objPessoa.getIdPessoa();
            }
        } else {
            retorno = this.alterar(oPessoa);
        }
        return retorno;
    }

    public int inserir(Object objeto) {
        Pessoa oPessoa = (Pessoa) objeto;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Integer idPessoa = null;
        String sql = "INSERT INTO pessoa(nomerazaopessoa, rgiepessoa, cpfcnpjpessoa, datanascfundpessoa, telefonepessoa, logradouropessoa, numlogradouropessoa, bairropessoa, ceppessoa, emailpessoa, login, senha, idcidade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) returning idPessoa;";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oPessoa.getNomeRazaoPessoa());
            stmt.setString(2, oPessoa.getRgIePessoa());
            stmt.setString(3, oPessoa.getCpfCnpjPessoa());
            stmt.setDate(4, new java.sql.Date(oPessoa.getDataNascFundPessoa().getTime()));
            stmt.setString(5, oPessoa.getTelefonePessoa());
            stmt.setString(6, oPessoa.getLogradouroPessoa());
            stmt.setString(7, oPessoa.getNumLogradouroPessoa());
            stmt.setString(8, oPessoa.getBairroPessoa());
            stmt.setString(9, oPessoa.getCepPessoa());
            stmt.setString(10, oPessoa.getEmailPessoa());
            stmt.setString(11, oPessoa.getLogin());
            stmt.setString(12, oPessoa.getSenha());
            stmt.setInt(13, oPessoa.getCidade().getIdCidade());
            rs = stmt.executeQuery();
            conexao.commit();

            while (rs.next()) {
                idPessoa = rs.getInt("idPessoa");
            }
        } catch (SQLException e) {
            try {
                System.out.println("Problemas ao cadastrar Pessoa na DAO! Erro:" + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback" + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return idPessoa;
    }
    
    public int alterar(Object objeto){
        Pessoa oPessoa = (Pessoa) objeto;
        PreparedStatement stmt = null;
        Integer idPessoa = oPessoa.getIdPessoa();
        String sql = "UPDATE pessoa SET nomerazaopessoa=?, rgiepessoa=?, cpfcnpjpessoa=?, datanascfundpessoa=?, telefonepessoa=?, logradouropessoa=?, numlogradouropessoa=?, bairropessoa=?, ceppessoa=?, emailpessoa=?, login=?, senha=?, idcidade=? WHERE idpessoa=?;";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oPessoa.getNomeRazaoPessoa());
            stmt.setString(2, oPessoa.getRgIePessoa());
            stmt.setString(3, oPessoa.getCpfCnpjPessoa());
            stmt.setDate(4, new java.sql.Date(oPessoa.getDataNascFundPessoa().getTime()));
            stmt.setString(5, oPessoa.getTelefonePessoa());
            stmt.setString(6, oPessoa.getLogradouroPessoa());
            stmt.setString(7, oPessoa.getNumLogradouroPessoa());
            stmt.setString(8, oPessoa.getBairroPessoa());
            stmt.setString(9, oPessoa.getCepPessoa());
            stmt.setString(10, oPessoa.getEmailPessoa());
            stmt.setString(11, oPessoa.getLogin());
            stmt.setString(12, oPessoa.getSenha());
            stmt.setInt(13, oPessoa.getCidade().getIdCidade());
            stmt.setInt(14, oPessoa.getIdPessoa());
            stmt.execute();
            conexao.commit();
        }catch (SQLException e){
            try{
                System.out.println("Problemas ao alterar Pessoa na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            }catch(SQLException ex){
                System.out.println("problemas ao executar rollback"+ex.getMessage());
                ex.printStackTrace();
            }
        }
        return idPessoa;
    }
    
    public Pessoa carregar(int id){
        int idPessoa = id;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Pessoa oPessoa = null;
        String sql = "select * from pessoa where idpessoa=?";
        
        try{
            stmt=conexao.prepareStatement(sql);
            stmt.setInt(1, idPessoa);
            rs=stmt.executeQuery();
            
            while(rs.next()){
                Cidade oCidade = null;
                try{
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    int idCidade = rs.getInt("idcidade");
                    oCidade = (Cidade) oCidadeDAO.carregar(idCidade);
                }catch(Exception ex){
                    System.out.println("Problemas ao carregar cidade na PessoaDAO! Erro:"+ex.getMessage());
                }
                
                oPessoa = new Pessoa(rs.getInt("idpessoa"),
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
            return oPessoa;
        }catch(SQLException ex){
            System.out.println("Problemas ao carregar pessoa na DAO! Erro "+ex.getMessage());
            return null;
        }
    }
    
    public Pessoa carregarCpf(String cpf) throws ParseException{
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Pessoa oPessoa = null;
        String sql = "select * from pessoa where cpfcnpjpessoa=?";
        
        try{
            stmt=conexao.prepareStatement(sql);
            stmt.setString(1, cpf);
            rs=stmt.executeQuery();
            while(rs.next()){
                oPessoa = this.carregar(rs.getInt("idpessoa"));
            }
            if(oPessoa == null){
                Date novaData = Conversao.dataAtual();
                Cidade oCidade = new Cidade();
                oPessoa = new Pessoa(0,"","","",novaData,"","","","","","","","",oCidade);
            }
        }
        catch(SQLException ex){
            System.out.println("Problemas ao carregarCPF de pessoa na DAO! Erro: "+ex.getMessage());
        }
        return oPessoa;
    }
    
    public int verificarLogin(String login) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        //0 - Login Disponivel | 1 - Login Indisponivel
        int loginDisponivel = 0;
        String sql = "select count(idpessoa) as logindisponivel from pessoa where pessoa.login = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, login);
            rs = stmt.executeQuery();
            while (rs.next()) {
                loginDisponivel = rs.getInt("logindisponivel");
            }
            return loginDisponivel;
        } catch (SQLException ex) {
            System.out.println("Problemas ao verificar Login na PessoaDAO! Erro: " + ex.getMessage());
            return loginDisponivel;
        }
    }
}
