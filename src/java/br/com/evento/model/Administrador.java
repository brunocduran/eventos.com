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
 * @author bruno
 */
public class Administrador extends Pessoa {

    private int idAdministrador;
    private String permiteLogin;
    private String situacao;

    public Administrador(int idAdministrador, String permiteLogin, String situacao,
            int idPessoa, String nomeRazaoPessoa, String rgIePessoa, String cpfCnpjPessoa, Date dataNascFundPessoa, String telefonePessoa, String logradouroPessoa, String numLogradouroPessoa, String bairroPessoa, String cepPessoa, String emailPessoa, String login, String senha, Cidade cidade) {
        super(idPessoa, nomeRazaoPessoa, rgIePessoa, cpfCnpjPessoa, dataNascFundPessoa, telefonePessoa, logradouroPessoa, numLogradouroPessoa, bairroPessoa, cepPessoa, emailPessoa, login, senha, cidade);
        this.idAdministrador = idAdministrador;
        this.permiteLogin = permiteLogin;
        this.situacao = situacao;
    }
    
    public static Administrador administradorVazio() throws ParseException{
        Cidade oCidade = new Cidade();
        Date dataNascimento = Conversao.dataAtual();
        Administrador oAdministrador = new Administrador(0,"S","A",0,"","","",dataNascimento,"","","","","","","","",oCidade);
        return oAdministrador;
    }

    public int getIdAdministrador() {
        return idAdministrador;
    }

    public void setIdAdministrador(int idAdministrador) {
        this.idAdministrador = idAdministrador;
    }

    public String getPermiteLogin() {
        return permiteLogin;
    }

    public void setPermiteLogin(String permiteLogin) {
        this.permiteLogin = permiteLogin;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }
    
    

}
