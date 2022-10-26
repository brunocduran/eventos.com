/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

/**
 *
 * @author igorb
 */
public class CategoriaEvento {
     private int idCategoriaEvento;
    private String nome;
    private String situacao;

    public CategoriaEvento() {
    }

    public CategoriaEvento(int idCategoriaEvento, String nome, String situacao) {
        this.idCategoriaEvento = idCategoriaEvento;
        this.nome = nome;
        this.situacao = situacao;
    }

    public int getIdCategoriaEvento() {
        return idCategoriaEvento;
    }

    public void setIdCategoriaEvento(int idCategoriaEvento) {
        this.idCategoriaEvento = idCategoriaEvento;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }
    
    
    
}
