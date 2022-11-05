/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.evento;

import br.com.evento.dao.AtividadeEventoDAO;
import br.com.evento.dao.CategoriaEventoDAO;
import br.com.evento.dao.CidadeDAO;
import br.com.evento.dao.CursoDAO;
import br.com.evento.dao.EventoDAO;
import br.com.evento.dao.FuncaoDAO;
import br.com.evento.dao.GenericDAO;
import br.com.evento.dao.OrganizadorDAO;
import br.com.evento.dao.OrganizadorEventoDAO;
import br.com.evento.dao.TipoAtividadeDAO;
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
@WebServlet(name = "EventoCarregarHome", urlPatterns = {"/EventoCarregarHome"})
public class EventoCarregarHome extends HttpServlet {

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
        try{
            int idEvento = Integer.parseInt(request.getParameter("idEvento"));
            EventoDAO oEventoDAO = new EventoDAO();
            request.setAttribute("evento", oEventoDAO.carregar(idEvento));
            GenericDAO oCidadedao = new CidadeDAO();
            request.setAttribute("cidades", oCidadedao.listar());
            GenericDAO oCursoDAO = new CursoDAO();
            request.setAttribute("cursos", oCursoDAO.listar());            
            GenericDAO oCategoriaEventoDAO = new CategoriaEventoDAO();
            request.setAttribute("categoriaeventos", oCategoriaEventoDAO.listar());
            GenericDAO oOrganizadorDAO = new OrganizadorDAO();
            request.setAttribute("organizadores", oOrganizadorDAO.listar());
            GenericDAO oFuncaoDAO = new FuncaoDAO();
            request.setAttribute("funcoes", oFuncaoDAO.listar());
            GenericDAO oTipoAtividadeDAO = new TipoAtividadeDAO();
            request.setAttribute("tiposatividades", oTipoAtividadeDAO.listar());
            
            
            //Carregar OrganizadorEvento
            OrganizadorEventoDAO oOrganizadorEventoDAO = new OrganizadorEventoDAO();
            request.setAttribute("organizadoresEvento", oOrganizadorEventoDAO.listarOrganizadorEvento(idEvento));
            
            //Carregar AtividadeEvento
            AtividadeEventoDAO oAtividadeEventoDAO = new AtividadeEventoDAO();
            request.setAttribute("atividadesEvento", oAtividadeEventoDAO.listarAtividadeEvento(idEvento));

            request.getRequestDispatcher("/painel/cadastros/evento/eventoDetalhe.jsp").forward(request, response);
        }catch(Exception ex){
            System.out.println("Erro servlet evento carregar"+ex.getMessage());
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
