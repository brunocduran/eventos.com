
package br.com.evento.controller.patrocinador;

import br.com.evento.controller.patrocinador.*;
import br.com.evento.dao.EstadoDAO;
import br.com.evento.dao.GenericDAO;
import br.com.evento.dao.PatrocinadorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PatrocinadorListar", urlPatterns = {"/PatrocinadorListar"})
public class PatrocinadorListar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=iso-8859-1");
        try{
            GenericDAO dao = new PatrocinadorDAO();
            request.setAttribute("patrocinadores", dao.listar());
            GenericDAO oEstadoDAO = new EstadoDAO();
            request.setAttribute("estados", oEstadoDAO.listar());
            request.getRequestDispatcher("painel/cadastros/patrocinador/patrocinador.jsp").forward(request, response);
        } catch(Exception ex){
            System.out.println("Problemas no Servlet ao listar Patrocinador! Erro: "+ ex.getMessage());
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
