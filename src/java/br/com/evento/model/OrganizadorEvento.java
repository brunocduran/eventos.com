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
public class OrganizadorEvento {
    private int idOrganizadorEvento;
    private Evento evento;
    private Organizador organizador;
    private Funcao funcao;

    public OrganizadorEvento() {
        this.idOrganizadorEvento = 0;
        this.evento = new Evento();
        this.organizador = null; // nao consegui colocar new Organizador()
        this.funcao  = new Funcao();
    }

    public OrganizadorEvento(int idOrganizadorEvento, Evento evento, Organizador organizador, Funcao funcao) {
        this.idOrganizadorEvento = idOrganizadorEvento;
        this.evento = evento;
        this.organizador = organizador;
        this.funcao = funcao;
    }

    public int getIdOrganizadorEvento() {
        return idOrganizadorEvento;
    }

    public void setIdOrganizadorEvento(int idOrganizadorEvento) {
        this.idOrganizadorEvento = idOrganizadorEvento;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public Organizador getOrganizador() {
        return organizador;
    }

    public void setOrganizador(Organizador organizador) {
        this.organizador = organizador;
    }

    public Funcao getFuncao() {
        return funcao;
    }

    public void setFuncao(Funcao funcao) {
        this.funcao = funcao;
    }
    
    
    
    
    
}
