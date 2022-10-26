/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

import java.util.Date;

/**
 *
 * @author bruno
 */
public class Pessoa {
    
    private int idPessoa;
    private String nomeRazaoPessoa;
    private String rgIePessoa;
    private String cpfCnpjPessoa;
    private Date dataNascFundPessoa;
    private String telefonePessoa;
    private String logradouroPessoa;
    private String numLogradouroPessoa;
    private String bairroPessoa;
    private String cepPessoa;
    private String emailPessoa;
    private String login;
    private String senha;
    private Cidade cidade;

    public Pessoa(int idPessoa, String nomeRazaoPessoa, String rgIePessoa, String cpfCnpjPessoa, Date dataNascFundPessoa, String telefonePessoa, String logradouroPessoa, String numLogradouroPessoa, String bairroPessoa, String cepPessoa, String emailPessoa, String login, String senha, Cidade cidade) {
        this.idPessoa = idPessoa;
        this.nomeRazaoPessoa = nomeRazaoPessoa;
        this.rgIePessoa = rgIePessoa;
        this.cpfCnpjPessoa = cpfCnpjPessoa;
        this.dataNascFundPessoa = dataNascFundPessoa;
        this.telefonePessoa = telefonePessoa;
        this.logradouroPessoa = logradouroPessoa;
        this.numLogradouroPessoa = numLogradouroPessoa;
        this.bairroPessoa = bairroPessoa;
        this.cepPessoa = cepPessoa;
        this.emailPessoa = emailPessoa;
        this.login = login;
        this.senha = senha;
        this.cidade = cidade;
    }

    public int getIdPessoa() {
        return idPessoa;
    }

    public void setIdPessoa(int idPessoa) {
        this.idPessoa = idPessoa;
    }

    public String getNomeRazaoPessoa() {
        return nomeRazaoPessoa;
    }

    public void setNomeRazaoPessoa(String nomeRazaoPessoa) {
        this.nomeRazaoPessoa = nomeRazaoPessoa;
    }

    public String getRgIePessoa() {
        return rgIePessoa;
    }

    public void setRgIePessoa(String rgIePessoa) {
        this.rgIePessoa = rgIePessoa;
    }

    public String getCpfCnpjPessoa() {
        return cpfCnpjPessoa;
    }

    public void setCpfCnpjPessoa(String cpfCnpjPessoa) {
        this.cpfCnpjPessoa = cpfCnpjPessoa;
    }

    public Date getDataNascFundPessoa() {
        return dataNascFundPessoa;
    }

    public void setDataNascFundPessoa(Date dataNascFundPessoa) {
        this.dataNascFundPessoa = dataNascFundPessoa;
    }

    public String getTelefonePessoa() {
        return telefonePessoa;
    }

    public void setTelefonePessoa(String telefonePessoa) {
        this.telefonePessoa = telefonePessoa;
    }

    public String getLogradouroPessoa() {
        return logradouroPessoa;
    }

    public void setLogradouroPessoa(String logradouroPessoa) {
        this.logradouroPessoa = logradouroPessoa;
    }

    public String getNumLogradouroPessoa() {
        return numLogradouroPessoa;
    }

    public void setNumLogradouroPessoa(String numLogradouroPessoa) {
        this.numLogradouroPessoa = numLogradouroPessoa;
    }

    public String getBairroPessoa() {
        return bairroPessoa;
    }

    public void setBairroPessoa(String bairroPessoa) {
        this.bairroPessoa = bairroPessoa;
    }

    public String getCepPessoa() {
        return cepPessoa;
    }

    public void setCepPessoa(String cepPessoa) {
        this.cepPessoa = cepPessoa;
    }

    public String getEmailPessoa() {
        return emailPessoa;
    }

    public void setEmailPessoa(String emailPessoa) {
        this.emailPessoa = emailPessoa;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public Cidade getCidade() {
        return cidade;
    }

    public void setCidade(Cidade cidade) {
        this.cidade = cidade;
    }
    
    
}
