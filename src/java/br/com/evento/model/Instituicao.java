/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

/**
 *
 * @author igorb
 * 
 * create table instituicao(
	idInstituicao int primary key, 
	nomeInstituicao varchar(100),
	cnpj varchar(25)
);
 */
public class Instituicao {
 private int idInstituicao;
    private String nomeInstituicao;
    private String cnpj;
    private String situacao;
    private String imagem;

    public Instituicao(int idInstituicao, String nomeInstituicao, String cnpj, String situacao) {
        this.idInstituicao = idInstituicao;
        this.nomeInstituicao = nomeInstituicao;
        this.cnpj = cnpj;
        this.situacao = situacao;
        this.imagem = imagem;
    }
    
      public Instituicao() {
        this.idInstituicao = 0;
        this.nomeInstituicao = "";
        this.cnpj = "";
        this.situacao = "A";
    }

    public int getIdInstituicao() {
        return idInstituicao;
    }

    public void setIdInstituicao(int idInstituicao) {
        this.idInstituicao = idInstituicao;
    }

    public String getNomeInstituicao() {
        return nomeInstituicao;
    }

    public void setNomeInstituicao(String nomeInstituicao) {
        this.nomeInstituicao = nomeInstituicao;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

   
    
    
    
    
    
}
