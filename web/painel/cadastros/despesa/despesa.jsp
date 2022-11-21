<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/painel/header.jsp" />

<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <!-- Page Heading -->
            <p class="mb-4">Planilha de Registros</p>
            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-ad="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <table id="datatable" class="display">
                        <thead>
                            <tr>
                                <th align="center">ID</th>
                                <th align="center">Valor da Despesa</th>
                                <th align="center">Vencimento da Despesa</th>
                                <th align="center">Pagamento da Despesa</th>
                                <th align="center">Descrição</th>
                                <th align="center">Fornecedor</th>
                                <th align="center">Evento</th>
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
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                           data-id="" onclick="setDadosModal(${despesa.idDespesa})">
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
                                        <a href="#" onclick="deletar(${despesa.idDespesa})" class="btn btn-danger">
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
                                <input class="form-control" type="text" name="valorDespesa" id="valorDespesa" value=""/>
                            </div>
                            
                            <div class="form-group">
                                <label>Vencimento da Despesa</label>
                                <input class="form-control" type="date" name="vencimentoDespesa" id="vencimentoDespesa" value=""/>
                            </div>
                            
                            <div class="form-group">
                                <label>Pagamento da Despesa</label>
                                <input class="form-control" type="date" name="pagamentoDespesa" id="pagamentoDespesa" value=""/>
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
        $('#idEvento').val("");
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
                    $('#pagamentoDespesa').val(respostaServlet.pagamentoDespesa);
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
        if (valorDespesa  == '' , valorDespesa <= 0) {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a Valor da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#valorDespesa").focus();
        }else if (document.getElementById("vencimentoDespesa").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique Vencimento da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#vencimentoDespesa").focus();
        }else if (document.getElementById("pagamentoDespesa").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique Data do Pagamento da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#pagamentoDespesa").focus();
        }else if (document.getElementById("descricao").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique Descrição da Despesa',
                showConfirmButton: true,
                timer: 2000
            });
            $("#descricao").focus();
        }else if (document.getElementById("idEvento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique id do Evento',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idEvento").focus();
        }else if (document.getElementById("idFornecedor").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique id do Fornecedor',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idFornecedor").focus();
        
        }else {
            validarData();
            
        }
    }
    
    function validarData(){
           var dataVencimento = document.getElementById("vencimentoDespesa").value;
           var dataPagamento =  document.getElementById("pagamentoDespesa").value;
           
           if (dataPagamento <= dataVencimento){
               gravarDados();
           }else{
              Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Data da Despesa Vencida',
                showConfirmButton: true,
                timer: 2000
            });
            $("#pagamentoDespesa").focus(); 
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
                pagamentoDespesa: $("#pagamentoDespesa").val(),
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
                                window.location.href = "${pageContext.request.contextPath}/DespesaListar";
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
                                window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                    }
        });
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Despesa</strong>";
        document.getElementById('menudespesa').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });
    
    function deletar(codigo) {
        var id = codigo;
        console.log(codigo);

        

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
                                        window.location.href = "${pageContext.request.contextPath}/DespesaListar";
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
                                        window.location.href = "${pageContext.request.contextPath}/DespesaListar";
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
    
    
    function pagar(codigo, situacao){
       var id = codigo;
       console.log(codigo);
        
       
       if (situacao == 'A'){
           titulo = 'Você deseja reamente baixar a despesa?';
           tituloConfirmacao = 'Despesa baixada com sucesso!';
        }else{
           titulo = 'Você deseja reamente estorna a despesa?';
           tituloConfirmacao = 'Despesa estornada com sucesso!'; 
        }
    
    
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
                                        text: tituloConfirmacao,
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/DespesaListar";
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
                                        window.location.href = "${pageContext.request.contextPath}/DespesaListar";
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
    

</script>
<%@include file="/painel/footer.jsp"%>