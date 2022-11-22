/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.evento.dao;

import br.com.evento.model.Contato;
import br.com.evento.utils.JavaMailApp;

/**
 *
 * @author FEF
 */
public class ContatoDAO {

    public Boolean contato(Object objeto) {
        Contato oContato = (Contato) objeto;

        JavaMailApp.enviar(oContato.getAssunto(), oContato.getMensagem());

        return true;
    }
}
