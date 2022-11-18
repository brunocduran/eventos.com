/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;
import br.com.evento.utils.Conversao;
import java.util.Date;

/**
 *
 * @author johat
 */
public class Despesa {
    
    private int idDespesa;
    private Fornecedor fornecedor;
    private double valorDespesa;
    private Date vencimentoDespesa;
    private Date pagamentoDespesa;
    private String descricao; 
    private String situacao;
    
    Cidade oCidade = new Cidade();
    TipoTrabalho oTipoTrabalho = new TipoTrabalho();
    Date dataNascimento = Conversao.dataAtual();

    public Despesa() {
        this.idDespesa = 0;
        this.fornecedor = new Fornecedor(0, "S", "N", oTipoTrabalho, 0, "", "", "", dataNascimento, "", "", "", "", "", "", "", "", oCidade);
        this.valorDespesa = 0;
        this.vencimentoDespesa = Conversao.dataAtual();
        this.pagamentoDespesa = Conversao.dataAtual();
        this.descricao = "";
        this.situacao = "A";
    }

    public Despesa(int idDespesa, Fornecedor fornecedor, double valorDespesa, Date vencimentoDespesa, Date pagamentoDespesa, String descricao, String situacao) {
        this.idDespesa = idDespesa;
        this.fornecedor = fornecedor;
        this.valorDespesa = valorDespesa;
        this.vencimentoDespesa = vencimentoDespesa;
        this.pagamentoDespesa = pagamentoDespesa;
        this.descricao = descricao;
        this.situacao = situacao;
    }

    public int getIdDespesa() {
        return idDespesa;
    }

    public void setIdDespesa(int idDespesa) {
        this.idDespesa = idDespesa;
    }

    public Fornecedor getFornecedor() {
        return fornecedor;
    }

    public void setFornecedor(Fornecedor fornecedor) {
        this.fornecedor = fornecedor;
    }

    public double getValorDespesa() {
        return valorDespesa;
    }

    public void setValorDespesa(double valorDespesa) {
        this.valorDespesa = valorDespesa;
    }

    public Date getVencimentoDespesa() {
        return vencimentoDespesa;
    }

    public void setVencimentoDespesa(Date vencimentoDespesa) {
        this.vencimentoDespesa = vencimentoDespesa;
    }

    public Date getPagamentoDespesa() {
        return pagamentoDespesa;
    }

    public void setPagamentoDespesa(Date pagamentoDespesa) {
        this.pagamentoDespesa = pagamentoDespesa;
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
