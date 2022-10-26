/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

import br.com.evento.utils.Conversao;
import java.text.ParseException;
import java.util.Date;

/**
 *
 * @author igorb
 */
public class Fornecedor extends Pessoa {
    private int idFornecedor;
    private String situacaoFornecedor;
    private String permiteLogin;
    private TipoTrabalho tipoTrabalho;

    public Fornecedor(int idFornecedor, String situacaoFornecedor, String permiteLogin, TipoTrabalho tipoTrabalho, int idPessoa, String nomeRazaoPessoa, String rgIePessoa, String cpfCnpjPessoa, Date dataNascFundPessoa, String telefonePessoa, String logradouroPessoa, String numLogradouroPessoa, String bairroPessoa, String cepPessoa, String emailPessoa, String login, String senha, Cidade cidade) {
        super(idPessoa, nomeRazaoPessoa, rgIePessoa, cpfCnpjPessoa, dataNascFundPessoa, telefonePessoa, logradouroPessoa, numLogradouroPessoa, bairroPessoa, cepPessoa, emailPessoa, login, senha, cidade);
        this.idFornecedor = idFornecedor;
        this.situacaoFornecedor = situacaoFornecedor;
        this.permiteLogin = permiteLogin;
        this.tipoTrabalho = tipoTrabalho;
    }
    
    public static Fornecedor fornecedorVazio() throws ParseException{
        Cidade oCidade = new Cidade();
        TipoTrabalho oTipoTrabalho = new TipoTrabalho();
        Date dataNascimento = Conversao.dataAtual();
        Fornecedor oFornecedor = new Fornecedor(0, "S", "N", oTipoTrabalho, 0, "", "", "", dataNascimento, "", "", "", "", "", "", "", "", oCidade);
        return oFornecedor;
        
      }

    public int getIdFornecedor() {
        return idFornecedor;
    }

    public void setIdFornecedor(int idFornecedor) {
        this.idFornecedor = idFornecedor;
    }

    public String getSituacaoFornecedor() {
        return situacaoFornecedor;
    }

    public void setSituacaoFornecedor(String situacaoFornecedor) {
        this.situacaoFornecedor = situacaoFornecedor;
    }

    public String getPermiteLogin() {
        return permiteLogin;
    }

    public void setPermiteLogin(String permiteLogin) {
        this.permiteLogin = permiteLogin;
    }

    public TipoTrabalho getTipoTrabalho() {
        return tipoTrabalho;
    }

    public void setTipoTrabalho(TipoTrabalho tipoTrabalho) {
        this.tipoTrabalho = tipoTrabalho;
    }
    
    
    
    

    

    
    
    
    
}
