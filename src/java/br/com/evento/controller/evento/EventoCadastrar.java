/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.evento;

import br.com.evento.dao.EventoDAO;
import br.com.evento.model.CategoriaEvento;
import br.com.evento.model.Cidade;
import br.com.evento.model.Curso;
import br.com.evento.model.Evento;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
 * @author igorb
 */
@WebServlet(name = "EventoCadastrar", urlPatterns = {"/EventoCadastrar"})
public class EventoCadastrar extends HttpServlet {

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
            Evento oEvento = new Evento();
            oEvento.setIdEvento(Integer.parseInt(request.getParameter("idEvento")));
            oEvento.setNomeEvento(request.getParameter("nomeEvento"));
            oEvento.setValorEvento(Double.parseDouble(request.getParameter("valorEvento")));
            oEvento.setValorEventoPrazo(Double.parseDouble(request.getParameter("valorEventoPrazo")));
            oEvento.setDataInicioEvento(Date.valueOf(request.getParameter("dataInicioEvento")));
            oEvento.setDataTerminoEvento(Date.valueOf(request.getParameter("dataTerminoEvento")));
            oEvento.setSituacaoEvento(request.getParameter("situacaoEvento"));
            oEvento.setSaldoCaixa(Double.parseDouble(request.getParameter("saldoCaixa")));
            oEvento.setSituacaoCaixa(request.getParameter("situacaoCaixa"));
            oEvento.setImagem(request.getParameter("imagem"));
            oEvento.setInformacaoEvento(request.getParameter("informacaoEvento"));            
            int idCidade = Integer.parseInt(request.getParameter("idCidade"));
            int idCurso = Integer.parseInt(request.getParameter("idCurso"));
            int idCategoriaEvento = Integer.parseInt(request.getParameter("idCategoriaEvento"));
            
                    
            
            //cria objeto de cidade.
            Cidade oCidade = new Cidade();
            oCidade.setIdCidade(idCidade);
                    
            oEvento.setCidade(oCidade);
            
            //cria o objeto de curso
            Curso oCurso = new Curso();
            oCurso.setIdCurso(idCurso);
            
            oEvento.setCurso(oCurso);
            
            //cria o objeto de categoriaevento
            CategoriaEvento oCategoriaEvento = new CategoriaEvento();
            oCategoriaEvento.setIdCategoriaEvento(idCategoriaEvento);
            
            oEvento.setCategoriaEvento(oCategoriaEvento);          
            
            EventoDAO dao = new EventoDAO();
            
            if (dao.cadastrar(oEvento)){
                //response.getWriter().write("1");
                Evento oUltimoEvento = (Evento) dao.carregarUltimoInserido();            
                Gson ogson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                String jSon = ogson.toJson(oUltimoEvento);
               // System.out.println("JSON DO ULTIMO INSERIDO: "+jSon);
                response.getWriter().write(jSon);   
            }else{
                response.getWriter().write("0");
            }
        }catch(Exception ex){
            System.out.println("Problemas no servlet cadastrar evento! Erro: "+ex.getMessage());
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
