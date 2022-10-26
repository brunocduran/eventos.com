
package br.com.evento.controller.participante;

import br.com.evento.dao.ParticipanteDAO;
import br.com.evento.model.Cidade;
import br.com.evento.model.Participante;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ParticipanteCadastrar", urlPatterns = {"/ParticipanteCadastrar"})
public class ParticipanteCadastrar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=iso-8859-1");
        String mensagem = null;
        try{           
            
            int idPessoa = Integer.parseInt(request.getParameter("idpessoa"));
            int idParticipante = Integer.parseInt(request.getParameter("idparticipante"));
            String sexoParticipante = request.getParameter("sexoparticipante");
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
            
            
            Cidade oCidade = new Cidade();
            oCidade.setIdCidade(idCidade);
            
            
            Participante oParticipante = new Participante(idParticipante,sexoParticipante, "S", situacao,
                    idPessoa, nomeRazaoPessoa, rgIePessoa, cpfCnpjPessoa, dataNascFundPessoa, telefonePessoa, logradouroPessoa,
                    numLogradouroPessoa, bairroPessoa, cepPessoa, emailPessoa, login, senha, oCidade);
                
            ParticipanteDAO dao = new ParticipanteDAO();

            if(dao.cadastrar(oParticipante)){                
                response.getWriter().write("1");
            }else{                
                response.getWriter().write("0");
            }
        }catch(Exception e){
            System.out.println("Problemas no servelet Cadastrar Participante! Erro: "+e.getMessage());
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
