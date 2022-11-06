/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.model;

import javax.servlet.http.HttpSession;

/**
 *
 * @author igorb
 */
public class Usuario {
    private int idPessoa;
    private int id;
    private String nomerazaopessoa;
    private String cpfcnpjpessoa;
    private String login;
    private String senha;
    private String tipo;

    public Usuario() {
    }

    public Usuario(int idPessoa, int id, String nomerazaopessoa, String cpfcnpjpessoa, String login, String senha, String tipo) {
        this.idPessoa = idPessoa;
        this.id = id;
        this.nomerazaopessoa = nomerazaopessoa;
        this.cpfcnpjpessoa = cpfcnpjpessoa;
        this.login = login;
        this.senha = senha;
        this.tipo = tipo;
    }

    public int getIdPessoa() {
        return idPessoa;
    }

    public void setIdPessoa(int idPessoa) {
        this.idPessoa = idPessoa;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomerazaopessoa() {
        return nomerazaopessoa;
    }

    public void setNomerazaopessoa(String nomerazaopessoa) {
        this.nomerazaopessoa = nomerazaopessoa;
    }

    public String getCpfcnpjpessoa() {
        return cpfcnpjpessoa;
    }

    public void setCpfcnpjpessoa(String cpfcnpjpessoa) {
        this.cpfcnpjpessoa = cpfcnpjpessoa;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    public static boolean verificaUsuario (String urlParaAutenticar, HttpSession sessao){
        boolean status = false;
        try{       
            //se for um acesso liberado permite passagem
            if(urlParaAutenticar.contains("/home/") ||  
                    urlParaAutenticar.contains("/painel/") || 
                    urlParaAutenticar.contains("/painel/js/") || 
                    urlParaAutenticar.contains("/painel/cadastros/") || 
                    urlParaAutenticar.contains("/painel/plugins/") || 
                    urlParaAutenticar.contains("/painel/css/") ||
                    urlParaAutenticar.contains("/painel/img/") ||
                    urlParaAutenticar.contains("/painel/webfonts/") ||
                    urlParaAutenticar.equalsIgnoreCase("/UsuarioLogar") ||   
                    urlParaAutenticar.equalsIgnoreCase("/UsuarioDeslogar") || 
                    urlParaAutenticar.equalsIgnoreCase("/Home") ||
                    urlParaAutenticar.equalsIgnoreCase("/Painel/login.jsp") ||
                    urlParaAutenticar.equalsIgnoreCase("/index.jsp") ||
                     urlParaAutenticar.equalsIgnoreCase("/Cadastrar") ||    
                    urlParaAutenticar.equalsIgnoreCase("/PessoaBuscarCpfCnpj") ||
                    urlParaAutenticar.equalsIgnoreCase("/ParticipanteCadastrar") ||
                    urlParaAutenticar.equalsIgnoreCase("/CidadeBuscarPorEstado") ||
                    urlParaAutenticar.equalsIgnoreCase("/ParticipanteCadastrar") ||
                    urlParaAutenticar.equalsIgnoreCase("/EventoCarregarHome") ||
                    urlParaAutenticar.equalsIgnoreCase("/PessoaVerificarLogin")){
                status = true;
            }           
            
            if (sessao != null && sessao.getAttributeNames().hasMoreElements()){
                //pega os dados do usuario
                int idUsuario = Integer.parseInt(sessao.getAttribute("idusuario").toString());
                String tipoUsuario = sessao.getAttribute("tipousuario").toString();
                
                //verifica permissoes
                //se for administrador libera todos os recursos                
                if (tipoUsuario.equalsIgnoreCase("Administrador")){
                    System.out.println("O tipo do usuario é: "+tipoUsuario);
                    status = true;
                }else{
                    if (tipoUsuario.equalsIgnoreCase("Organizador")){
                        //organizador pode fazer tudo, menos cadastrar administrador, entao o if aqui vai ser ao contrario
                        //libera tudo                       
                        status = true;
                        //se tentar acessar adm, bloqueia
                        if (urlParaAutenticar.equalsIgnoreCase("/AdministradorListar") ||
                            urlParaAutenticar.equalsIgnoreCase("/AdministradorCarregar") ||
                            urlParaAutenticar.equalsIgnoreCase("/AdministradorExcluir") || 
                            urlParaAutenticar.equalsIgnoreCase("/AdministradorListar") ){
                            status = false; //se tentar acessar algumas dessas, sera barrado
                        }                            
                    }                    
                    //participante só tem acesso ao cadastro de cidade e estado
                    if (tipoUsuario.equalsIgnoreCase("Participante")){                       
                         if (urlParaAutenticar.equalsIgnoreCase("/CidadeCadastrar") ||
                            urlParaAutenticar.equalsIgnoreCase("/CidadeCarregar") ||
                            urlParaAutenticar.equalsIgnoreCase("/CidadeExcluir") || 
                            urlParaAutenticar.equalsIgnoreCase("/CidadeListar") ||
                            urlParaAutenticar.equalsIgnoreCase("/CidadeBuscarPorEstado") ||
                            urlParaAutenticar.equalsIgnoreCase("/EstadoCadastrar") ||
                            urlParaAutenticar.equalsIgnoreCase("/EstadoCarregar") ||
                            urlParaAutenticar.equalsIgnoreCase("/EstadoExcluir") || 
                            urlParaAutenticar.equalsIgnoreCase("/EstadoListar") ||
                            urlParaAutenticar.equalsIgnoreCase("/PessoaBuscarCpfCnpj") ||
                            urlParaAutenticar.equalsIgnoreCase("/PessoaVerificarLogin") ||
                            urlParaAutenticar.equalsIgnoreCase("/ParticipanteCadastrar") ||     
                            urlParaAutenticar.equalsIgnoreCase("/ParticipanteLogadoCarregar")){
                            status = true; //permite acesso ao usuario tipo participante
                        }
                    }                    
                   
                }     
            }
        } catch(Exception ex){
            System.out.println("Erro na model usuario metodo: verificaUsuario "+ex.getMessage());
            ex.printStackTrace();
        }
        System.out.println("O status retornado é: "+status);
        return status;
    }
    
    
    
}
