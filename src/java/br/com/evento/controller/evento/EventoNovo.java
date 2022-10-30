/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.evento;

import br.com.evento.dao.CategoriaEventoDAO;
import br.com.evento.dao.CidadeDAO;
import br.com.evento.dao.CursoDAO;
import br.com.evento.dao.FuncaoDAO;
import br.com.evento.dao.GenericDAO;
import br.com.evento.dao.OrganizadorDAO;
import br.com.evento.model.Cidade;
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
@WebServlet(name = "EventoNovo", urlPatterns = {"/EventoNovo"})
public class EventoNovo extends HttpServlet {

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
            Evento oEvento = new Evento();
            request.setAttribute("evento", oEvento); //mandar o objeto de evento vazio
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
            
            request.getRequestDispatcher("painel/cadastros/evento/eventoCadastrar.jsp").forward(request, response);
        } catch(Exception ex){
            System.out.println("Problemas no Servlet EventoNovo! Erro: "+ ex.getMessage());
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
