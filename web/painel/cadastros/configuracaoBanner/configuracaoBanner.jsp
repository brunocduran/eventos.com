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
                                <th align="center">Título Banner</th>
                                <th align="left">Data Início</th>
                                <th align="left">Data Término</th>
                                <th align="center">Tipo Banner</th>
                                <th align="center"></th>
                                <th align="center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="configuracaoBanner" items="${configuracaobanners}">
                                <tr>
                                    <td align="left">${configuracaoBanner.idConfiguracaoBanner}</td>
                                    <td align="left">${configuracaoBanner.tituloBanner}</td>
                                    <td align="left"><fmt:formatDate pattern="dd/MM/yyyy" value="${configuracaoBanner.dataInicial}"/></td>
                                    <td align="left"><fmt:formatDate pattern="dd/MM/yyyy" value="${configuracaoBanner.dataFinal}"/></td>
                                    <td align="left">
                                        <c:if test="${configuracaoBanner.tipoBanner == 'C'}">
                                            Central
                                        </c:if>

                                        <c:if test="${configuracaoBanner.tipoBanner == 'S'}">
                                            Lateral Superior
                                        </c:if>

                                        <c:if test="${configuracaoBanner.tipoBanner == 'I'}">
                                            Lateral Inferior
                                        </c:if>
                                    </td>
                                    <td align="center">
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                           data-id="" onclick="setDadosModal(${configuracaoBanner.idConfiguracaoBanner})">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/ConfiguracaoBannerExcluir?idConfiguracaoBanner=${configuracaoBanner.idConfiguracaoBanner}" class="btn btn-danger">
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
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Adicionar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col">
                                <div class="card shadow mb-4">
                                    <div class="card-body">
                                        <div class="form-group">
                                            <center>
                                                <img alt="imagem" clas="img-thumbnail" src=""
                                                     name="imagem" id="imagem" width="500" height="215">
                                                <br></br>
                                                <input type="file" id="gallery-photo-add"
                                                       class="inputfile" onchange="uploadFile()"/>
                                                Tamanho recomendado para imagem: 1000 x 430 px<br>
                                                <label for="gallery-photo-add" class="btn btn-success">
                                                    <i class="fas fa-file-upload"></i>
                                                    Selecionar Foto
                                                </label>                                       
                                            </center>       
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idconfiguracaobanner" id="idconfiguracaobanner" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Título Banner</label>
                                <input class="form-control" type="text" name="titulobanner" id="titulobanner" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Mensagem Banner</label>
                                <input class="form-control" type="text" name="msgbanner" id="msgbanner" value=""/>
                            </div>

                            <div class="form-group">
                                <label>Tipo Banner</label>
                                <select class="form-control" name="tipobanner" id="tipobanner" required>
                                    <option value="C">Central</option>
                                    <option value="S">Lateral Superior</option>
                                    <option value="I">Lateral Inferior</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label for="datainicial" id="labeldatainicial">Data Início</label>
                                        <input class="form-control" type="date" name="datainicial" id="datainicial" value="${configuracaoBanner.dataInicial}"
                                               maxLength="8" />
                                    </div>
                                    <div class="col-sm">
                                        <label for="datafinal" id="labeldatafinal">Data Término</label>
                                        <input class="form-control" type="date" name="datafinal" value="${configuracaoBanner.dataFinal}"
                                               id="datafinal" maxLength="5" />
                                    </div>

                                </div>
                            </div>


                            <div class="form-group">
                                <label>Evento</label>
                                <select class="form-control" name="idevento" id="idevento" required>
                                    <option value="nulo">Selecione</option>
                                    <c:forEach var="evento" items="${eventos}">
                                        <option value="${evento.idEvento}" ${ConfiguracaoBanner.evento.idEvento == evento.idEvento ? "selected" : ""}>
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


    function limparDadosModal() {
        $('#idconfiguracaobanner').val("0");
        $('#titulobanner').val("");
        $('#msgbanner').val("");
        $('#tipobanner').val("");
        $('#datainicial').val("");
        $('#datafinal').val("");
        $('#situacao').val("");
        $('#idevento').val("");
        imagem.src = "";
    }

    function setDadosModal(valor) {
        limparDadosModal();
        var imagem = document.getElementById("imagem");
        document.getElementById('idconfiguracaobanner').value = valor;
        var idConfiguracaoBanner = valor;
        if (idConfiguracaoBanner != "0") {
            $.getJSON('ConfiguracaoBannerCarregar', {idConfiguracaoBanner: idConfiguracaoBanner}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idCategoriaEvento;
                if (id != "0") {
                    $('#idconfiguracaobanner').val(respostaServlet.idConfiguracaoBanner);
                    $('#titulobanner').val(respostaServlet.tituloBanner);
                    $('#msgbanner').val(respostaServlet.msgBanner);
                    $('#tipobanner').val(respostaServlet.tipoBanner);
                    $('#datainicial').val(respostaServlet.dataInicial);
                    $('#datafinal').val(respostaServlet.dataFinal);
                    $('#situacao').val(respostaServlet.situacao);
                    $('#idevento').val(respostaServlet.evento.idEvento);
                    var imagem = document.getElementById("imagem");
                    imagem.src = respostaServlet.imagem;
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
            titulo = "Você deseja realmente ativar a Configuracao Banner?";
            confirmButtonText = "Sim, ative a Configracao Banner!";
            tituloConfirmacao = "Configracao Banner ativada com sucesso!";

        } else {
            titulo = "Você deseja realmente inativar a Configuracao Banner?";
            confirmButtonText = "Sim, inative a Configuracao Banner!";
            tituloConfirmacao = "Configuracao Banner inativada com sucesso!";
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
                    url: '${pageContext.request.contextPath}/ConfiguracaoBannerExcluir',
                    data: {
                        idConfiguracaoBanner: id
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
                                        window.location.href = "${pageContext.request.contextPath}/ConfiguracaoBannerListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível ativar/inativar a Configuracao Banner!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/ConfiguracaoBannerListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/ConfiguracaoBannerListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log("entrei na validação de campos");
        if (document.getElementById("titulobanner").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a descrição!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#titulobanner").focus();

        } else if (document.getElementById("msgbanner").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a mensagem do banner!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#msgbanner").focus();

        } else if (document.getElementById("tipobanner").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o tipo do banner!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#tipobanner").focus();

        } else if (document.getElementById("datainicial").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a data início!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#datainicial").focus();

        } else if (document.getElementById("datafinal").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a data final!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#datafinal").focus();

        } else if (document.getElementById("datainicial").value > document.getElementById("datafinal").value) {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Data de termino anterior a data de início!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("idevento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o evento!',
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
        var target = document.getElementById("imagem").src;
        $.ajax({
            type: 'post',
            url: 'ConfiguracaoBannerCadastrar',
            data: {
                idconfiguracaobanner: $('#idconfiguracaobanner').val(),
                titulobanner: $('#titulobanner').val(),
                msgbanner: $('#msgbanner').val(),
                tipobanner: $('#tipobanner').val(),
                datainicial: $('#datainicial').val(),
                datafinal: $('#datafinal').val(),
                idevento: $("#idevento").val(),
                situacao: $("#situacao").val(),
                imagem: target
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
                                text: 'Configuração Banner gravada com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/ConfiguracaoBannerListar";
                            })
                        } else if (data == 0) {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar a Configuração Banner!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/ConfiguracaoBannerListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Já existe um banner nesse período!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {

                            })

                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/ConfiguracaoBannerListar";
                    }
        });
    }


    function uploadFile() {
        // pega o documento html da pagina
        var target = document.getElementById("imagem");
        //limpa a imagem
        target.src = "";
        // abre a janela para seleçao do arquivo
        var file = document.querySelector("input[type='file']").files[0];
        //verifica se o arquivo existe
        if (file) {
            //faz a leitura do arquivo da imagem
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function () {
                //atribui a imagem do arquivo ao compornente hrml imagem
                target.src = reader.result;
            };

        } else {
            target.src = "";
        }

    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Configuração Banner</strong>";
        document.getElementById('agrupamentoevento').classList.add("menu-open");
        document.getElementById('menueventoagrupamento').classList.add("active");
        document.getElementById('menuconfiguracaobanner').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>