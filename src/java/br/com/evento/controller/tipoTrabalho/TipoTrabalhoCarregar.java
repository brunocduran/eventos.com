
package br.com.evento.controller.tipoTrabalho;

import br.com.evento.dao.TipoTrabalhoDAO;
import br.com.evento.model.TipoTrabalho;
import br.com.evento.dao.GenericDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TipoTrabalhoCarregar", urlPatterns = {"/TipoTrabalhoCarregar"})
public class TipoTrabalhoCarregar extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=iso-8859-1");
       try{
          int idTipoTrabalho = Integer.parseInt(request.getParameter("idTipoTrabalho"));
            TipoTrabalhoDAO dao = new TipoTrabalhoDAO();
            TipoTrabalho oTipoTrabalho = (TipoTrabalho) dao.carregar(idTipoTrabalho);
            
            Gson ogson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
            String jSon = ogson.toJson(oTipoTrabalho);
            response.getWriter().write(jSon);
       }catch(Exception e){
           System.out.println("Problema no servlet carregar o Tipo do Traabalho! Erro: "+e.getMessage());
           e.printStackTrace();
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
