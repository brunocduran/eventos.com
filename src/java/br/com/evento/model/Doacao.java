package br.com.evento.model;

import br.com.evento.utils.Conversao;
import java.util.Date;

public class Doacao {

    private int idDoacao;

    private Patrocinador patrocinador;
    private double valorDoacao;
    private Date dataDoacao;
    private String descricao;
    private String situacao;

    Cidade oCidade = new Cidade();
    Date dataNascimento = Conversao.dataAtual();

    public Doacao() {
        this.idDoacao = 0;
        this.patrocinador = new Patrocinador(0, "N", "A", 0, "", "", "", dataNascimento, "", "", "", "", "", "", "", "", oCidade);
        this.valorDoacao = 0.0;
        this.dataDoacao = null;
        this.descricao = "";
        this.situacao = "A";

    }

    public Doacao(int idDoacao, Patrocinador patrocinador, double valorDoacao, Date dataDoacao, String descricao, String situacao) {
        this.idDoacao = idDoacao;
        this.patrocinador = patrocinador;
        this.valorDoacao = valorDoacao;
        this.dataDoacao = dataDoacao;
        this.descricao = descricao;
        this.situacao = situacao;
    }

    

    public int getIdDoacao() {
        return idDoacao;
    }

    public void setIdDoacao(int idDoacao) {
        this.idDoacao = idDoacao;
    }

    public Patrocinador getPatrocinador() {
        return patrocinador;
    }

    public void setPatrocinador(Patrocinador patrocinador) {
        this.patrocinador = patrocinador;
    }

    public double getValorDoacao() {
        return valorDoacao;
    }

    public void setValorDoacao(double valorDoacao) {
        this.valorDoacao = valorDoacao;
    }

    public Date getDataDoacao() {
        return dataDoacao;
    }

    public void setDataDoacao(Date dataDoacao) {
        this.dataDoacao = dataDoacao;
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
