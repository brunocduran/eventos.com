
package br.com.evento.model;


public class Funcao {
    
    private int idFuncao;
    private String descricao;
    private String situacao;

    public Funcao() {
        this.idFuncao = 0;
        this.descricao = "";
        this.situacao = "A";
    }

    public Funcao(int idFuncao, String descricao, String situacao) {
        this.idFuncao = idFuncao;
        this.descricao = descricao;
        this.situacao = situacao;
    }

    public int getIdFuncao() {
        return idFuncao;
    }

    public void setIdFuncao(int idFuncao) {
        this.idFuncao = idFuncao;
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
