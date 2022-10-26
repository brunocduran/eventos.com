/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.pessoa;

import br.com.evento.dao.AdministradorDAO;
import br.com.evento.dao.FornecedorDAO;
import br.com.evento.dao.OrganizadorDAO;
import br.com.evento.dao.ParticipanteDAO;
import br.com.evento.dao.PatrocinadorDAO;
import br.com.evento.dao.PessoaDAO;
import br.com.evento.model.Administrador;
import br.com.evento.model.Fornecedor;
import br.com.evento.model.Organizador;
import br.com.evento.model.Participante;
import br.com.evento.model.Patrocinador;
import br.com.evento.model.Pessoa;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author bruno
 */
@WebServlet(name = "PessoaBuscarCpfCnpj", urlPatterns = {"/PessoaBuscarCpfCnpj"})
public class PessoaBuscarCpfCnpj extends HttpServlet {

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
            String cpfCnpj = request.getParameter("cpfcnpjpessoa");
            String tipoPessoa = request.getParameter("tipopessoa");
            int id= 0;
            String jsonRetorno = "";
            if(tipoPessoa.equals("administrador")){
                AdministradorDAO oAdmDAO = new AdministradorDAO();
                //busca Adm por cpf
                Administrador oAdm = (Administrador) oAdmDAO.carregar(oAdmDAO.verificarCpf(cpfCnpj));
                //gero retorno
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                jsonRetorno = gson.toJson(oAdm);
            }else if(tipoPessoa.equals("organizador")){
                OrganizadorDAO oOrganizadorDAO = new OrganizadorDAO();
                Organizador oOrganizador = (Organizador) oOrganizadorDAO.carregar(oOrganizadorDAO.verificarCpf(cpfCnpj));
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                jsonRetorno = gson.toJson(oOrganizador);
            }else if(tipoPessoa.equals("patrocinador")){
                PatrocinadorDAO oPatrocinadorDAO = new PatrocinadorDAO();
                Patrocinador oPatrocinador = (Patrocinador) oPatrocinadorDAO.carregar(oPatrocinadorDAO.verificarCpf(cpfCnpj));
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                jsonRetorno = gson.toJson(oPatrocinador);
            }else if(tipoPessoa.equals("fornecedor")){
                FornecedorDAO oFornecedorDAO = new FornecedorDAO();
                Fornecedor oFornecedor = (Fornecedor) oFornecedorDAO.carregar(oFornecedorDAO.verificarCpf(cpfCnpj));
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                jsonRetorno = gson.toJson(oFornecedor);
            }else if(tipoPessoa.equals("participante")){
                ParticipanteDAO oParticipanteDAO = new ParticipanteDAO();
                Participante oParticipante = (Participante) oParticipanteDAO.carregar(oParticipanteDAO.verificarCpf(cpfCnpj));
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                jsonRetorno = gson.toJson(oParticipante);
            }else{
                //não tem ADM, Cliente ou Fornecedor -- então verifica pessoa por CPF
                PessoaDAO oPessoaDAO = new PessoaDAO();
                Pessoa oPessoa = oPessoaDAO.carregarCpf(cpfCnpj);
                
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                jsonRetorno = gson.toJson(oPessoa);
            }
            
            response.setCharacterEncoding("iso-8859-1");
            response.getWriter().write(jsonRetorno);
        }catch(Exception ex){
            System.out.println("Problemas ao carregar pessoa por CPF/CNPJ! Erro: "+ex.getMessage());
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
