/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.atividadeEvento;

import br.com.evento.dao.AtividadeEventoDAO;
import br.com.evento.model.AtividadeEvento;
import br.com.evento.model.Evento;
import br.com.evento.model.TipoAtividade;
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
 * @author bruno
 */
@WebServlet(name = "AtividadeEventoCadastrar", urlPatterns = {"/AtividadeEventoCadastrar"})
public class AtividadeEventoCadastrar extends HttpServlet {

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
        int idAtividadeEvento = 0;
        try{
            AtividadeEvento oAtividadeEvento = new AtividadeEvento();
            oAtividadeEvento.setIdAtividadeEvento(Integer.parseInt(request.getParameter("idAtividadeEvento")));
            Double cargaHoraria = Double.parseDouble(request.getParameter("cargaHoraria"));
            String nomeAtividade = request.getParameter("nomeAtividade");
            String resumo = request.getParameter("resumo");
            Date dataAtividade = Date.valueOf(request.getParameter("dataAtividade"));
            String horaAtividade = request.getParameter("horaAtividade");
            int idTipoAtividade = Integer.parseInt(request.getParameter("idTipoAtividade"));
            int idEvento = Integer.parseInt(request.getParameter("idEvento"));
            
            //cria objeto de evento.
            Evento oEvento = new Evento();
            oEvento.setIdEvento(idEvento);                    
            
            //cria objeto de tipo atividade.
            TipoAtividade oTipoAtividade = new TipoAtividade();
            oTipoAtividade.setIdTipoAtividade(idTipoAtividade);
            
            oAtividadeEvento.setCargaHoraria(cargaHoraria);
            oAtividadeEvento.setNomeAtividade(nomeAtividade);
            oAtividadeEvento.setResumo(resumo);
            oAtividadeEvento.setDataAtividade(dataAtividade);
            oAtividadeEvento.setHoraAtividade(horaAtividade);
            oAtividadeEvento.setEvento(oEvento);
            oAtividadeEvento.setTipoAtividade(oTipoAtividade);
                             
            AtividadeEventoDAO dao = new AtividadeEventoDAO();         
            idAtividadeEvento = dao.cadastrar(oAtividadeEvento);
            
            if (idAtividadeEvento > 0){
                AtividadeEvento oAtividadeEventoCadastrado = (AtividadeEvento) dao.carregar(idAtividadeEvento);
                Gson ogson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                String jSon = ogson.toJson(oAtividadeEventoCadastrado);
                response.getWriter().write(jSon);   
            }else{
                response.getWriter().write("0");
            }
        }catch(Exception ex){
            System.out.println("Problemas no servlet AtividadeEventoCadastrar! Erro: "+ex.getMessage());
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
