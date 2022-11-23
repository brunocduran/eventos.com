package br.com.evento.dao;

import br.com.evento.model.Cidade;
import br.com.evento.model.Doacao;
import br.com.evento.model.Evento;
import br.com.evento.model.Patrocinador;
import br.com.evento.model.Pessoa;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoacaoDAO implements GenericDAO {

    private Connection conexao;

    public DoacaoDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Doacao oDoacao = (Doacao) objeto;
        Boolean retorno = false;
        if (oDoacao.getIdDoacao() == 0) {
            retorno = this.inserir(oDoacao);
        } else {
            retorno = this.alterar(oDoacao);
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        Doacao oDoacao = (Doacao) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO doacao (valordoacao, datadoacao,descricao,idpatrocinador,idevento,situacao) "
                + "values (?,?,?,?,?,?)";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, oDoacao.getValorDoacao());
            stmt.setDate(2, new java.sql.Date(oDoacao.getDataDoacao().getTime()));
            stmt.setString(3, oDoacao.getDescricao());
            stmt.setInt(4, oDoacao.getPatrocinador().getIdPatrocinador());
            stmt.setInt(5, oDoacao.getEvento().getIdEvento());
            stmt.setString(6, oDoacao.getSituacao());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            try {
                System.out.println("Problemas ao cadastrar a Doação na DAO! Erro: " + ex.getMessage());
                ex.printStackTrace();
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public Boolean alterar(Object objeto) {
        Doacao oDoacao = (Doacao) objeto;
        PreparedStatement stmt = null;
        String sql = "update doacao set valordoacao=?, datadoacao=?, descricao=? ,"
                + " idpatrocinador=?, idevento=?   , situacao=?  where iddoacao = ? ";

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, oDoacao.getValorDoacao());
            stmt.setDate(2, new java.sql.Date(oDoacao.getDataDoacao().getTime()));
            stmt.setString(3, oDoacao.getDescricao());
            stmt.setInt(4, oDoacao.getPatrocinador().getIdPatrocinador());
            stmt.setInt(5, oDoacao.getEvento().getIdEvento());
            stmt.setString(6, oDoacao.getSituacao());
            stmt.setInt(7, oDoacao.getIdDoacao());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            try {
                System.out.println("Problemas ao alterar a Doação na DAO! Erro: " + ex.getMessage());
                ex.printStackTrace();
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro:" + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    public Boolean excluirAlterarStatus(int numero) {
        int idDoacao = numero;
        PreparedStatement stmt = null;
        String sql = "update doacao set situacao =? where iddoacao=?";
        try {
            Doacao oDoacao = (Doacao) this.carregar(idDoacao);
            stmt = conexao.prepareStatement(sql);
            if (oDoacao.getSituacao().equals("A")) {
                stmt.setString(1, "P");//se situacao atual for Ativa --> Inativar
            } else {
                stmt.setString(1, "A");//se situacao atual for Inativo --> Ativar
            }
            stmt.setInt(2, idDoacao);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problemas ao excluir a Doacao na DAO! Erro: " + ex.getMessage());
            try {
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro rollback " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idDoacao = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Doacao oDoacao = null;
        String sql = "select * from doacao where iddoacao=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idDoacao);
            rs = stmt.executeQuery();
            while (rs.next()) {
                oDoacao = new Doacao();
                oDoacao.setIdDoacao(rs.getInt("iddoacao"));
                oDoacao.setValorDoacao(rs.getDouble("valordoacao"));
                oDoacao.setDataDoacao(rs.getDate("datadoacao"));
                oDoacao.setDescricao(rs.getString("descricao"));
                oDoacao.setSituacao(rs.getString("situacao"));

                PatrocinadorDAO oPatrocinadorDAO = new PatrocinadorDAO();
                oDoacao.setPatrocinador((Patrocinador) oPatrocinadorDAO.carregar(rs.getInt("idpatrocinador")));

                EventoDAO oEventoDAO = new EventoDAO();
                oDoacao.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

            }
            return oDoacao;
        } catch (Exception ex) {
            System.out.println("Problemas ao carregar Doação na DAO! Erro:" + ex.getMessage());
            return false;
        }
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select * from doacao order by iddoacao";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Doacao oDoacao = new Doacao();
                oDoacao.setIdDoacao(rs.getInt("iddoacao"));
                oDoacao.setValorDoacao(rs.getDouble("valordoacao"));
                oDoacao.setDataDoacao(rs.getDate("datadoacao"));
                oDoacao.setDescricao(rs.getString("descricao"));
                oDoacao.setSituacao(rs.getString("situacao"));

                PatrocinadorDAO oPatrocinadorDAO = null;
                EventoDAO oEventoDAO = null;

                try {

                    oPatrocinadorDAO = new PatrocinadorDAO();
                    oEventoDAO = new EventoDAO();
                } catch (Exception ex) {
                    System.out.println("Erro buscar Patrocinador " + ex.getMessage());
                    ex.printStackTrace();
                }
                oDoacao.setPatrocinador((Patrocinador) oPatrocinadorDAO.carregar(rs.getInt("idpatrocinador")));
                oDoacao.setEvento((Evento) oEventoDAO.carregar(rs.getInt("idevento")));

                resultado.add(oDoacao);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar Doação na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

    @Override
    public Boolean excluir(int numero) {
        int idDoacao = numero;
        PreparedStatement stmt = null;

        String sql = "delete from doacao where iddoacao=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idDoacao);
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception ex) {
            System.out.println("Problemas ao excluir a Doacao! Erro: " + ex.getMessage());

            try {
                conexao.rollback();
            } catch (SQLException e) {
                System.out.println("Erro rolback " + e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }
}
