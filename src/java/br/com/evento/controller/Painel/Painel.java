/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.Painel;

import br.com.evento.dao.CursoDAO;
import br.com.evento.dao.DespesaDAO;
import br.com.evento.dao.DoacaoDAO;
import br.com.evento.dao.EventoDAO;
import br.com.evento.dao.FornecedorDAO;
import br.com.evento.dao.InstituicaoDAO;
import br.com.evento.dao.ParticipanteDAO;
import br.com.evento.dao.UsuarioDAO;
import br.com.evento.model.Instituicao;
import br.com.evento.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author igorb
 */
@WebServlet(name = "Painel", urlPatterns = {"/Painel"})
public class Painel extends HttpServlet {

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
        int qtdInstituicoes = 0;
        int qtdCursos = 0;
        int qtdParticipantes = 0;
        int qtdFornecedores = 0;
        int qtdEventos = 0;
        String totalDoacao = "";
        String totalDespesa = "";

        try {
            /*buscar quantidade de instituicoes*/
            InstituicaoDAO oInstituicaoDAO = new InstituicaoDAO();
            List<Object> lstInstituicoes = oInstituicaoDAO.listarAtivos();
            qtdInstituicoes = lstInstituicoes.size();

            /*buscar quantidade de cursos*/
            CursoDAO oCursoDAO = new CursoDAO();
            List<Object> lstCursos = oCursoDAO.listarAtivos();
            qtdCursos = lstCursos.size();

            /*buscar qtde de participantes*/
            ParticipanteDAO oParticipanteDAO = new ParticipanteDAO();
            List<Object> lstParticipantes = oParticipanteDAO.listarAtivos();
            qtdParticipantes = lstParticipantes.size();

            /*buscar qtde de fornecedores*/
            FornecedorDAO oFornecedorDAO = new FornecedorDAO();
            List<Object> lstFornecedores = oFornecedorDAO.listarAtivos();
            qtdFornecedores = lstFornecedores.size();

            /*buscar total de doacoes*/
            DoacaoDAO oDoacaoDAO = new DoacaoDAO();
            totalDoacao = oDoacaoDAO.buscarTotalDoacao();

            /*buscar total de despesa*/
            DespesaDAO oDespesaDAO = new DespesaDAO();
            totalDespesa = oDespesaDAO.buscarTotalDespesa();
            
            /*buscar eventos em andamento*/
            EventoDAO dao = new EventoDAO();
            int parametroListar = 0;

            HttpSession sessao = request.getSession();
            int idUsuario = Integer.parseInt(sessao.getAttribute("idusuario").toString());
            String tipoUsuario = sessao.getAttribute("tipousuario").toString();

            if (tipoUsuario.equalsIgnoreCase("Organizador")) {
                parametroListar = idUsuario;
            } else {
                parametroListar = 0;
            }
            List<Object> lstEventos = dao.listar(parametroListar);
            qtdEventos = lstEventos.size();

            
            request.getSession().setAttribute("qtdCursos", qtdCursos);
            request.getSession().setAttribute("qtdParticipantes", qtdParticipantes);
            request.getSession().setAttribute("qtdFornecedores", qtdFornecedores);
            request.getSession().setAttribute("qtdInstituicoes", qtdInstituicoes);
            /*novos adicionados*/
            request.getSession().setAttribute("qtdEventos", qtdEventos);
            request.getSession().setAttribute("totalDoacao", totalDoacao);
            request.getSession().setAttribute("totalDespesa", totalDespesa);

            request.getRequestDispatcher("/painel/home.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println("Problema no servlet ao listar instituicoes" + ex.getMessage());
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
