/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

import br.com.evento.utils.Conversao;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author bruno
 */
public class AtividadeEvento {

    private int idAtividadeEvento;
    private Double cargaHoraria;
    private String nomeAtividade;
    private String resumo;
    private Date dataAtividade;
    private String horaAtividade;
    private Evento evento;
    private TipoAtividade tipoAtividade;

    public AtividadeEvento() {
        this.idAtividadeEvento = 0;
        this.cargaHoraria = 0.0;
        this.nomeAtividade = "";
        this.resumo = "";
        Date dataAtual = Conversao.dataAtual();
        this.dataAtividade = dataAtual;
        Date horaAtual = Conversao.horaAtual();
        this.horaAtividade = "";
        this.evento = new Evento();
        this.tipoAtividade = new TipoAtividade();
    }

    public AtividadeEvento(int idAtividadeEvento, Double cargaHoraria, String nomeAtividade, String resumo, Date dataAtividade, String horaAtividade, Evento evento, TipoAtividade tipoAtividade) {
        this.idAtividadeEvento = idAtividadeEvento;
        this.cargaHoraria = cargaHoraria;
        this.nomeAtividade = nomeAtividade;
        this.resumo = resumo;
        this.dataAtividade = dataAtividade;
        this.horaAtividade = horaAtividade;
        this.evento = evento;
        this.tipoAtividade = tipoAtividade;
    }

    public int getIdAtividadeEvento() {
        return idAtividadeEvento;
    }

    public void setIdAtividadeEvento(int idAtividadeEvento) {
        this.idAtividadeEvento = idAtividadeEvento;
    }

    public Double getCargaHoraria() {
        return cargaHoraria;
    }

    public void setCargaHoraria(Double cargaHoraria) {
        this.cargaHoraria = cargaHoraria;
    }

    public String getNomeAtividade() {
        return nomeAtividade;
    }

    public void setNomeAtividade(String nomeAtividade) {
        this.nomeAtividade = nomeAtividade;
    }

    public String getResumo() {
        return resumo;
    }

    public void setResumo(String resumo) {
        this.resumo = resumo;
    }

    public Date getDataAtividade() {
        return dataAtividade;
    }

    public String getDataAtividadeFormatada() {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        return formato.format(dataAtividade);
    }

    public void setDataAtividade(Date dataAtividade) {
        this.dataAtividade = dataAtividade;
    }

    public String getHoraAtividade() {
        return horaAtividade;
    }

    public void setHoraAtividade(String horaAtividade) {
        this.horaAtividade = horaAtividade;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public TipoAtividade getTipoAtividade() {
        return tipoAtividade;
    }

    public void setTipoAtividade(TipoAtividade tipoAtividade) {
        this.tipoAtividade = tipoAtividade;
    }

}
