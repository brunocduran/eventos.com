/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

import br.com.evento.utils.Conversao;
import java.text.ParseException;
import java.util.Date;

/**
 *
 * @author jgcoc
 */
public class Participante extends Pessoa{
    private int idParticipante;
    private String sexoParticipante;
    private String permiteLogin;
    private String situacao;

    public Participante(int idParticipante, String sexoParticipante, String permiteLogin, String situacao, int idPessoa, String nomeRazaoPessoa, String rgIePessoa, String cpfCnpjPessoa, Date dataNascFundPessoa, String telefonePessoa, String logradouroPessoa, String numLogradouroPessoa, String bairroPessoa, String cepPessoa, String emailPessoa, String login, String senha, Cidade cidade) {
        super(idPessoa, nomeRazaoPessoa, rgIePessoa, cpfCnpjPessoa, dataNascFundPessoa, telefonePessoa, logradouroPessoa, numLogradouroPessoa, bairroPessoa, cepPessoa, emailPessoa, login, senha, cidade);
        this.idParticipante = idParticipante;
        this.sexoParticipante = sexoParticipante;
        this.permiteLogin = permiteLogin;
        this.situacao = situacao;
    }
    
    public static Participante participanteVazio() throws ParseException{
        Cidade oCidade = new Cidade();
        Date dataNascimento = Conversao.dataAtual();
        Participante oParticipante = new Participante(0,"","S","A",0,"","","",dataNascimento,"","","","","","","","",oCidade);
        return oParticipante;
    }

    public int getIdParticipante() {
        return idParticipante;
    }

    public void setIdParticipante(int idParticipante) {
        this.idParticipante = idParticipante;
    }

    public String getSexoParticipante() {
        return sexoParticipante;
    }

    public void setSexoParticipante(String sexoParticipante) {
        this.sexoParticipante = sexoParticipante;
    }

    public String getPermiteLogin() {
        return permiteLogin;
    }

    public void setPermiteLogin(String permiteLogin) {
        this.permiteLogin = permiteLogin;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }
    
    
}
