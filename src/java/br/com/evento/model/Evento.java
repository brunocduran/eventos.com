package br.com.evento.model;
import br.com.evento.utils.Conversao;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
/**
 *
 * @author igorb
 */
public class Evento {    
    private int idEvento;
    private String nomeEvento;
    private Double valorEvento;
    private Double valorEventoPrazo;
    private Date dataInicioEvento;
    private Date dataTerminoEvento;
    private String informacaoEvento;
    private String situacaoEvento;
    private String situacaoCaixa;
    private Double saldoCaixa;
    private String imagem;
    private Cidade cidade;
    private Curso curso;
    private CategoriaEvento categoriaEvento;
    private List<Organizador> organizadores;
    private List<AtividadeEvento> atividadesEvento;

    public Evento() {
        this.idEvento = 0;
        this.nomeEvento = "";
        this.valorEvento = 0.0;
        this.valorEventoPrazo = 0.0;
        this.dataInicioEvento = Conversao.dataAtual();
        this.dataTerminoEvento = Conversao.dataAtual();
        this.informacaoEvento = "";
        this.situacaoEvento = "A";
        this.situacaoCaixa = "A";
        this.saldoCaixa = 0.0;
        this.imagem = "";
        this.cidade = new Cidade();
        this.curso = new Curso();
        this.categoriaEvento = new CategoriaEvento();
        this.organizadores = null; // depois verificar se é isso mesmo
        this.atividadesEvento = null;
        
    }

    public Evento(int idEvento, String nomeEvento, Double valorEvento, Double valorEventoPrazo, Date dataInicioEvento, Date dataTerminoEvento, String informacaoEvento, String situacaoEvento, String situacaoCaixa, Double saldoCaixa, String imagem, Cidade cidade, Curso curso, CategoriaEvento categoriaEvento, List<Organizador> organizadores, List<AtividadeEvento> atividadesEvento) {
        this.idEvento = idEvento;
        this.nomeEvento = nomeEvento;
        this.valorEvento = valorEvento;
        this.valorEventoPrazo = valorEventoPrazo;
        this.dataInicioEvento = dataInicioEvento;
        this.dataTerminoEvento = dataTerminoEvento;
        this.informacaoEvento = informacaoEvento;
        this.situacaoEvento = situacaoEvento;
        this.situacaoCaixa = situacaoCaixa;
        this.saldoCaixa = saldoCaixa;
        this.imagem = imagem;
        this.cidade = cidade;
        this.curso = curso;
        this.categoriaEvento = categoriaEvento;
        this.organizadores = organizadores;
        this.atividadesEvento = atividadesEvento;
    }

    public int getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(int idEvento) {
        this.idEvento = idEvento;
    }

    public String getNomeEvento() {
        return nomeEvento;
    }

    public void setNomeEvento(String nomeEvento) {
        this.nomeEvento = nomeEvento;
    }

    public Double getValorEvento() {
        return valorEvento;
    }

    public void setValorEvento(Double valorEvento) {
        this.valorEvento = valorEvento;
    }

    public Double getValorEventoPrazo() {
        return valorEventoPrazo;
    }

    public void setValorEventoPrazo(Double valorEventoPrazo) {
        this.valorEventoPrazo = valorEventoPrazo;
    }

    public Date getDataInicioEvento() {
        return dataInicioEvento;
    }
    
    public String getDataInicioEventoFormatada() {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        return formato.format(dataInicioEvento);
    }

    public void setDataInicioEvento(Date dataInicioEvento) {
        this.dataInicioEvento = dataInicioEvento;
    }

    public Date getDataTerminoEvento() {
        return dataTerminoEvento;
    }
    
    public String getDataTerminoEventoFormatada() {
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
        return formato.format(dataTerminoEvento);
    }

    public void setDataTerminoEvento(Date dataTerminoEvento) {
        this.dataTerminoEvento = dataTerminoEvento;
    }

    public String getInformacaoEvento() {
        return informacaoEvento;
    }

    public void setInformacaoEvento(String informacaoEvento) {
        this.informacaoEvento = informacaoEvento;
    }

    public String getSituacaoEvento() {
        return situacaoEvento;
    }

    public void setSituacaoEvento(String situacaoEvento) {
        this.situacaoEvento = situacaoEvento;
    }

    public String getSituacaoCaixa() {
        return situacaoCaixa;
    }

    public void setSituacaoCaixa(String situacaoCaixa) {
        this.situacaoCaixa = situacaoCaixa;
    }

    public Double getSaldoCaixa() {
        return saldoCaixa;
    }

    public void setSaldoCaixa(Double saldoCaixa) {
        this.saldoCaixa = saldoCaixa;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public Cidade getCidade() {
        return cidade;
    }

    public void setCidade(Cidade cidade) {
        this.cidade = cidade;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public CategoriaEvento getCategoriaEvento() {
        return categoriaEvento;
    }

    public void setCategoriaEvento(CategoriaEvento categoriaEvento) {
        this.categoriaEvento = categoriaEvento;
    }

    public List<Organizador> getOrganizadores() {
        return organizadores;
    }

    public void setOrganizadores(List<Organizador> organizadores) {
        this.organizadores = organizadores;
    }

    public List<AtividadeEvento> getAtividadesEvento() {
        return atividadesEvento;
    }

    public void setAtividadesEvento(List<AtividadeEvento> atividadesEvento) {
        this.atividadesEvento = atividadesEvento;
    }

}
    