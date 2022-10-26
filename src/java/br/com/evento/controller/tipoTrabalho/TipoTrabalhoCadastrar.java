
package br.com.evento.controller.tipoTrabalho;

import br.com.evento.dao.TipoTrabalhoDAO;
import br.com.evento.model.TipoTrabalho;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TipoTrabalhoCadastrar", urlPatterns = {"/TipoTrabalhoCadastrar"})
public class TipoTrabalhoCadastrar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=iso-8859-1");
        String mensagem = null;
        try{
            TipoTrabalho oTipoTrabalho = new TipoTrabalho();
            oTipoTrabalho.setIdTipoTrabalho(Integer.parseInt(request.getParameter("idtipotrabalho")));
            oTipoTrabalho.setDescricao(request.getParameter("descricao"));
            oTipoTrabalho.setSituacao(request.getParameter("situacao"));
            TipoTrabalhoDAO dao = new TipoTrabalhoDAO();
            
            if (dao.cadastrar(oTipoTrabalho)){
                response.getWriter().write("1");
            }else{
                response.getWriter().write("0");
            }
        }catch(Exception ex){
            System.out.println("Problemas no servlet cadastrar o Tipo do Trabalho! Erro: "+ex.getMessage());
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
