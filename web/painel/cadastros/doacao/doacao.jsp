<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/painel/header.jsp" />

<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">

            <c:if test="${eventoCarregadoDoacao.idEvento == null}">
                <p class="mb-4">Planilha de Registros</p>
            </c:if>
            <c:if test="${eventoCarregadoDoacao.idEvento != null}">
                <p class="mb-4">Planilha de Registros - <b>Doacao do Evento: ${eventoCarregadoDoacao.nomeEvento} </b></p>
                <a href="${pageContext.request.contextPath}/EventoGerenciar?idEvento=${eventoCarregadoDoacao.idEvento}" class="btn btn-primary mb-4 ">
                    <i class="fa fa-arrow-left"></i> Voltar p/ Evento</a>
                </c:if>

            <!-- Page Heading -->

            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-ad="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <table id="datatable" class="display">
                        <thead>
                            <tr>
                                <th align="center">ID</th>
                                <th align="center">Valor Doação</th>
                                <th align="center">Data Doação</th>
                                <th align="center">Descrição</th>
                                <th align="center"></th>
                                <th align="center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="doacao" items="${doacoes}">
                                <tr>
                                    <td align="left">${doacao.idDoacao}</td>
                                    <td align="left"><fmt:formatNumber value = "${doacao.valorDoacao}" type = "currency"/></td>
                                    <td align="left"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${doacao.dataDoacao}"  /></td>
                                    <td align="left">${doacao.descricao}</td>
                                    <td align="center">
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                           data-id="" onclick="setDadosModal(${doacao.idDoacao})">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>

                                    <td align="center">
                                        <a href="#" onclick="alterarStatus(${doacao.idDoacao}, '${doacao.situacao}')">
                                            <button class="btn
                                                    <c:out value="${doacao.situacao == 'A' ? 'btn-success':'btn-warning'}"/>">
                                                <i class="fas fa-fw
                                                   <c:out value="${doacao.situacao == 'A' ? 'fas fa-check' : 'fa-times'}"/>"></i>
                                                <Strong>
                                                    <c:out value="${doacao.situacao == 'A' ? 'Baixar' : 'Estornar'}"/>
                                                </Strong>
                                            </button></a>
                                    </td>


                                    <td align="center">
                                        <a href="#" onclick="deletar(${doacao.idDoacao}, '${doacao.situacao}')" class="btn btn-danger" >
                                            <i class="fas fa-faw fa-times"></i>
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
                                <input class="form-control" type="hidden" name="idDoacao" id="idDoacao" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Valor Doação</label>
                                <input class="form-control" type="number" name="valorDoacao" id="valorDoacao" value=""/>
                            </div>



                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>Data Doação</label>
                                        <input class="form-control" type="date" name="dataDoacao" id="dataDoacao" value="${doacao.dataDoacao}"
                                               maxLength="8" />
                                    </div>


                                </div>
                            </div>

                            <div class="form-group">
                                <label>Descricao</label>
                                <input class="form-control" type="text" name="descricao" id="descricao" value=""/>
                            </div>


                            <div class="col-sm">
                                <label>Patrocinador</label>
                                <select class="form-control" name="idPatrocinador" id="idPatrocinador" required>
                                    <option value="nulo">Selecione</option>
                                    <c:forEach var="patrocinador" items="${patrocinadores}">
                                        <option value="${patrocinador.idPatrocinador}" ${Doacao.patrocinador.idPatrocinador == patrocinador.idPatrocinador ? "selected" : ""}>
                                            ${patrocinador.nomeRazaoPessoa} 
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                                               
                            <c:if test="${eventoCarregadoDoacao.idEvento == null}">
                                <div class="col-sm">
                                    <label>Evento</label>
                                    <select class="form-control" name="idEvento" id="idEvento" required>
                                        <option value="nulo">Selecione</option>
                                        <c:forEach var="evento" items="${eventos}">
                                            <option value="${evento.idEvento}" ${Doacao.evento.idEvento == evento.idEvento ? "selected" : ""}>
                                                ${evento.nomeEvento} 
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                            </c:if>




                                <c:if test="${eventoCarregadoDoacao.idEvento != null}">
                                    <input class="form-control" type="hidden" name="idEvento" id="idEvento" value="${eventoCarregadoDoacao.idEvento}" readonly="readonly"/>    
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


        function limparDadosModal() {
            $('#idDoacao').val("0");
            $('#valorDoacao').val("");
            $('#dataDoacao').val("");
            $('#descricao').val("");
            $('#situacao').val("");
            $('#idPatrocinador').val("0");

            if (${eventoCarregadoDoacao.idEvento == null}) {
                $('#idEvento').val("");
            }

        }

        function setDadosModal(valor) {
            limparDadosModal();
            document.getElementById('idDoacao').value = valor;
            var idDoacao = valor;
            if (idDoacao != "0") {
                $.getJSON('DoacaoCarregar', {idDoacao: idDoacao}, function (respostaServlet) {
                    console.log(respostaServlet);
                    var id = respostaServlet.idDoacao;
                    if (id != "0") {
                        $('#idDoacao').val(respostaServlet.idDoacao);
                        $('#valorDoacao').val(respostaServlet.valorDoacao);
                        $('#dataDoacao').val(respostaServlet.dataDoacao);
                        $('#descricao').val(respostaServlet.descricao);
                        $('#situacao').val(respostaServlet.situacao);
                        $('#idPatrocinador').val(respostaServlet.patrocinador.idPatrocinador);
                        $('#idEvento').val(respostaServlet.evento.idEvento);
                    }
                });
            }
        }

        function alterarStatus(codigo, situacao) {
            var id = codigo;
            console.log(codigo);

            var titulo = "";
            var tituloConfirmacao = "";

            if (situacao == 'A') {
                titulo = "Você deseja realmente baixar a doação?";
                tituloConfirmacao = "Doação baixada com sucesso!";

            } else {
                titulo = "Você deseja realmente estornar a doação?";
                tituloConfirmacao = "Doação estornada com sucesso!";
            }

            Swal.fire({
                title: 'Você tem certeza ?',
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
                        url: '${pageContext.request.contextPath}/DoacaoAlterarStatus',
                        data: {
                            idDoacao: id
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
                                            if (${eventoCarregadoDoacao.idEvento != null}) {
                                                window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                        } else {
                                                                                            window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                        }
                                                                                    })
                                                                                } else {
                                                                                    Swal.fire({
                                                                                        position: 'center',
                                                                                        icon: 'error',
                                                                                        title: 'Erro',
                                                                                        text: 'Não foi possível excluir doacao!',
                                                                                        showConfirmButton: true,
                                                                                        timer: 10000
                                                                                    }).then(function () {
                                                                                        if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                            window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                    } else {
                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                    }
                                                                                                                                })
                                                                                                                            }
                                                                                                                        },
                                                                                                                error:
                                                                                                                        function (data) {
                                                                                                                            if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                } else {
                                                                                                                                                                    window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                }
                                                                                                                                                            }
                                                                                                                                                });
                                                                                                                                            }
                                                                                                                                            ;
                                                                                                                                        });
                                                                                                                                    }
                                                                                                                                    function validarCampos() {
                                                                                                                                        console.log("entrei na validação de campos");
                                                                                                                                        if (document.getElementById("valorDoacao").value == '') {
                                                                                                                                            Swal.fire({
                                                                                                                                                position: 'center',
                                                                                                                                                icon: 'error',
                                                                                                                                                title: 'Verifique o Valor da Doação',
                                                                                                                                                showConfirmButton: true,
                                                                                                                                                timer: 2000
                                                                                                                                            });
                                                                                                                                            $("#valorDoacao").focus();

                                                                                                                                        } else if (document.getElementById("dataDoacao").value == '') {
                                                                                                                                            Swal.fire({
                                                                                                                                                position: 'center',
                                                                                                                                                icon: 'error',
                                                                                                                                                title: 'Verifique a data da Doacao',
                                                                                                                                                showConfirmButton: true,
                                                                                                                                                timer: 2000
                                                                                                                                            });
                                                                                                                                            $("#dataDoacao").focus();


                                                                                                                                        } else if (document.getElementById("descricao").value == '') {
                                                                                                                                            Swal.fire({
                                                                                                                                                position: 'center',
                                                                                                                                                icon: 'error',
                                                                                                                                                title: 'Verifique a descrição da Doação',
                                                                                                                                                showConfirmButton: true,
                                                                                                                                                timer: 2000
                                                                                                                                            });
                                                                                                                                            $("#descricao").focus();

                                                                                                                                        } else if (document.getElementById("idPatrocinador").value == '') {
                                                                                                                                            Swal.fire({
                                                                                                                                                position: 'center',
                                                                                                                                                icon: 'error',
                                                                                                                                                title: 'Verifique o id do Patrocinador',
                                                                                                                                                showConfirmButton: true,
                                                                                                                                                timer: 2000
                                                                                                                                            });
                                                                                                                                            $("#idPatrocinador").focus();

                                                                                                                                        } else if (document.getElementById("idEvento").value == '') {
                                                                                                                                            Swal.fire({
                                                                                                                                                position: 'center',
                                                                                                                                                icon: 'error',
                                                                                                                                                title: 'Verifique o id do Evento',
                                                                                                                                                showConfirmButton: true,
                                                                                                                                                timer: 2000
                                                                                                                                            });
                                                                                                                                            $("#idEvento").focus();

                                                                                                                                        } else {
                                                                                                                                            gravarDados();
                                                                                                                                        }
                                                                                                                                    }

                                                                                                                                    function gravarDados() {
                                                                                                                                        console.log("Gravando dados ....");

                                                                                                                                        $.ajax({
                                                                                                                                            type: 'post',
                                                                                                                                            url: 'DoacaoCadastrar',
                                                                                                                                            data: {
                                                                                                                                                idDoacao: $('#idDoacao').val(),
                                                                                                                                                valorDoacao: $('#valorDoacao').val(),
                                                                                                                                                dataDoacao: $('#dataDoacao').val(),
                                                                                                                                                descricao: $('#descricao').val(),
                                                                                                                                                idPatrocinador: $("#idPatrocinador").val(),
                                                                                                                                                idEvento: $("#idEvento").val(),
                                                                                                                                                situacao: $("#situacao").val(),

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
                                                                                                                                                                text: 'Doação gravada com sucesso!',
                                                                                                                                                                showConfirmButton: true,
                                                                                                                                                                timer: 10000
                                                                                                                                                            }).then(function () {
                                                                                                                                                                if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                    window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                    } else {
                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                    }
                                                                                                                                                                                                })
                                                                                                                                                                                            } else if (data == 0) {
                                                                                                                                                                                                Swal.fire({
                                                                                                                                                                                                    position: 'center',
                                                                                                                                                                                                    icon: 'error',
                                                                                                                                                                                                    title: 'Erro',
                                                                                                                                                                                                    text: 'Não foi possível gravar a Doação!',
                                                                                                                                                                                                    showConfirmButton: true,
                                                                                                                                                                                                    timer: 10000
                                                                                                                                                                                                }).then(function () {
                                                                                                                                                                                                    if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                                                        } else {
                                                                                                                                                                                                                                            window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                    })
                                                                                                                                                                                                                                } else {
                                                                                                                                                                                                                                    Swal.fire({
                                                                                                                                                                                                                                        position: 'center',
                                                                                                                                                                                                                                        icon: 'error',
                                                                                                                                                                                                                                        title: 'Erro',
                                                                                                                                                                                                                                        text: 'Já existe uma Doação!',
                                                                                                                                                                                                                                        showConfirmButton: true,
                                                                                                                                                                                                                                        timer: 10000
                                                                                                                                                                                                                                    }).then(function () {
                                                                                                                                                                                                                                        if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                                                                                            window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                                                                                            } else {
                                                                                                                                                                                                                                                                                window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                                                                                            }

                                                                                                                                                                                                                                                                        })

                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                        error:
                                                                                                                                                                                                                                                                function (data) {
                                                                                                                                                                                                                                                                    if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                                                                                                                } else {
                                                                                                                                                                                                                                                                                                    window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                                                            }


                                                                                                                                                                                                                                                                            function deletar(codigo, situacao) {
                                                                                                                                                                                                                                                                                var id = codigo;
                                                                                                                                                                                                                                                                                var status = situacao;
                                                                                                                                                                                                                                                                                console.log(codigo);
                                                                                                                                                                                                                                                                                console.log(status);

                                                                                                                                                                                                                                                                                if (status == 'P') {
                                                                                                                                                                                                                                                                                    Swal.fire({
                                                                                                                                                                                                                                                                                        position: 'center',
                                                                                                                                                                                                                                                                                        icon: 'error',
                                                                                                                                                                                                                                                                                        title: 'Só é possível excluir doação que não foram baixadas!',
                                                                                                                                                                                                                                                                                        showConfirmButton: true
                                                                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                                                                                } else {

                                                                                                                                                                                                                                                                                    Swal.fire({
                                                                                                                                                                                                                                                                                        title: 'Você tem certeza?',
                                                                                                                                                                                                                                                                                        text: 'Você deseja realmente excluir doação?',
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
                                                                                                                                                                                                                                                                                                url: '${pageContext.request.contextPath}/DoacaoExcluir',
                                                                                                                                                                                                                                                                                                data: {
                                                                                                                                                                                                                                                                                                    idDoacao: id
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
                                                                                                                                                                                                                                                                                                                    text: 'Doação Excluida com Sucesso',
                                                                                                                                                                                                                                                                                                                    showConfirmButton: true,
                                                                                                                                                                                                                                                                                                                    timer: 10000
                                                                                                                                                                                                                                                                                                                }).then(function () {
                                                                                                                                                                                                                                                                                                                    if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                                                                                                                                                                                    } else {
                                                                                                                                                                                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                                })
                                                                                                                                                                                                                                                                                                                                                            } else {
                                                                                                                                                                                                                                                                                                                                                                Swal.fire({
                                                                                                                                                                                                                                                                                                                                                                    position: 'center',
                                                                                                                                                                                                                                                                                                                                                                    icon: 'error',
                                                                                                                                                                                                                                                                                                                                                                    title: 'Erro',
                                                                                                                                                                                                                                                                                                                                                                    text: 'Não foi possível excluir doação!',
                                                                                                                                                                                                                                                                                                                                                                    showConfirmButton: true,
                                                                                                                                                                                                                                                                                                                                                                    timer: 10000
                                                                                                                                                                                                                                                                                                                                                                }).then(function () {
                                                                                                                                                                                                                                                                                                                                                                    if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                                                                                                                                                                                                                                    } else {
                                                                                                                                                                                                                                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                                                                                })
                                                                                                                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                                                                                                                        },
                                                                                                                                                                                                                                                                                                                                                                                                error:
                                                                                                                                                                                                                                                                                                                                                                                                        function (data) {
                                                                                                                                                                                                                                                                                                                                                                                                            if (${eventoCarregadoDoacao.idEvento != null}) {
                                                                                                                                                                                                                                                                                                                                                                                                                window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=${eventoCarregadoDoacao.idEvento}";
                                                                                                                                                                                                                                                                                                                                                                                                                                                    } else {
                                                                                                                                                                                                                                                                                                                                                                                                                                                        window.location.href = "${pageContext.request.contextPath}/DoacaoListar?idEvento=0";
                                                                                                                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                                                                                                                                                    });
                                                                                                                                                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                                                                                                                                                ;
                                                                                                                                                                                                                                                                                                                                                                                                                            });
                                                                                                                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                                                                                                                    }

                                                                                                                                                                                                                                                                                                                                                                                                                    function menuAtivo() {
                                                                                                                                                                                                                                                                                                                                                                                                                        document.getElementById('titulopainel').innerHTML = "<strong>Doação</strong>";
                                                                                                                                                                                                                                                                                                                                                                                                                        document.getElementById('menudoacao').classList.add("active");
                                                                                                                                                                                                                                                                                                                                                                                                                    }

                                                                                                                                                                                                                                                                                                                                                                                                                    $(document).ready(function () {
                                                                                                                                                                                                                                                                                                                                                                                                                        menuAtivo();
                                                                                                                                                                                                                                                                                                                                                                                                                    });

    </script>
    <%@include file="/painel/footer.jsp"%>