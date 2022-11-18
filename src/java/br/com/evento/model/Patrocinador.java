
package br.com.evento.model;

import br.com.evento.utils.Conversao;
import java.text.ParseException;
import java.util.Date;


public class Patrocinador extends Pessoa {

    private int idPatrocinador;
    private String permiteLogin;
    private String situacao;

    public Patrocinador(int idPatrocinador, String permiteLogin, String situacao,
            int idPessoa, String nomeRazaoPessoa, String rgIePessoa, String cpfCnpjPessoa, Date dataNascFundPessoa, String telefonePessoa, String logradouroPessoa, String numLogradouroPessoa, String bairroPessoa, String cepPessoa, String emailPessoa, String login, String senha, Cidade cidade) {
        super(idPessoa, nomeRazaoPessoa, rgIePessoa, cpfCnpjPessoa, dataNascFundPessoa, telefonePessoa, logradouroPessoa, numLogradouroPessoa, bairroPessoa, cepPessoa, emailPessoa, login, senha, cidade);
        this.idPatrocinador = idPatrocinador;
        this.permiteLogin = permiteLogin;
        this.situacao = situacao;
    }
    
    public static Patrocinador patrocinadorVazio() throws ParseException{
        Cidade oCidade = new Cidade();
        Date dataNascimento = Conversao.dataAtual();
        Patrocinador oPatrocinador = new Patrocinador(0,"N","A",0,"","","",dataNascimento,"","","","","","","","",oCidade);
        return oPatrocinador;
    }

    public Patrocinador() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

  

    

    

    
    
   
    

    public int getIdPatrocinador() {
        return idPatrocinador;
    }

    public void setIdPatrocinador(int idPatrocinador) {
        this.idPatrocinador = idPatrocinador;
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
