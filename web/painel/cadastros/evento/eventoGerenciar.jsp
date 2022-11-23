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
                                                        <h4><b>Data início:</b> <fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataInicioEvento}"/></h4>                        
                                                    </div>
                                                    <div class="col-sm">
                                                        <h4><b>Data término:</b> <fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataTerminoEvento}"/></h4>                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">                    
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h4><b>Valor à vista:</b> <fmt:formatNumber value="${evento.valorEvento}" type="currency"/></h4>                            
                                                    </div>
                                                    <div class="col-sm">
                                                        <h4><b>Valor a prazo:</b> <fmt:formatNumber value="${evento.valorEventoPrazo}" type="currency"/></h4>                            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line row">

                                                    <div class="col-sm">
                                                        <h4><b>Cidade:</b> ${evento.cidade.nomeCidade} - ${evento.cidade.estado.siglaEstado}</h4>                            
                                                    </div>
                                                    <div class="col-sm">
                                                        <h4><b>Curso:</b> ${evento.curso.nomeCurso}</h4>                            
                                                    </div>                          
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h4><b>Categoria:</b> ${evento.categoriaEvento.nome}</h4>                            
                                                    </div>                      
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h4><b>Informações:</b> ${evento.informacaoEvento}</h4>
                                                    </div>                        
                                                </div>
                                            </div> 
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <h4><b>Status:</b>
                                                            <l id="status">
                                                                <c:if test="${evento.situacaoEvento == 'A'}">
                                                                    Ativo
                                                                </c:if>

                                                                <c:if test="${evento.situacaoEvento == 'I'}">
                                                                    Inativo
                                                                </c:if>

                                                                <c:if test="${evento.situacaoEvento == 'E'}">
                                                                    Encerrado
                                                                </c:if>

                                                                <c:if test="${evento.situacaoEvento == 'F'}">
                                                                    Finalizado
                                                                </c:if> 
                                                            </l>
                                                        </h4>
                                                    </div>                        
                                                </div>
                                            </div> 
                                        </div><!--final dos detalhes evento-->
                                    </div><!--final div da imagem e detalhes-->
                                    <div class="row"><!--inicio div da detalhes organizador -->
                                        <div class="col">
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <hr>
                                                        <h3><b><a data-toggle="collapse" href="#collapseOrganizador" aria-expanded="false" aria-controls="collapseOrganizador" style="color: black;">
                                                                    Organizadores <i class="fas fa-caret-down"></i>
                                                                </a>
                                                            </b>
                                                        </h3>
                                                        <div class="tab-content collapse multi-collapse" id="collapseOrganizador">
                                                            <div id="espacoaddatividadeevento">
                                                                <!-- Loop para carregar as atividades-->
                                                                <%! int qtdOrganizador = 0;%>
                                                                <% qtdOrganizador = 0; %>
                                                                <c:forEach var="organizadorEvento" items="${organizadoresEvento}">
                                                                    <% qtdOrganizador++;%>
                                                                    <div id="divOrg_${organizadorEvento.idOrganizadorEvento}">
                                                                        <div class="form-group"></div><div class="form-line row">
                                                                            <div class="col-sm">
                                                                                <div class="input-group input-group-mb-3">
                                                                                    <input type="text" class="form-control" id="nomeOrg_${organizadorEvento.idOrganizadorEvento}" value="${organizadorEvento.organizador.nomeRazaoPessoa} - ${organizadorEvento.funcao.descricao}" disabled/>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach> 
                                                                <%
                                                                    if (qtdOrganizador == 0)
                                                                        out.println("Nenhum organizador vinculado a este evento!");
                                                                %>
                                                            </div>                    
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div><!--fim div da detalhes organizador -->
                                    <div class="row"><!--inicio div da detalhes atividade -->
                                        <div class="col">
                                            <div class="form-group">
                                                <div class="form-line row">
                                                    <div class="col-sm">
                                                        <hr>
                                                        <h3><b><a data-toggle="collapse" href="#collapseAtividade" aria-expanded="false" aria-controls="collapseAtividade" style="color: black;">
                                                                    Atividades <i class="fas fa-caret-down"></i>
                                                                </a>
                                                            </b>
                                                        </h3>
                                                        <div class="tab-content collapse multi-collapse" id="collapseAtividade">
                                                            <div id="espacoaddatividadeevento">
                                                                <!-- Loop para carregar as atividades-->
                                                                <%! int qtdAtividade = 0;%>
                                                                <% qtdAtividade = 0; %>
                                                                <c:forEach var="atividadeEvento" items="${atividadesEvento}">   
                                                                    <% qtdAtividade++;%>
                                                                    <div id="divAtv_${atividadeEvento.idAtividadeEvento}">
                                                                        <div class="form-group"></div>
                                                                        <div class="form-line row">
                                                                            <div class="col-sm">
                                                                                <div class="input-group input-group-mb-3">
                                                                                    <div style="background-color: #E9ECEF; width: 100%; border-color: #cacbcc; border-width: 1px; border-style: solid; padding: 10px;">
                                                                                        <b>Atividade:</b> ${atividadeEvento.nomeAtividade} <br>
                                                                                        <b>Data:</b> ${atividadeEvento.dataAtividadeFormatada}<br>
                                                                                        <b>Hora:</b> ${atividadeEvento.horaAtividade}<br>
                                                                                        <b>Carga Horária:</b> ${atividadeEvento.cargaHoraria}<br>
                                                                                        <b>Tipo de Atividade:</b> ${atividadeEvento.tipoAtividade.descricao}<br>
                                                                                        <b>Resumo:</b> ${atividadeEvento.resumo}                                                
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>                            
                                                                </c:forEach> 
                                                                <%
                                                                    if (qtdAtividade == 0)
                                                                        out.println("Nenhuma atividade cadastrada a este evento!");
                                                                %>
                                                            </div>                    
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!--fim div da detalhes atividade -->
                                    <hr>
                                    <div><!--botoes-->
                                        <a href="${pageContext.request.contextPath}/EventoCarregar?idEvento=${evento.idEvento}" class="btn btn-app bg-secondary">
                                            <i class="fas fa-edit"></i> Alterar
                                        </a>
                                        <a href="${pageContext.request.contextPath}/DespesaListar?idEvento=${evento.idEvento}" class="btn btn-app bg-success">
                                            <i class="far fa-money-bill-alt"></i> Despesas
                                        </a>
                                        <a class="btn btn-app bg-success">
                                            <i class="far fas fa-hand-holding-usd"></i> Doações
                                        </a>
                                        <a class="btn btn-app bg-warning">
                                            <i class="fas fa-user-check"></i> Inscritos
                                        </a>
                                        <a href="#modalstatus" data-toggle="modal" data-ad="" onclick="setDadosModal(${0})" class="btn btn-app bg-info">
                                            <i class="fas fa-check-square"></i> Status
                                        </a>
                                        <a href="${pageContext.request.contextPath}/EventoListar" class="btn btn-app bg-danger">
                                            <i class="fas fa-sign-out-alt"></i> Voltar
                                        </a>
                                    </div>

                                    <!--modal-->
                                    <div class="modal fade" id="modalstatus" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-x1">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Status</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body" align="center">
                                                    <a class="btn btn-app bg-success" ref="#" onclick="status(${evento.idEvento}, 'A')">
                                                        <i class="fas fa-check"></i> <b>Ativar</b>
                                                    </a>

                                                    <a class="btn btn-app bg-danger" ref="#" onclick="status(${evento.idEvento}, 'I')">
                                                        <i class="fas fa-check"></i> <b>Inativar</b>
                                                    </a>

                                                    <a class="btn btn-app bg-info" ref="#" onclick="status(${evento.idEvento}, 'E')">
                                                        <i class="fas fa-check"></i> <b>Encerrar</b>
                                                    </a>

                                                    <a class="btn btn-app bg-secondary" ref="#" onclick="status(${evento.idEvento}, 'F')">
                                                        <i class="fas fa-check"></i> <b>Finalizar</b>
                                                    </a>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

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
    ;

    $(document).ready(function () {
        menuAtivo();
    });

    function status(codigo, situacao) {
        var idEvento = codigo;
        var status = situacao
        console.log(idEvento);
        console.log(status);
        console.log("Alterando status ....");

        $.ajax({
            type: 'post',
            url: 'EventoExcluir',
            data: {
                idEvento: idEvento,
                situacaoEvento: status
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Status alterado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                atualizarStatus(status);
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Problemas ao alterar status!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/EventoGerenciar?idEvento=${evento.idEvento}";
                                                            })
                                                        }
                                                    },
                                            error:
                                                    function (data) {
                                                        window.location.href = "${pageContext.request.contextPath}/EventoGerenciar?idEvento=${evento.idEvento}";
                                                                            }
                                                                });
                                                            }
                                                            ;

                                                            function atualizarStatus(status) {
                                                                if (status == 'A') {
                                                                    document.getElementById('status').innerHTML = "Ativo";
                                                                }else if (status == 'I') {
                                                                    document.getElementById('status').innerHTML = "Inativo";
                                                                }else if (status == 'E') {
                                                                    document.getElementById('status').innerHTML = "Encerrado";
                                                                }else if (status == 'F') {
                                                                    document.getElementById('status').innerHTML = "Finalizado";
                                                                }


                                                                $('.modal').modal('hide');
                                                            }
                                                            ;

</script>
<jsp:include page="/painel/footer.jsp"/>