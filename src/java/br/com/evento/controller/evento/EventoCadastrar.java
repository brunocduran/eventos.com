/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.evento;

import br.com.evento.dao.EventoDAO;
import br.com.evento.model.Evento;
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
@WebServlet(name = "EventoCadastrar", urlPatterns = {"/EventoCadastrar"})
public class EventoCadastrar extends HttpServlet {

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
        try{
            Evento oEvento = new Evento();
            oEvento.setIdEvento(Integer.parseInt(request.getParameter("idevento")));
            //oEvento.set
            
            //oInstituicao.setIdInstituicao(Integer.parseInt(request.getParameter("idInstituicao")));
           // oInstituicao.setNomeInstituicao(request.getParameter("nomeInstituicao"));
           // oInstituicao.setCnpj(request.getParameter("cnpj"));
           // oInstituicao.setSituacao(request.getParameter("situacao"));
           // oInstituicao.setImagem(request.getParameter("imagem"));
            
            EventoDAO dao = new EventoDAO();
            
            if (dao.cadastrar(oEvento)){
                response.getWriter().write("1");
            }else{
                response.getWriter().write("0");
            }
        }catch(Exception ex){
            System.out.println("Problemas no servlet cadastrar evento! Erro: "+ex.getMessage());
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
