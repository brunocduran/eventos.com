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
                                <th align="center">Cidade</th>
                                <th align="center">Estado</th>
                                <th align="center"></th>
                                <th align="center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cidade" items="${cidades}">
                                <tr>
                                    <td align="right">${cidade.idCidade}</td>
                                    <td align="left">${cidade.nomeCidade}</td>
                                    <td align="left">${cidade.estado.siglaEstado}</td>
                                    <td align="center">
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                           data-id="" onclick="setDadosModal(${cidade.idCidade})">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>
                                    <td align="center">
                                        <a href="#" onclick="deletar(${cidade.idCidade}, '${cidade.situacao}')">
                                            <button class="btn
                                                    <c:out value="${cidade.situacao == 'A' ? 'btn-danger':'btn-success'}"/>">
                                                <i class="fas fa-fw
                                                   <c:out value="${cidade.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                <Strong>
                                                    <c:out value="${cidade.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>
                                                </Strong>
                                            </button></a>
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
                                <input class="form-control" type="hidden" name="idcidade" id="idcidade" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Nome Cidade</label>
                                <input class="form-control" type="text" name="nomecidade" id="nomecidade" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Estado</label>
                                <select class="form-control" name="idestado" id="idestado" onchange="BuscarCidadesPorEstado()" required>
                                    <option value="nulo">Selecione</option>
                                    <c:forEach var="estado" items="${estados}">
                                        <option value="${estado.idEstado}" ${administrador.cidade.estado.idEstado == estado.idEstado ? "selected" : ""}>
                                            ${estado.nomeEstado}
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
        $('#idcidade').val("0");
        $('#nomecidade').val("");
        $('#idestado').val("");
        $('#situacao').val("");
    }

    function setDadosModal(valor) {
        limparDadosModal();
        document.getElementById('idcidade').value = valor;
        var idCidade = valor;
        if (idCidade != "0") {
            //existe cidade para buscar (alteração)
            $.getJSON('CidadeCarregar', {idCidade: idCidade}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idEstado;
                if (id != "0") {
                    $('#idcidade').val(respostaServlet.idCidade);
                    $('#nomecidade').val(respostaServlet.nomeCidade);
                    $('#idestado').val(respostaServlet.estado.idEstado);
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
            titulo = "Você deseja realmente ativar a cidade?";
            confirmButtonText = "Sim, ative a cidade!";
            tituloConfirmacao = "Cidade ativada com sucesso!";

        } else {
            titulo = "Você deseja realmente inativar a cidade?";
            confirmButtonText = "Sim, inative a cidade!";
            tituloConfirmacao = "Cidade inativada com sucesso!";
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
                    url: '${pageContext.request.contextPath}/CidadeExcluir',
                    data: {
                        idCidade: id
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
                                        window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível ativar/inativar cidade!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log("entrei na validação de campos");
        if (document.getElementById("nomecidade").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o Nome da Cidade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#nomecidade").focus();
        } else if (document.getElementById("idestado").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o Estado!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idestado").focus();
        } else {
            gravarDados();
        }
    }

    function gravarDados() {
        console.log("Gravando dados ....");

        $.ajax({
            type: 'post',
            url: 'CidadeCadastrar',
            data: {
                idcidade: $('#idcidade').val(),
                nomecidade: $('#nomecidade').val(),
                idestado: $('#idestado').val(),
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
                                text: 'Cidade gravada com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar a cidade!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                    }
        });
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Cidade</strong>";
        document.getElementById('agrupamentolocalizacao').classList.add("menu-open");
        document.getElementById('menulocalizacao').classList.add("active");
        document.getElementById('menucidade').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>