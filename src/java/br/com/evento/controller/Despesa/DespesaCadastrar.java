/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.Despesa;

import br.com.evento.dao.DespesaDAO;
import br.com.evento.dao.FornecedorDAO;
import br.com.evento.model.Cidade;
import br.com.evento.model.Despesa;
import br.com.evento.model.Evento;
import br.com.evento.model.Fornecedor;
import br.com.evento.model.TipoTrabalho;
import br.com.evento.utils.Conversao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author johat
 */
@WebServlet(name = "DespesaCadastrar", urlPatterns = {"/DespesaCadastrar"})
public class DespesaCadastrar extends HttpServlet {

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
            
            int idDespesa = Integer.parseInt(request.getParameter("idDespesa"));
            Double valorDespesa = Conversao.valorDinheiro(request.getParameter("valorDespesa"));
            Date vencimentoDespesa = Date.valueOf(request.getParameter("vencimentoDespesa"));
            //Date pagamentoDespesa = Date.valueOf(request.getParameter("pagamentoDespesa"));
            String descricao = request.getParameter("descricao");
            String situacao = request.getParameter("situacao");
            int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor"));
            int idEvento = Integer.parseInt(request.getParameter("idEvento"));


            Fornecedor oFornecedor =  Fornecedor.fornecedorVazio();
            oFornecedor.setIdFornecedor(idFornecedor);
            
            Evento oEvento = new Evento();
            oEvento.setIdEvento(idEvento);
            
            Despesa oDespesa = new Despesa(idDespesa, oFornecedor, valorDespesa, vencimentoDespesa, null,
                    descricao, situacao, oEvento);
            
            DespesaDAO dao = new DespesaDAO();
            if (dao.cadastrar(oDespesa)){
                response.getWriter().write("1");
            } else {
                response.getWriter().write("0");
            }
        } catch (Exception e) {
            System.out.println("Problemas no Servlet ao Cadastrar a Despesa! Erro: "+e.getMessage());
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
