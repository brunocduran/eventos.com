/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.curso;

import br.com.evento.dao.CursoDAO;
import br.com.evento.model.Curso;
import br.com.evento.model.Instituicao;
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
@WebServlet(name = "CursoCadastrar", urlPatterns = {"/CursoCadastrar"})
public class CursoCadastrar extends HttpServlet {

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
           //busca parametros do formulario ajax - view
           int idCurso = Integer.parseInt(request.getParameter("idCurso"));
           String nomeCurso = request.getParameter("nomeCurso");
           String situacao = request.getParameter("situacao");
           int idInstituicao = Integer.parseInt(request.getParameter("idInstituicao"));
    
           //cria objeto de instituicao
           Instituicao oInstituicao = new Instituicao();
           oInstituicao.setIdInstituicao(idInstituicao);
          
           //gera objeto de curso
           Curso oCurso = new Curso(idCurso, nomeCurso, situacao, oInstituicao);
           
           //instancia camada dao de cliente
           CursoDAO dao = new CursoDAO();
           
           if (dao.cadastrar(oCurso)){
               response.getWriter().write("1");
           }else{
               response.getWriter().write("0");
           }
           
       }catch(Exception e){
           System.out.println("Problemas no servlet cadastrar curso Erro: "+e.getMessage());
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
