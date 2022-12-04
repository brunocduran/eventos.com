/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.evento.controller.evento;

import br.com.evento.dao.EventoDAO;
import br.com.evento.dao.OrganizadorEventoDAO;
import br.com.evento.model.CategoriaEvento;
import br.com.evento.model.Cidade;
import br.com.evento.model.Curso;
import br.com.evento.model.Evento;
import br.com.evento.model.Funcao;
import br.com.evento.model.Organizador;
import br.com.evento.model.OrganizadorEvento;
import br.com.evento.utils.Conversao;
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
import javax.servlet.http.HttpSession;

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
        try {
            Evento oEvento = new Evento();
            int idEvento = Integer.parseInt(request.getParameter("idEvento"));
            oEvento.setIdEvento(idEvento);
            oEvento.setNomeEvento(request.getParameter("nomeEvento"));
            oEvento.setValorEvento(Conversao.valorDinheiro(request.getParameter("valorEvento")));
            oEvento.setValorEventoPrazo(Conversao.valorDinheiro(request.getParameter("valorEventoPrazo")));
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

            int idEventoAtual = dao.cadastrar(oEvento);
           
            //busca os dados da sessao
            HttpSession sessao = request.getSession();
            int idUsuario = Integer.parseInt(sessao.getAttribute("idusuario").toString());
            String tipoUsuario = sessao.getAttribute("tipousuario").toString();

            if (idEventoAtual > 0) {
                
                // se for a primeira inserção do evento (nao for alteracao) vincular o organizador que está cadastrando
                if ((idEvento == 0) && (tipoUsuario.equalsIgnoreCase("Organizador"))) {
                    try {
                        OrganizadorEvento oOrganizadorEvento = new OrganizadorEvento();
                        oOrganizadorEvento.setIdOrganizadorEvento(0);
                        int idOrganizador = idUsuario;
                        int idFuncao = 1; // passa funcao padrao 1
                        int idOrganizadorEvento = 0;
                       

                        //cria objeto de evento.
                        Evento oEventoOrganizador = new Evento();
                        oEventoOrganizador.setIdEvento(idEventoAtual);
                        oOrganizadorEvento.setEvento(oEventoOrganizador);

                        //cria o objeto de organizador
                        Organizador oOrganizador = null;
                        oOrganizador = oOrganizador.organizadorVazio();
                        //oOrganizador.organizadorVazio();
                        oOrganizador.setIdOrganizador(idOrganizador);
                        oOrganizadorEvento.setOrganizador(oOrganizador);

                        //cria o objeto de funcao
                        Funcao oFuncao = new Funcao();
                        oFuncao.setIdFuncao(idFuncao);
                        oOrganizadorEvento.setFuncao(oFuncao);

                        OrganizadorEventoDAO daoEventoOrganizador = new OrganizadorEventoDAO();
                        idOrganizadorEvento = daoEventoOrganizador.cadastrar(oOrganizadorEvento);

                        if (idOrganizadorEvento > 0) {
                            System.out.println("Organizador Evento Cadastrado com sucesso");
                        } else {
                            System.out.println("Deu erro ao cadastrar organizador evento");
                        }
                    } catch (Exception ex) {
                        System.out.println("Problemas no servlet Evento Cadastrar - ao cadastrar o organizador pela primeira vez! Erro: " + ex.getMessage());
                        ex.printStackTrace();
                    }
                }

                Evento oEventoAtual = (Evento) dao.carregar(idEventoAtual);
                Gson ogson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
                String jSon = ogson.toJson(oEventoAtual);
                response.getWriter().write(jSon);
            } else {
                response.getWriter().write("0");
            }
        } catch (Exception ex) {
            System.out.println("Problemas no servlet cadastrar evento! Erro: " + ex.getMessage());
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
