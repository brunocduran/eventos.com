/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.doacao;

import br.com.evento.dao.DoacaoDAO;
import br.com.evento.dao.PatrocinadorDAO;
import br.com.evento.model.Cidade;
import br.com.evento.model.Patrocinador;
import br.com.evento.model.Doacao;
import br.com.evento.model.Evento;
import br.com.evento.utils.Conversao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static sun.security.jgss.GSSUtil.login;

/**
 *
 * @author alyso
 */
@WebServlet(name = "DoacaoCadastrar", urlPatterns = {"/DoacaoCadastrar"})
public class DoacaoCadastrar extends HttpServlet {

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
        try {
            
            int idDoacao = Integer.parseInt(request.getParameter("idDoacao"));
            Double valorDoacao = Conversao.valorDinheiro(request.getParameter("valorDoacao"));
            Date dataDoacao = Date.valueOf(request.getParameter("dataDoacao"));
            String descricao = request.getParameter("descricao");
            String situacao = request.getParameter("situacao");
            int idPatrocinador = Integer.parseInt(request.getParameter("idPatrocinador"));
            int idEvento = Integer.parseInt(request.getParameter("idEvento"));
            
            Patrocinador oPatrocinador = Patrocinador.patrocinadorVazio();
            oPatrocinador.setIdPatrocinador(idPatrocinador);
            
            Evento oEvento = new Evento();
            oEvento.setIdEvento(idEvento);
            
            Doacao oDoacao = new Doacao(idDoacao, oPatrocinador, oEvento, valorDoacao, dataDoacao, descricao, situacao);            
            DoacaoDAO dao = new DoacaoDAO();
            
            if (dao.cadastrar(oDoacao)) {
                response.getWriter().write("1");
            } else {
                response.getWriter().write("0");
            }
        } catch (Exception ex) {
            System.out.println("Problemas no servlet cadastrar Doação! Erro: " + ex.getMessage());
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
