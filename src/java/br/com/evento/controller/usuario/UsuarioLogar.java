/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.usuario;

import br.com.evento.dao.UsuarioDAO;
import br.com.evento.model.Usuario;
import com.google.gson.Gson;
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
@WebServlet(name = "UsuarioLogar", urlPatterns = {"/UsuarioLogar"})
public class UsuarioLogar extends HttpServlet {

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
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        String tipo = request.getParameter("tipo");
       // System.out.println("***PASSOU POR AQUI ****");
       // System.out.println("Tipo vindo do parametro: "+tipo);
        String usuarioLogado = "";
        String retornar = "";
        
        try{
            UsuarioDAO oUsuarioDAO = new UsuarioDAO(); 
            List<Usuario> lstUsuarios = oUsuarioDAO.listar(login, senha);
            
             /*se nao retornar nenhum é porque o login e ou senha estao incorretos*/
            if(lstUsuarios.size() == 0){
                usuarioLogado = "0";  
                retornar = usuarioLogado;
            }
              
            //se a lista de usuario e senha retornar somente 1 usuario, ja loga pois nao precisa definir o tipo
            // se a lista tiver mais que um usuario, mas for retornado algum tipo, quer dizer que o usuario ja selecionou entao pode tentar logar
            if ((lstUsuarios.size() == 1) || ((lstUsuarios.size() > 1) && (!tipo.equals("")))){
            //cria a sessao no contexto do sistema 
           Usuario oUsuario = oUsuarioDAO.logar(login, senha, tipo);
           
            if (oUsuario != null){
                 HttpSession sessao = request.getSession();
                 sessao.setAttribute("idusuario", oUsuario.getId());
                 sessao.setAttribute("nomeusuario", oUsuario.getNomerazaopessoa());
                 sessao.setAttribute("tipousuario", oUsuario.getTipo());
                 usuarioLogado = "ok";              
            }else{
                usuarioLogado = "1";
            }
            retornar = usuarioLogado;
            }
            
            /*se retornar mais de um objeto na lista e ainda nao tiver passado o tipo como parametro - gera o json dos usuarios pra montar o select na view*/
            if ((lstUsuarios.size() > 1) && (tipo.equals(""))){            
                Gson gson = new Gson();
                String jsonUsuario = gson.toJson(lstUsuarios);
                response.setCharacterEncoding("iso-8859-1");
                retornar = jsonUsuario; 
            }
            
            response.getWriter().write(retornar);
            
        
        }catch(Exception ex){
            System.out.println("Problema no servlet UsuarioBuscarLoginSenha! Erro: "+ex.getMessage());
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
