<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<jsp:include page="/painel/header.jsp"/>

<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <div class="card shadow">
                <div class="card-body">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="container-fluid"> <!--inicio div da imagem, detalhes evento e detalhes atividade -->    

                                    <div class="row"> <!--inicio div da imagem e detalhes-->

                                        <div class="col-md-auto"> <!--inicio da imagem-->
                                            <img  width="380" height="380" src="${evento.imagem}" alt="imagem" name="target" id="target">                
                                        </div> <!--final da imagem-->

                                        <div class="col"><!--inicio dos detalhes evento-->
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h3><b>${evento.nomeEvento}</b></h3>
                                                        <hr>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="form-line row">

                                                    <!--inicio - informação que não aparece na tela-->
                                                    <input class="form-control" 
                                                           type="hidden"
                                                           name="idevento" id="idevento"
                                                           value="${evento.idEvento}" readonly="readonly">
                                                    <input class="form-control" type="hidden" name="situacaoevento" id="situacaoevento"
                                                           value="${evento.situacaoEvento}" readonly="readonly">
                                                    <input class="form-control" type="hidden" name="saldocaixa" id="saldocaixa"
                                                           value="${evento.saldoCaixa}" readonly="readonly">
                                                    <input class="form-control" type="hidden" name="situacaocaixa" id="situacaocaixa"
                                                           value="${evento.situacaoCaixa}" readonly="readonly">
                                                    <!--final - informação que não aparece na tela-->

                                                    <div class="col-sm">
                                                        <h5><b>Data Início:</b> <fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataInicioEvento}"/></h5>
                                                                                         
                                                                                  
                                                    </div>
                                                    <div class="col-sm">
                                                        <h5><b>Data Término:</b> <fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataTerminoEvento}"/></h5>                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">                    
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h5><b>Valor à vista:</b> <fmt:formatNumber value="${evento.valorEvento}" type="currency"/></h5>                            
                                                    </div>
                                                    <div class="col-sm">
                                                        <h5><b>Valor a prazo:</b> <fmt:formatNumber value="${evento.valorEventoPrazo}" type="currency"/></h5>                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line row">

                                                    <div class="col-sm">
                                                        <h5><b>Cidade:</b> ${evento.cidade.nomeCidade}</h5>                            
                                                    </div>
                                                    <div class="col-sm">
                                                        <h4>Curso:
                                                            <small class="text-muted">                                    
                                                                ${evento.curso.nomeCurso}
                                                            </small>                                
                                                        </h4>                            
                                                    </div>                          
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h4>Categoria:
                                                            <small class="text-muted">                                    
                                                                ${evento.categoriaEvento.nome}
                                                            </small>                                
                                                        </h4>                            
                                                    </div>                      
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h4>Informações:</h4> 
                                                        <small class="text-muted">${evento.informacaoEvento}</small> 
                                                    </div>                        
                                                </div>
                                            </div> 
                                        </div><!--final dos detalhes evento-->

                                    </div><!--final div da imagem e detalhes-->

                                    <div class="row"><!--inicio div da detalhes atividade -->
                                        <div class="col">
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <hr>
                                                        <h3>Atividades</h3>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-content">
                                                <div id="espacoaddatividadeevento">
                                                    <!-- Loop para carregar as atividades-->
                                                    <c:forEach var="atividadeEvento" items="${atividadesEvento}">                            
                                                        <div id="divAtv_${atividadeEvento.idAtividadeEvento}">
                                                            <div class="form-group"></div>
                                                            <div class="form-line row">
                                                                <div class="col-sm">
                                                                    <div class="input-group input-group-mb-3">
                                                                        <div style="background-color: #E9ECEF; width: 100%; border-color: #cacbcc; border-width: 1px; border-style: solid; padding: 10px;">
                                                                            <b>Atividade:</b> ${atividadeEvento.nomeAtividade} <br>
                                                                            <b>Data:</b> ${atividadeEvento.dataAtividadeFormatada}<br>
                                                                            <b>Hora:</b> ${atividadeEvento.horaAtividade}<br>
                                                                            <b>Carga horária:</b> ${atividadeEvento.cargaHoraria}<br>
                                                                            <b>Tipo de Atividade:</b> ${atividadeEvento.tipoAtividade.descricao}<br>
                                                                            <b>Resumo:</b> ${atividadeEvento.resumo}                                                
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>                            
                                                    </c:forEach> 
                                                </div>                    
                                            </div>
                                        </div>
                                    </div><!--inicio div da detalhes atividade -->

                                </div><!--final div da imagem, detalhes evento e detalhes atividade -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style type="text/css">
    .inputfile{
        /* visibility: hidden etc. wont work */
        width: 0.5px;
        height: 0.1px;
        opacity: 0;
        overflow: hidden;
        position: absolute;
        z-index: -1;}
    .inputfile:focus + label{
        /* keyboard navigation */
        outline: 1px dotted #000;
        outline: -webkit-focus-ring-color auto 5px;}
    .inputfile + label * {
        pointer-events: none;}
    .borda{
        position: relative;
        margin: 0 20px 30px 0;
        padding: 10px;
        border: 1px solid #e1e1e1;
        border-radius: 3px;
        background: #fff;
        -webkit-box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
        -moz-box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
        box-shadow: 0px 0px 3px rgba(0,0,0,0.06);}
</style>

<script>

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Evento</strong>";
        document.getElementById('menuevento').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<jsp:include page="/painel/footer.jsp"/>