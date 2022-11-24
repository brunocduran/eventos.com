<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/painel/header.jsp" />

<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <!-- Page Heading -->
            <c:if test="${eventoCarregado.idEvento == null}">
                <p class="mb-4">Planilha de Registros</p>
            </c:if>
            <c:if test="${eventoCarregado.idEvento != null}">
                <p class="mb-4">Planilha de Registros - <b>Despesas do Evento: ${eventoCarregado.nomeEvento} </b></p>
                <a href="${pageContext.request.contextPath}/EventoGerenciar?idEvento=${eventoCarregado.idEvento}" class="btn btn-primary mb-4 ">
                    <i class="fa fa-arrow-left"></i> Voltar p/ Evento</a>
            </c:if>


            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-ad="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <div class="table-responsive">
                    <table id="datatable" class="display">
                        <thead>
                            <tr>
                                <th align="center">ID</th>
                                <th align="left">Valor da Despesa</th>
                                <th align="left">Vencimento da Despesa</th>
                                <th align="left">Pagamento da Despesa</th>
                                <th align="left">Descrição</th>
                                <th align="left">Fornecedor</th>
                                <th align="left">Evento</th>
                                <th align="center"></th>
                                <th align="center"></th>
                                <th align="center"></th>
                            </tr>
                        </thead><fmt
                            <tbody>
                            <c:forEach var="despesa" items="${despesas}">
                                <tr>
                                    <td align="right">${despesa.idDespesa}</td>
                                    <td align="left"><fmt:formatNumber value="${despesa.valorDespesa}" type="currency"/></td>
                                    <td align="left"><fmt:formatDate pattern="dd/MM/yyyy" value="${despesa.vencimentoDespesa}"/></td>
                                    <td align="left"><fmt:formatDate pattern="dd/MM/yyyy" value="${despesa.pagamentoDespesa}"/></td>
                                    <td align="left">${despesa.descricao}</td>
                                    <td align="left">${despesa.fornecedor.nomeRazaoPessoa}</td>
                                    <td align="left">${despesa.evento.nomeEvento}</td>
                                    <td align="center">
                                        <a class="btn btn-group-lg btn-primary" data-toggle="modal"
                                           data-id="" onclick="alterar(${despesa.idDespesa}, '${despesa.situacao}')">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>
                                    <td align="center">
                                        <a href="#" onclick="pagar(${despesa.idDespesa}, '${despesa.situacao}')" >
                                            <button class="btn
                                                    <c:out value="${despesa.situacao == 'A' ?'btn-success': 'bg-warning'}"/>">
                                                <i class="fas fa-fw 
                                                   <c:out value="${despesa.situacao == 'A' ? 'fas fa-check' : 'fa-times'}"/>"></i>
                                                <Strong>
                                                    <c:out value="${despesa.situacao == 'A' ? 'Baixar' : 'Estorna'}"/>
                                                </Strong>
                                            </button>
                                        </a>
                                    </td>
                                    <td align="center">
                                        <a href="#" onclick="deletar(${despesa.idDespesa},'${despesa.situacao}')" class="btn btn-danger">
                                            <i class="fas fa-fw fa-times"></i>
                                            <Strong>
                                                Excluir
                                            </Strong>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                    </table>
                </div>
                </div>
            </div>

            <div class="modal fade" id="modaladicionar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-x1">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Adicionar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idDespesa" id="idDespesa" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Valor da Despesa</label>
                                <input class="form-control" type="number" name="valorDespesa" id="valorDespesa" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Vencimento da Despesa</label>
                                <input class="form-control" type="date" name="vencimentoDespesa" id="vencimentoDespesa" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Descrição</label>
                                <input class="form-control" type="text" name="descricao" id="descricao" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Fornecedor</label>
                                <select class="form-control" name="idFornecedor" id="idFornecedor" required>
                                    <option value="nulo">Selecione</option>
                                    <c:forEach var="fornecedor" items="${fornecedores}">
                                        <option value="${fornecedor.idFornecedor}" 
                                                ${despesa.fornecedor.idFornecedor == fornecedor.idFornecedor ? "selected" : ""}>
                                            ${fornecedor.nomeRazaoPessoa}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <c:if test="${eventoCarregado.idEvento == null}">
                                <div class="form-group">
                                    <label>Evento</label>
                                    <select class="form-control" name="idEvento" id="idEvento" required>
                                        <option value="nulo">Selecione</option>
                                        <c:forEach var="evento" items="${eventos}">
                                            <option value="${evento.idEvento}" 
                                                    ${despesa.evento.idEvento == evento.idEvento ? "selected" : ""}>
                                                ${evento.nomeEvento}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>                                
                            </c:if>

                            <c:if test="${eventoCarregado.idEvento != null}">
                                <input class="form-control" type="hidden" name="idEvento" id="idEvento" value="${eventoCarregado.idEvento}" readonly="readonly"/>    
                            </c:if>


                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <a href="#" onclick="validarCampos()">
                                    <button type="button" class="btn btn-success">Salvar</button>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                
            <div class="modal fade" id="modalbaixar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-x1">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Baixar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idDespesaBaixa" id="idDespesaBaixa" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacaoBaixa" id="situacaoBaixa" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Pagamento da Despesa</label>
                                <input class="form-control" type="date" name="pagamentoDespesa" id="pagamentoDespesa" value=""/>
                            </div>

                            <c:if test="${eventoCarregado.idEvento != null}">
                                <input class="form-control" type="hidden" name="idEventoBaixa" id="idEventoBaixa" value="${eventoCarregado.idEvento}" readonly="readonly"/>    
                            </c:if>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <a href="#" onclick="baixar(0,'A')">
                                    <button type="button" class="btn btn-success">Baixar</button>
                                </a>
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
        width: 0.1px;
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
    $(document).ready(function () {
        console.log('entrei ready');
        //Carregamos a datatable
        $('#datatable').DataTable({
            "oLanguage": {
                "sProcessing": "Processando...",
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "Nenhum registro encontrado.",
                "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando de 0 até 0 de 0 registros",
                "sInfoFiltered": "",
                "sinfoPostFix": "",
                "sSearch": "Buscar:",
                "sUrl": "",
                "oPaginate": {
                    "sFirst": "Primeiro",
                    "sPrevious": "Anterior",
                    "sNext": "Seguinte",
                    "sLast": "Último"
                }
            }
        });
    });

    var cidade = '';
    function limparDadosModal() {
        $('#idDespesa').val("0");
        $('#situacao').val("");
        $('#valorDespesa').val("");
        $('#vencimentoDespesa').val("");
        $('#pagamentoDespesa').val("");
        $('#descricao').val("");
        $('#idFornecedor').val("");

        if (${eventoCarregado.idEvento == null}) {
            $('#idEvento').val("");
        }
    }
    
    function limparDadosModalBaixa() {
        $('#idDespesaBaixa').val("0");
        $('#situacaoBaixa').val("");
        $('#pagamentoDespesa').val("");

        if (${eventoCarregado.idEvento == null}) {
            $('#idEvento').val("");
        }
    }
    
    function alterar(valor, situacao) {
        var status = situacao;
        
         if (status == 'P') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Só é possível alterar despesas que não foram baixadas!',
                showConfirmButton: true
            });
        } else {
            $('#modaladicionar').modal('show');
            setDadosModal(valor);
        }
    }

    function setDadosModal(valor) {
        limparDadosModal();
        
        if (valor != "0") {
            $.getJSON('DespesaCarregar', {idDespesa: valor}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idDespesa;
                if (id != "0") {
                    $('#idDespesa').val(respostaServlet.idDespesa);
                    $('#situacao').val(respostaServlet.situacao);
                    $('#valorDespesa').val(respostaServlet.valorDespesa);
                    $('#vencimentoDespesa').val(respostaServlet.vencimentoDespesa);
                    //$('#pagamentoDespesa').val(respostaServlet.pagamentoDespesa);
                    $('#descricao').val(respostaServlet.descricao);
                    $('#idFornecedor').val(respostaServlet.fornecedor.idFornecedor);
                    $('#idEvento').val(respostaServlet.evento.idEvento);

                }
            });
        }
    }



    function validarCampos() {
        console.log("entrei na validação de campos");
        var valorDespesa = document.getElementById("valorDespesa").value;
        if (valorDespesa == '', valorDespesa <= 0) {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a Valor da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#valorDespesa").focus();
        } else if (document.getElementById("vencimentoDespesa").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique Vencimento da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#vencimentoDespesa").focus();
        } else if (document.getElementById("descricao").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique Descrição da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#descricao").focus();
        } else if (document.getElementById("idEvento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique id do Evento',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idEvento").focus();
        } else if (document.getElementById("idFornecedor").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique id do Fornecedor',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idFornecedor").focus();

        } else {
            gravarDados();

        }
    }

    function gravarDados() {
        console.log("Gravando dados ....");

        $.ajax({
            type: 'post',
            url: 'DespesaCadastrar',
            data: {
                idDespesa: $('#idDespesa').val(),
                situacao: $('#situacao').val(),
                valorDespesa: $("#valorDespesa").val(),
                vencimentoDespesa: $("#vencimentoDespesa").val(),
                //pagamentoDespesa: $("#pagamentoDespesa").val(),
                descricao: $("#descricao").val(),
                idFornecedor: $("#idFornecedor").val(),
                idEvento: $("#idEvento").val()

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
                                text: 'Despesa gravada com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                if (${eventoCarregado.idEvento != null}) {
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                }else{
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                } 
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar a Despesa!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                 if (${eventoCarregado.idEvento != null}) {
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                }else{
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                } 
                            })
                        }
                    },
            error:
                    function (data) {
                         if (${eventoCarregado.idEvento != null}) {
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                }else{
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                } 
                    }
        });
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Despesa</strong>";
        document.getElementById('agrupamentoevento').classList.add("menu-open");
        document.getElementById('menueventoagrupamento').classList.add("active");
        document.getElementById('menudespesa').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

    function deletar(codigo,situacao) {
        var id = codigo;
        var status = situacao;
        console.log(codigo);
        console.log(status);
        
        if (status == 'P') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Só é possível excluir despesas que não foram baixadas!',
                showConfirmButton: true
            });
        } else {
            
        Swal.fire({
            title: 'Você tem certeza?',
            text: 'Você deseja realmente excluir despesa?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Excluir',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/DespesaExcluir',
                    data: {
                        idDespesa: id
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
                                        text: 'Despesa Excluida com Sucesso',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                         if (${eventoCarregado.idEvento != null}) {
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                }else{
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                } 
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível excluir despesa!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                         if (${eventoCarregado.idEvento != null}) {
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                }else{
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                } 
                                    })
                                }
                            },
                    error:
                            function (data) {
                                if (${eventoCarregado.idEvento != null}) {
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                }else{
                                    window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                } 
                            }
                });
            }
            ;
        });
        }
    }
    
    function setDadosModalPagar(valor) {
        limparDadosModalBaixa();
        if (valor != "0") {
            $.getJSON('DespesaCarregar', {idDespesa: valor}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idDespesa;
                if (id != "0") {
                    $('#idDespesaBaixa').val(respostaServlet.idDespesa);
                    $('#situacaoBaixa').val(respostaServlet.situacao);
                    $('#pagamentoDespesa').val(respostaServlet.pagamentoDespesa);
                    $('#idEventoBaixa').val(respostaServlet.evento.idEvento);
                }
            });
        }
    }
    
    function pagar(codigo, situacao) {
        if (situacao == 'A') {
            $('#modalbaixar').modal('show');
            setDadosModalPagar(codigo);
        } else {
            baixar(codigo, situacao);
        }
    }

    function baixar(codigo, situacao) {
        if (codigo == 0){
            var id = document.getElementById(`idDespesaBaixa`).value;
            var data = document.getElementById("pagamentoDespesa").value;
        }else{
            var id = codigo;
            var data = null;
        }
        console.log('ID da despesa:'+id);


        if (situacao == 'A') {
            titulo = 'Você deseja reamente baixar a despesa?';
            tituloConfirmacao = 'Despesa baixada com sucesso!';
        } else {
            titulo = 'Você deseja reamente estorna a despesa?';
            tituloConfirmacao = 'Despesa estornada com sucesso!';
        }
        
        if (document.getElementById("pagamentoDespesa").value == '' && situacao == 'A') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a Data de Pagamento!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#vencimentoDespesa").focus();
        } else{

        Swal.fire({
            title: 'Você tem certeza?',
            text: titulo,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/DespesaPagamento',
                    data: {
                        idDespesa: id,
                        pagamentoDespesa: data,
                        situacao: situacao
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
                                        text: tituloConfirmacao,
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        if (${eventoCarregado.idEvento != null}) {
                                            window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                        }else{
                                            window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                        } 
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível excluir despesa!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        if (${eventoCarregado.idEvento != null}) {
                                            window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=${eventoCarregado.idEvento}";
                                        }else{
                                            window.location.href = "${pageContext.request.contextPath}/DespesaListar?idEvento=0";
                                        } 
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                            }
                });
            }
            ;
        });
    }
    }

</script>
<%@include file="/painel/footer.jsp"%>