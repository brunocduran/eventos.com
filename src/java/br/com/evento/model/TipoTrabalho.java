/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

/**
 *
 * @author bruno
 */
public class TipoTrabalho {
    private int idTipoTrabalho;
    private String descricao;
    private String situacao;

    public TipoTrabalho() {
        idTipoTrabalho = 0;
        descricao = "";
        situacao = "A";
    }

    public TipoTrabalho(int idTipoTrabalho, String descricao, String situacao) {
        this.idTipoTrabalho = idTipoTrabalho;
        this.descricao = descricao;
        this.situacao = situacao;
    }

    public int getIdTipoTrabalho() {
        return idTipoTrabalho;
    }

    public void setIdTipoTrabalho(int idTipoTrabalho) {
        this.idTipoTrabalho = idTipoTrabalho;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    
    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }
     
}
