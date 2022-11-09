/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.ConfiguracaoBanner;

import br.com.evento.dao.ConfiguracaoBannerDAO;
import br.com.evento.model.ConfiguracaoBanner;
import br.com.evento.model.Evento;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author johat
 */
@WebServlet(name = "ConfiguracaoBannerCadastrar", urlPatterns = {"/ConfiguracaoBannerCadastrar"})
public class ConfiguracaoBannerCadastrar extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=iso-8859-1");
        String mensagem = null;
        try {
            int idConfiguracaoBanner = Integer.parseInt(request.getParameter("idconfiguracaobanner"));
            String tituloBanner = request.getParameter("titulobanner");
            String msgBanner = request.getParameter("msgbanner");
            String imagem = request.getParameter("imagem");
            String tipoBanner = request.getParameter("tipobanner");
            Date dataInicial = Date.valueOf(request.getParameter("datainicial"));
            Date dataFinal = Date.valueOf(request.getParameter("datafinal"));
            int idEvento = Integer.parseInt(request.getParameter("idevento"));

            Evento oEvento = new Evento();
            oEvento.setIdEvento(idEvento);

            ConfiguracaoBannerDAO dao = new ConfiguracaoBannerDAO();
            int verificaBanner = 0;
            
            if (!tipoBanner.equalsIgnoreCase("C")){
                if (idConfiguracaoBanner > 0){
                    verificaBanner = dao.verificaCadastroBanner(dataInicial, dataFinal, tipoBanner, idConfiguracaoBanner);
                }else{
                    verificaBanner = dao.verificaCadastroBanner(dataInicial, dataFinal, tipoBanner,0);        
                }
            }else{
                verificaBanner = 0;
            }
            
            if (verificaBanner == 0) {
                ConfiguracaoBanner oConfiguracaoBanner = new ConfiguracaoBanner(idConfiguracaoBanner, oEvento, tituloBanner, msgBanner,
                   imagem, tipoBanner, dataInicial, dataFinal);

                if (dao.cadastrar(oConfiguracaoBanner)) {
                //mensagem = "Cadastrado com Sucesso!";
                response.getWriter().write("1");
                } else {
                //mensagem = "Problemas ao cadastrar Despesa!";
                response.getWriter().write("0");
                }               

            }else{
                response.getWriter().write("2");           
            }
        } catch (Exception e) {
            System.out.println("Problemas no servelet Cadastrar Configuracao de Banner! Erro: " + e.getMessage());
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ConfiguracaoBannerCadastrar.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ConfiguracaoBannerCadastrar.class.getName()).log(Level.SEVERE, null, ex);
        }
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
