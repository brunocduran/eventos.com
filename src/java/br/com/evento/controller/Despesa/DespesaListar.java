/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.Despesa;

import br.com.evento.dao.DespesaDAO;
import br.com.evento.dao.EventoDAO;
import br.com.evento.dao.FornecedorDAO;
import br.com.evento.dao.GenericDAO;
import br.com.evento.dao.OrganizadorEventoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author johat
 */
@WebServlet(name = "DespesaListar", urlPatterns = {"/DespesaListar"})
public class DespesaListar extends HttpServlet {

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
        int idEvento = 0;
        try {

            HttpSession sessao = request.getSession();
            int idUsuario = Integer.parseInt(sessao.getAttribute("idusuario").toString());
            String tipoUsuario = sessao.getAttribute("tipousuario").toString();
            int verificaEvento = 0;

            idEvento = Integer.parseInt(request.getParameter("idEvento"));

            if (idEvento > 0) {
                EventoDAO oEventoDAO = new EventoDAO();
                request.setAttribute("eventoCarregado", oEventoDAO.carregar(idEvento));
            }

            GenericDAO oFornecedorDAO = new FornecedorDAO();
            request.setAttribute("fornecedores", oFornecedorDAO.listar());
            EventoDAO oEventoDAO = new EventoDAO();

            if (tipoUsuario.equalsIgnoreCase("Organizador")) {
                request.setAttribute("eventos", oEventoDAO.listar(idUsuario));
            } else {
                request.setAttribute("eventos", oEventoDAO.listar(0));
            }

            //Carregar OrganizadorEvento
            OrganizadorEventoDAO oOrganizadorEventoDAO = new OrganizadorEventoDAO();

            if (tipoUsuario.equalsIgnoreCase("Organizador") && (idEvento > 0)) {
                verificaEvento = oOrganizadorEventoDAO.verificaOrgEvento(idUsuario, idEvento);
            } else if (tipoUsuario.equalsIgnoreCase("Organizador")) {
                verificaEvento = 1;
            } else {
                verificaEvento = 1;
                idUsuario = 0;
            }

            DespesaDAO oDespesaDAO = new DespesaDAO();
            request.setAttribute("despesas", oDespesaDAO.listarPorEvento(idEvento, idUsuario));

            if (verificaEvento >= 1) {
                request.getRequestDispatcher("painel/cadastros/despesa/despesa.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/Painel").forward(request, response);
            }

        } catch (Exception ex) {
            System.out.println("Problemas no Servlet ao listar Despesa! Erro: " + ex.getMessage());
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
