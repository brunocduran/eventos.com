package br.com.evento.filter;

import br.com.evento.model.Usuario;
import br.com.evento.utils.SingleConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/*"})
public class FilterAutenticacao implements Filter {

    private static Connection conexao;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            //pega a sessao vigente no contexto do servidor
            HttpSession sessao = req.getSession(false);
            String urlParaAutenticar = req.getServletPath(); //url que está sendo acessada

            if ((sessao != null && sessao.getAttributeNames().hasMoreElements())
                    || (urlParaAutenticar.contains("/home/")
                    || urlParaAutenticar.contains("/painel/js/")
                    || urlParaAutenticar.contains("/painel/plugins/")
                    || urlParaAutenticar.contains("/painel/css/")
                    || urlParaAutenticar.contains("/painel/img/")
                    || urlParaAutenticar.contains("/painel/calendarioeventos.jsp")
                    || urlParaAutenticar.contains("/painel/webfonts/")
                    || urlParaAutenticar.equalsIgnoreCase("/UsuarioLogar")
                    || urlParaAutenticar.equalsIgnoreCase("/Home")
                    || urlParaAutenticar.equalsIgnoreCase("/Painel/login.jsp")
                    || urlParaAutenticar.equalsIgnoreCase("/ParticipanteCadastrar")
                    || urlParaAutenticar.equalsIgnoreCase("/PessoaBuscarCpfCnpj")
                    || urlParaAutenticar.contains("/PessoaVerificarLogin")
                    || urlParaAutenticar.equalsIgnoreCase("/CidadeBuscarPorEstado")
                    || urlParaAutenticar.equalsIgnoreCase("/Cadastrar")
                    || urlParaAutenticar.equalsIgnoreCase("/EventoCarregarHome")
                    || urlParaAutenticar.equalsIgnoreCase("/Home")
                    || urlParaAutenticar.equalsIgnoreCase("/HomeEventoCategoria")
                    || urlParaAutenticar.equalsIgnoreCase("/HomeEventoDescricao")
                    || urlParaAutenticar.equalsIgnoreCase("/EnviarContato")
                    || urlParaAutenticar.equalsIgnoreCase("/ContatoNovo")
                    || urlParaAutenticar.equalsIgnoreCase("/index.jsp"))) {

                // valida controle de usuario
                if (Usuario.verificaUsuario(urlParaAutenticar, sessao)) {
                    // passou pela validacao de seguranca encaminha para execucao
                    chain.doFilter(request, response);
                } else {
                    // se a sessao for nula volta pra tela sem logar
                    request.getRequestDispatcher("painel/home.jsp").forward(request, response);

                    return; // para a executação e redireciona para o index.jsp    
                }

            } else {
                // se a sessao for nula volta pra tela sem logar
                request.getRequestDispatcher("/Home").forward(request, response);
                return; // para a executação e redireciona para o index.jsp
            }
        } catch (Exception e) {
            System.out.println("Erro no do filter ! Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        try {
            conexao.close();
        } catch (SQLException ex) {
            System.out.println("Erro destroy: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

}
