
package br.com.evento.dao;

import br.com.evento.model.Cidade;
import br.com.evento.model.Patrocinador;
import br.com.evento.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PatrocinadorDAO implements GenericDAO {

    private Connection conexao;

    public PatrocinadorDAO() throws Exception {
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Boolean retorno = false;
        try {
            Patrocinador oPatrocinador = (Patrocinador) objeto;
            if (oPatrocinador.getIdPatrocinador()== 0) {//inserção
                //verifica se já existe pessoa com este CPF cadastrada.
                int idPatrocinador = this.verificarCpf(oPatrocinador.getCpfCnpjPessoa());
                if (idPatrocinador == 0) {
                    //se não encontrou insere
                    retorno = this.inserir(oPatrocinador);
                } else {
                    //se encontrou patrocinador com o cpf altera
                    oPatrocinador.setIdPatrocinador(idPatrocinador);
                    retorno = this.alterar(oPatrocinador);
                }
            } else {
                retorno = this.alterar(oPatrocinador);
            }
        } catch (Exception ex) {
            System.out.println("Problmas ao incluir Patrocinador na DAO! Erro " + ex.getMessage());
        }
        return retorno;
    }

    public int verificarCpf(String cpf) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int idPatrocinador = 0;
        String sql = "select Pa.* from Patrocinador Pa, pessoa p where Pa.idpessoa = p.idpessoa and p.cpfcnpjpessoa=?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpf);
            rs = stmt.executeQuery();
            while (rs.next()) {
                idPatrocinador = rs.getInt("idPatrocinador");
            }
            return idPatrocinador;
        } catch (SQLException ex) {
            System.out.println("Problemas ao carregar pessoa no PatrocinadorDAO! Erro: " + ex.getMessage());
            return idPatrocinador;
        }
    }

    @Override
    public Boolean inserir(Object objeto) {
        Patrocinador oPatrocinador = (Patrocinador) objeto;
        PreparedStatement stmt = null;
        String sql = "INSERT INTO patrocinador(idpessoa, situacao, permitelogin) VALUES (?, ?, ?);";
        try {
            PessoaDAO oPessoaDAO = new PessoaDAO();
            //manda informções para o cadastrar de pessoa.
            int idPessoa = oPessoaDAO.cadastrar(oPatrocinador);
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idPessoa);
            stmt.setString(2, "A");
            stmt.setString(3, "N");
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problemas ao cadastrar Patrocinador na DAO! Erro:" + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        Patrocinador oPatrocinador = (Patrocinador) objeto;
        PreparedStatement stmt = null;
        String sql = "UPDATE patrocinador SET permitelogin=? WHERE idpatrocinador=?;";
        try {
            PessoaDAO oPessoaDAO = new PessoaDAO();
            oPessoaDAO.cadastrar(oPatrocinador); //envia para classe PessoaDAO
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oPatrocinador.getPermiteLogin());
            stmt.setInt(2, oPatrocinador.getIdPatrocinador());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao alterar Patrocinador na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean excluir(int numero) {
        PreparedStatement stmt = null;
        try {
            //carrega dados de admintrador
            PatrocinadorDAO oPatrocinadorDAO = new PatrocinadorDAO();
            Patrocinador oPatrocinador = (Patrocinador) oPatrocinadorDAO.carregar(numero);
            String situacao = "A";//verifica e troca a situação do Patrocinador
            if (oPatrocinador.getSituacao().equals(situacao)) {
                situacao = "I";
            } else {
                situacao = "A";
            }

            String sql = "UPDATE Patrocinador SET situacao=? WHERE idPatrocinador=?;";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, situacao);
            stmt.setInt(2, oPatrocinador.getIdPatrocinador());
            stmt.execute();
            conexao.commit();
            return true;
        } catch (Exception e) {
            try {
                System.out.println("Problema ao excluir Patrocinador na DAO! Erro: " + e.getMessage());
                e.printStackTrace();
                conexao.rollback();
            } catch (SQLException ex) {
                System.out.println("Problemas ao executar rollback " + ex.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idPatrocinador = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Patrocinador oPatrocinador = null;
        String sql = "select * from Patrocinador Pa, pessoa p where Pa.idpessoa = p.idpessoa and Pa.idPatrocinador = ?";
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idPatrocinador);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //busca cidade
                Cidade oCidade = null;
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar cidade da PatrocinadorDAO! Erro " + ex.getMessage());
                }

                oPatrocinador = new Patrocinador(rs.getInt("idPatrocinador"),
                        rs.getString("permitelogin"),
                        rs.getString("situacao"),
                        rs.getInt("idpessoa"),
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade);
            }
        } catch (SQLException e) {
            System.out.println("Problemas ao carregar Patrocinador na DAO! Erro " + e.getMessage());
            e.printStackTrace();
        }
        return oPatrocinador;
    }

    @Override
    public List<Object> listar() {
        List<Object> resultado = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "select p.*, Pa.idPatrocinador, Pa.situacao, Pa.permitelogin from Patrocinador Pa, pessoa p where Pa.idpessoa = p.idpessoa order by idpessoa";
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Cidade oCidade = null;//busca cidade
                try {
                    CidadeDAO oCidadeDAO = new CidadeDAO();
                    oCidade = (Cidade) oCidadeDAO.carregar(rs.getInt("idcidade"));
                } catch (Exception ex) {
                    System.out.println("Problemas ao carregar cidade no PatrocinadorDAO! Erro: " + ex.getMessage());
                }
                Patrocinador oPatrocinador = new Patrocinador(rs.getInt("idPatrocinador"),
                        rs.getString("permitelogin"),
                        rs.getString("situacao"),
                        rs.getInt("idpessoa"),
                        rs.getString("nomerazaopessoa"),
                        rs.getString("rgiepessoa"),
                        rs.getString("cpfcnpjpessoa"),
                        rs.getDate("datanascfundpessoa"),
                        rs.getString("telefonepessoa"),
                        rs.getString("logradouropessoa"),
                        rs.getString("numlogradouropessoa"),
                        rs.getString("bairropessoa"),
                        rs.getString("ceppessoa"),
                        rs.getString("emailpessoa"),
                        rs.getString("login"),
                        rs.getString("senha"),
                        oCidade);
                resultado.add(oPatrocinador);
            }
        } catch (SQLException ex) {
            System.out.println("Problemas ao listar Patrocinador na DAO! Erro: " + ex.getMessage());
        }
        return resultado;
    }

   

}
