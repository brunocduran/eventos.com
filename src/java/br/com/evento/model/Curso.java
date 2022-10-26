/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

/**
create table curso(
	idCurso serial primary key, 
	nomeCurso varchar(100),
	situacao varchar(10),
	idInstituicao int, 
	constraint fk_curso foreign key(idInstituicao) references instituicao(idInstituicao))
;
 */
public class Curso {
    private int idCurso;
    private String nomeCurso;
    private String situacao;
    private Instituicao instituicao;

    public Curso(int idCurso, String nomeCurso, String situacao, Instituicao instituicao) {
        this.idCurso = idCurso;
        this.nomeCurso = nomeCurso;
        this.situacao = situacao;
        this.instituicao = instituicao;
    }

    public Curso() {
        this.idCurso = 0;
        this.nomeCurso = "";
        this.situacao = "A";
        this.instituicao = new Instituicao();
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getNomeCurso() {
        return nomeCurso;
    }

    public void setNomeCurso(String nomeCurso) {
        this.nomeCurso = nomeCurso;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }

    public Instituicao getInstituicao() {
        return instituicao;
    }

    public void setInstituicao(Instituicao instituicao) {
        this.instituicao = instituicao;
    }
    
    
    
    
    
}
