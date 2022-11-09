/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

import br.com.evento.model.Evento;
import br.com.evento.utils.Conversao;
import java.util.Date;


/**
 *
 * @author johat
 */
public class ConfiguracaoBanner {
    
    private int idConfiguracaoBanner;
    private Evento evento;
    private String tituloBanner;
    private String msgBanner;
    private String imagem;
    private String tipoBanner;
    private Date dataInicial;
    private Date dataFinal;

    public ConfiguracaoBanner() {
        this.idConfiguracaoBanner = 0;
        this.evento = new Evento();
        this.tituloBanner = "";
        this.msgBanner = "";
        this.imagem = "";
        this.tipoBanner = "";
        this.dataInicial = null;
        this.dataFinal = null;
        
    }

    public ConfiguracaoBanner(int idConfiguracaoBanner, Evento idEvento, String tituloBanner, String msgBanner, String imagem, String tipoBanner, Date dataInicial, Date dataFinal) {
        this.idConfiguracaoBanner = idConfiguracaoBanner;
        this.evento = idEvento;
        this.tituloBanner = tituloBanner;
        this.msgBanner = msgBanner;
        this.imagem = imagem;
        this.tipoBanner = tipoBanner;
        this.dataInicial = dataInicial;
        this.dataFinal = dataFinal;
    }

    public int getIdConfiguracaoBanner() {
        return idConfiguracaoBanner;
    }

    public void setIdConfiguracaoBanner(int idConfiguracaoBanner) {
        this.idConfiguracaoBanner = idConfiguracaoBanner;
    }

    public String getTituloBanner() {
        return tituloBanner;
    }

    public void setTituloBanner(String tituloBanner) {
        this.tituloBanner = tituloBanner;
    }

    public String getMsgBanner() {
        return msgBanner;
    }

    public void setMsgBanner(String msgBanner) {
        this.msgBanner = msgBanner;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public String getTipoBanner() {
        return tipoBanner;
    }

    public void setTipoBanner(String tipoBanner) {
        this.tipoBanner = tipoBanner;
    }

    public Date getDataInicial() {
        return dataInicial;
    }

    public void setDataInicial(Date dataInicial) {
        this.dataInicial = dataInicial;
    }

    public Date getDataFinal() {
        return dataFinal;
    }

    public void setDataFinal(Date dataFinal) {
        this.dataFinal = dataFinal;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    
    
    
}
