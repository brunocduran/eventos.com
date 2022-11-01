/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.organizadorEvento;

import br.com.evento.dao.OrganizadorEventoDAO;
import br.com.evento.model.Evento;
import br.com.evento.model.Funcao;
import br.com.evento.model.Organizador;
import br.com.evento.model.OrganizadorEvento;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author igorb
 */
@WebServlet(name = "OrganizadorEventoCadastrar", urlPatterns = {"/OrganizadorEventoCadastrar"})
public class OrganizadorEventoCadastrar extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=iso-8859-1");
        String mensagem = null;
        int idOrganizadorEvento = 0;
        try{
            OrganizadorEvento oOrganizadorEvento = new OrganizadorEvento();
            oOrganizadorEvento.setIdOrganizadorEvento(Integer.parseInt(request.getParameter("idOrganizadorEvento")));
            int idEvento = Integer.parseInt(request.getParameter("idEvento"));
            int idOrganizador = Integer.parseInt(request.getParameter("idOrganizador"));
            int idFuncao = Integer.parseInt(request.getParameter("idFuncao"));
            
            //cria objeto de evento.
            Evento oEvento = new Evento();
            oEvento.setIdEvento(idEvento);                    
            oOrganizadorEvento.setEvento(oEvento);
            
            //cria o objeto de organizador
            Organizador oOrganizador = null;
            oOrganizador = oOrganizador.organizadorVazio();
            //oOrganizador.organizadorVazio();
            oOrganizador.setIdOrganizador(idOrganizador);            
            oOrganizadorEvento.setOrganizador(oOrganizador);
            
            //cria o objeto de funcao
            Funcao oFuncao = new Funcao();
            oFuncao.setIdFuncao(idFuncao);
            oOrganizadorEvento.setFuncao(oFuncao);                   

            OrganizadorEventoDAO dao = new OrganizadorEventoDAO();            
            idOrganizadorEvento = dao.cadastrar(oOrganizadorEvento);
            
            if (idOrganizadorEvento > 0){
                OrganizadorEvento oOrganizadorEventoCadastrado = (OrganizadorEvento) dao.carregar(idOrganizadorEvento);                         
                Gson ogson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                String jSon = ogson.toJson(oOrganizadorEventoCadastrado);
                response.getWriter().write(jSon);   
            }else{
                response.getWriter().write("0");
            }
        }catch(Exception ex){
            System.out.println("Problemas no servlet OrganizadorEventoCadastrar! Erro: "+ex.getMessage());
            ex.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
