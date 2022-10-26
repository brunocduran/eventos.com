
package br.com.evento.controller.patrocinador;

import br.com.evento.controller.patrocinador.*;
import br.com.evento.dao.PatrocinadorDAO;
import br.com.evento.model.Cidade;
import br.com.evento.model.Patrocinador;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PatrocinadorCadastrar", urlPatterns = {"/PatrocinadorCadastrar"})
public class PatrocinadorCadastrar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=iso-8859-1");
        String mensagem = null;
        try{           
            //busca parametros do formulario (ajax) - view
            int idPessoa = Integer.parseInt(request.getParameter("idpessoa"));
            int idPatrocinador = Integer.parseInt(request.getParameter("idpatrocinador"));
            String situacao = request.getParameter("situacao");
            String cpfCnpjPessoa = request.getParameter("cpfcnpjpessoa");
            String rgIePessoa = request.getParameter("rgiepessoa");
            String nomeRazaoPessoa = request.getParameter("nomerazaopessoa");
            Date dataNascFundPessoa = Date.valueOf(request.getParameter("datanascfundpessoa"));
            String telefonePessoa = request.getParameter("telefonepessoa");
            String logradouroPessoa = request.getParameter("logradouropessoa");
            String numLogradouroPessoa = request.getParameter("numlogradouropessoa");
            String bairroPessoa = request.getParameter("bairropessoa");
            String cepPessoa = request.getParameter("ceppessoa");
            String emailPessoa = request.getParameter("emailpessoa");
            String login = request.getParameter("login");
            String senha = request.getParameter("senha");
            int idCidade = Integer.parseInt(request.getParameter("idcidade"));
            
            //cria objeto de cidade.
            Cidade oCidade = new Cidade();
            oCidade.setIdCidade(idCidade);
            
            //gera objeto de Patrocinador
            Patrocinador oPatrocinador = new Patrocinador(idPatrocinador, "N", situacao,
                    idPessoa, nomeRazaoPessoa, rgIePessoa, cpfCnpjPessoa, dataNascFundPessoa, telefonePessoa, logradouroPessoa,
                    numLogradouroPessoa, bairroPessoa, cepPessoa, emailPessoa, login, senha, oCidade);
            //instancia camada dao de patrocinador    
            PatrocinadorDAO dao = new PatrocinadorDAO();

            if(dao.cadastrar(oPatrocinador)){
                //mensagem = "Cadastrado com Sucesso!";
                response.getWriter().write("1");
            }else{
                //mensagem = "Problemas ao cadastrar Despesa!";
                response.getWriter().write("0");
            }
        }catch(Exception e){
            System.out.println("Problemas no servelet Cadastrar Patrocinador! Erro: "+e.getMessage());
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
