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
                    <div class="table-responsive">
                        <table id="datatable" class="display">
                            <thead>
                                <tr>
                                    <th align="center">ID</th>
                                    <th align="center">Sigla</th>
                                    <th align="center">Nome</th>
                                    <th align="center"></th>
                                    <th align="center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="estado" items="${estados}">
                                    <tr>
                                        <td align="right">${estado.idEstado}</td>
                                        <td align="left">${estado.nomeEstado}</td>
                                        <td align="left">${estado.siglaEstado}</td>
                                        <td align="center">
                                            <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                               data-id="" onclick="setDadosModal(${estado.idEstado})">
                                                <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                        </td>
                                        <td align="center">
                                            <a href="#" onclick="deletar(${estado.idEstado}, '${estado.situacao}')">
                                                <button class="btn
                                                        <c:out value="${estado.situacao == 'A' ? 'btn-danger':'btn-success'}"/>">
                                                    <i class="fas fa-fw
                                                       <c:out value="${estado.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                    <Strong>
                                                        <c:out value="${estado.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>
                                                    </Strong>
                                                </button></a>
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
                                <input class="form-control" type="hidden" name="idestado" id="idestado" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Nome Estado</label>
                                <input class="form-control" type="text" name="nomeestado" id="nomeestado" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Sigla</label>
                                <input class="form-control" type="text" name="siglaestado" id="siglaestado"/>
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
        //$("#datatable").DataTable({});
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

    var cidade = ''; //variavel para controle do carregamento de cidades
    function limparDadosModal() {
        $('#idestado').val("0");
        $('#nomeestado').val("");
        $('#siglaestado').val("");
        $('#situacao').val("");
    }

    function setDadosModal(valor) {
        limparDadosModal();
        document.getElementById('idestado').value = valor;
        var idEstado = valor;
        if (idEstado != "0") {
            //existe estado para buscar (alteração)
            $.getJSON('EstadoCarregar', {idEstado: idEstado}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idEstado;
                if (id != "0") {
                    $('#idestado').val(respostaServlet.idEstado);
                    $('#nomeestado').val(respostaServlet.nomeEstado);
                    $('#siglaestado').val(respostaServlet.siglaEstado);
                    $('#situacao').val(respostaServlet.situacao);
                }
            });
        }
    }

    function deletar(codigo, situacao) {
        var id = codigo;
        console.log(codigo);

        var titulo = "";
        var tituloConfirmacao = "";
        var confirmButtonText = "";

        if (situacao == 'I') {
            titulo = "Você deseja realmente ativar o estado?";
            confirmButtonText = "Sim, ative o estado!";
            tituloConfirmacao = "Estado ativado com sucesso!";

        } else {
            titulo = "Você deseja realmente inativar o estado?";
            confirmButtonText = "Sim, inative o estado!";
            tituloConfirmacao = "Estado inativado com sucesso!";
        }

        Swal.fire({
            title: 'Você tem certeza?',
            text: titulo,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: confirmButtonText,
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/EstadoExcluir',
                    data: {
                        idEstado: id
                    },
                    success:
                            function (data) {
                                if (data == 1) {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'success',
                                        title: 'Sucesso',
                                        text: tituloConfirmacao,
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível ativar/inativar estado!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log("entrei na validação de campos");
        if (document.getElementById("nomeestado").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o Nome do Estado!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#nomeestado").focus();
        } else if (document.getElementById("siglaestado").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a Sigla do Estado!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#siglaestado").focus();
        } else {
            gravarDados();
        }
    }

    function gravarDados() {
        console.log("Gravando dados ....");

        $.ajax({
            type: 'post',
            url: 'EstadoCadastrar',
            data: {
                idestado: $('#idestado').val(),
                nomeestado: $('#nomeestado').val(),
                siglaestado: $('#siglaestado').val(),
                situacao: $("#situacao").val()
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
                                text: 'Estado gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o estado!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                    }
        });
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Estado</strong>";
        document.getElementById('agrupamentocadastrosgerais').classList.add("menu-open");
        document.getElementById('menucadastrosgerais').classList.add("active");
        document.getElementById('menuestado').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>