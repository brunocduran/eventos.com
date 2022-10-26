
package br.com.evento.controller.patrocinador;

import br.com.evento.controller.patrocinador.*;
import br.com.evento.dao.PatrocinadorDAO;
import br.com.evento.model.Patrocinador;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PatrocinadorCarregar", urlPatterns = {"/PatrocinadorCarregar"})
public class PatrocinadorCarregar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=iso-8859-1");
        try{
            int idPatrocinador = Integer.parseInt(request.getParameter("idPatrocinador"));
            PatrocinadorDAO dao = new PatrocinadorDAO();
            Patrocinador oPatrocinador = (Patrocinador) dao.carregar(idPatrocinador);
            
            Gson ogson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
            String jSon = ogson.toJson(oPatrocinador);
            response.getWriter().write(jSon);
        }catch(Exception ex){
            System.out.println("Erro ao buscar Patrocinador - "+ex.getMessage());
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
