<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/home/header.jsp"/>
<jsp:include page="/home/navbar.jsp"/>

<div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
    <div class="navbar-nav mr-auto py-0">
        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link">Home</a>

        <a href="${pageContext.request.contextPath}/home/contact.jsp" class="nav-item nav-link">Contato</a>
    </div>

</div>
</div>
</nav>
</div>
</div>
</div>



<div class="container-fluid pb-5"> <!--inicio div da imagem, detalhes evento e detalhes atividade -->    

    <div class="row px-xl-5"> <!--inicio div da imagem e detalhes-->

        <div class="col-lg-6 mb-30"> <!--inicio da imagem-->
            <img class="w-100 h-100" src="${evento.imagem}" alt="imagem" name="target" id="target">                
        </div> <!--final da imagem-->

        <div class="col-lg-6 h-auto mb-30"><!--inicio dos detalhes evento-->
            <div class="h-100 bg-light p-30">

                <div class="form-group">
                    <div class="form-line row">
                        <div class="col-sm">
                            <h3>${evento.nomeEvento}</h3>
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
                            <h4>Data início:
                                <small class="text-muted">
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataInicioEvento}"/>
                                </small>                                
                            </h4>                            
                        </div>
                        <div class="col-sm">
                            <h4>Data término:
                                <small class="text-muted">
                                    <fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataTerminoEvento}"/>
                                </small>                                
                            </h4>                            
                        </div>
                    </div>
                </div>
                <div class="form-group">                    
                    <div class="form-line row">
                        <div class="col-sm">
                            <h4>Valor à vista:
                                <small class="text-muted">                                    
                                    <fmt:formatNumber value="${evento.valorEvento}" type="currency"/>
                                </small>                                
                            </h4>                            
                        </div>
                        <div class="col-sm">
                            <h4>Valor a prazo:
                                <small class="text-muted">                                    
                                    <fmt:formatNumber value="${evento.valorEventoPrazo}" type="currency"/>
                                </small>                                
                            </h4>                            
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="form-line row">

                        <div class="col-sm">
                            <h4>Cidade:
                                <small class="text-muted">                                    
                                    ${evento.cidade.nomeCidade} - ${evento.cidade.estado.siglaEstado}
                                </small>                                
                            </h4>                            
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
                            <h4>Informações:
                            <small class="text-muted">
                                ${evento.informacaoEvento}
                            </small>
                            </h4>
                        </div>                        
                    </div>
                </div> 

                <hr>
                <div align="right">
                    <button class="btn btn-success" id="salvarecontinuar" onclick="">Inscreva-se <i
                            class="fa fa-arrow-right"></i></button>
                </div>
            </div>
        </div><!--final dos detalhes evento-->

    </div><!--final div da imagem e detalhes-->

    <div class="row px-xl-5"><!--inicio div da detalhes atividade -->
        <div class="col">
            <div class="bg-light p-30">
                <div class="form-group">
                    <div class="form-line row">
                        <div class="col-sm">
                            <h3>Atividades</h3>
                            <hr>
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
                                                <b>Carga Horária:</b> ${atividadeEvento.cargaHoraria}<br>
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
        </div>
    </div><!--inicio div da detalhes atividade -->

</div><!--final div da imagem, detalhes evento e detalhes atividade -->






<script>

    document.addEventListener('DOMContentLoaded', function () {
        window.stepper = new Stepper(document.querySelector('.bs-stepper'))
    });

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Evento</strong>";
        document.getElementById('menuevento').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });


    // INICIO DA PARTE DE EVENTO
    function validarCamposEvento() {
        if (document.getElementById("nomeevento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome',
                showConfirmButton: true,
                timer: 2000
            });
            $("#nomeevento").focus();
        } else if (document.getElementById("datainicioevento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a data de início!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#datainicioevento").focus();
        } else if (document.getElementById("dataterminoevento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a data término!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#dataterminoevento").focus();
        } else if (document.getElementById("idcidade").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a cidade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("idcurso").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o curso!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("idcategoriaevento").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a categoria!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("datainicioevento").value > document.getElementById("dataterminoevento").value) {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Data de termino anterior a data de início!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else {
            gravarDados();

        }
    }

    function gravarDados() {
        console.log("Gravando dados....");
        var target = document.getElementById("target").src;
        console.log("Situacao caixa: " + $('#situacaocaixa').val());
        $.ajax({
            type: 'post',
            url: 'EventoCadastrar',
            data: {
                idEvento: $('#idevento').val(),
                nomeEvento: $('#nomeevento').val(),
                valorEvento: $('#valorevento').val(),
                valorEventoPrazo: $('#valoreventoprazo').val(),
                dataInicioEvento: $('#datainicioevento').val(),
                dataTerminoEvento: $('#dataterminoevento').val(),
                situacaoEvento: $('#situacaoevento').val(),
                saldoCaixa: $('#saldocaixa').val(),
                situacaoCaixa: $('#situacaocaixa').val(),
                imagem: target,
                idCidade: $('#idcidade').val(),
                idCurso: $('#idcurso').val(),
                idCategoriaEvento: $('#idcategoriaevento').val(),
                informacaoEvento: $('#informacaoevento').val()
            },
            success:
                    function (data) {
                        console.log("resposta servlet->");
                        //console.log(data);
                        var jSon = JSON.parse(data);
                        var id = jSon.idEvento;
                        console.log("Testeeee: " + id);
                        if (id > 0) {
                            //ver o que vai fazer aqui
                            $('#idevento').val(id);
                            stepper.next();
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o Evento!',
                                showConfirmButton: false,
                                timer: 1000
                            })
                        }
                    },
            error:
                    function (data) {
                        //window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                    }
        });
    }

    function uploadFile() {
        // pega o documento html da pagina
        var target = document.getElementById("target");
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
    // FIM DA PARTE DE EVENTO


    // INICIO DA PARTE DE ORGANIZADOR EVENTO
    function validarCamposOrganizador() {
        if (document.getElementById("idorganizador").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o organizador!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("idfuncao").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a funcao!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else {
            gravarDadosOrganizador();

        }
    }

    function gravarDadosOrganizador() {
        $.ajax({
            type: 'post',
            url: 'OrganizadorEventoCadastrar',
            data: {
                idOrganizadorEvento: $('#idorganizadorevento').val(),
                idEvento: $('#idevento').val(),
                idOrganizador: $('#idorganizador').val(),
                idFuncao: $('#idfuncao').val()
            },
            success:
                    function (data) {
                        // console.log("resposta servlet->");
                        // console.log(data);
                        if (data == 0) {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o Organizador do Evento!',
                                showConfirmButton: false,
                                timer: 1000
                            })
                        } else {
                            var jSon = JSON.parse(data);
                            console.log("JSON ORGANIZADOR " + data);
                            var id = jSon.idOrganizadorEvento;
                            if (id > 0) {
                                var nomeOrganizador = jSon.organizador.nomeRazaoPessoa + " - " + jSon.funcao.descricao;
                                adcDivOrganizador(id, nomeOrganizador);
                                limparDadosOrganizador();
                            } else {
                                Swal.fire({
                                    position: 'center',
                                    icon: 'error',
                                    title: 'Erro',
                                    text: 'Não foi possível gravar o Organizador do Evento!',
                                    showConfirmButton: false,
                                    timer: 1000
                                })
                            }
                        }
                    },
            error:
                    function (data) {
                        //window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                    }
        });
    }

    function adcDivOrganizador(idOrganizadorEvento, nomeOrganizador) {
        var html = '<div id="divOrg_' + idOrganizadorEvento + '">'//alterar para o id do organizador
                + '<div class="form-group"></div><div class="form-line row">'
                + '<div class="col-sm">'
                + '<div class="input-group input-group-mb-3">'
                + '<input type="text" class="form-control" id="nomeOrg_' + idOrganizadorEvento + '" value="' + nomeOrganizador + '" disabled/>'//alterar o id e value
                + '<span class="input-group-append">'
                + '<button type="button" onclick="setDadosOrganizador(' + idOrganizadorEvento + ')" class="btn btn-success btn-flat">Editar</button>'//alterar o valor do deletar
                + '<button type="button" onclick="deletarOrganizador(' + idOrganizadorEvento + ')" class="btn btn-danger btn-flat">Remover</button>'
                + '</span></div></div></div> '
                + '</div>';
        $("#espacoaddorganizador").append(html);
    }

    function deletarOrganizador(idorganizadorevento) {
        var id = idorganizadorevento;
        console.log(idorganizadorevento);

        var titulo = "";
        var tituloConfirmacao = "";
        var confirmButtonText = "";

        titulo = "Você deseja realmente excluir o Organizador?";
        confirmButtonText = "Sim, exclua o Organizador!";
        tituloConfirmacao = "Organizador excluido com sucesso!";

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
                    url: '${pageContext.request.contextPath}/OrganizadorEventoExcluir',
                    data: {
                        idOrganizadorEvento: id
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
                                        // window.location.href = "${pageContext.request.contextPath}/FuncaoListar";
                                        removeLinhaOrganizadorHTML(idorganizadorevento);
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível excluir o Organizador!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        // window.location.href = "${pageContext.request.contextPath}/FuncaoListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/FuncaoListar";
                            }
                });
            }
            ;
        });


    }

    function removeLinhaOrganizadorHTML(idorganizadorevento) {
        var id = "divOrg_" + idorganizadorevento;
        // Removendo um nó a partir do pai
        var node = document.getElementById(id);
        if (node.parentNode) {
            node.parentNode.removeChild(node);
        }

    }

    function setDadosOrganizador(valor) {
        limparDadosOrganizador();
        document.getElementById('idorganizadorevento').value = valor;
        var idOrganizadorEvento = valor;
        if (idOrganizadorEvento != "0") {
            $.getJSON('OrganizadorEventoCarregar', {idOrganizadorEvento: idOrganizadorEvento}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idOrganizadorEvento;
                if (id != "0") {
                    $('#idorganizadorevento').val(respostaServlet.idOrganizadorEvento);
                    $('#idorganizador').val(respostaServlet.organizador.idOrganizador);
                    $('#idfuncao').val(respostaServlet.funcao.idFuncao);
                    removeLinhaOrganizadorHTML(respostaServlet.idOrganizadorEvento);
                    $('#btnadicionarorganizador').text('Salvar');
                    $('#labelorganizador').text('Editando Organizador');
                    $('#labelfuncao').text('Editando Função');
                }
            });
        }
    }

    function limparDadosOrganizador() {
        $('#idorganizadorevento').val("0");
        $('#idorganizador').val("nulo");
        $('#idfuncao').val("nulo");
        $('#btnadicionarorganizador').text('Adicionar');
        $('#labelorganizador').text('Organizador');
        $('#labelfuncao').text('Função');
    }
    // FIM DA PARTE DE ORGANIZADOR EVENTO



    // INICIO DA PARTE DE ATIVIDADE EVENTO
    function validarCamposAtividade() {
        if (document.getElementById("nomeatividade").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome da atividade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("dataatividade").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a data da atividade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("horaatividade").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a hora da atividade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("idtipoatividade").value == 'nulo') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o tipo da atividade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("cargahoraria").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a carga horária da atividade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else if (document.getElementById("cargahoraria").value == '0') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a carga horária da atividade!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#idcidade").focus();
        } else {
            gravarDadosAtividade();

        }
    }

    function gravarDadosAtividade() {
        $.ajax({
            type: 'post',
            url: 'AtividadeEventoCadastrar',
            data: {
                idAtividadeEvento: $('#idatividadeevento').val(),
                idEvento: $('#idevento').val(),
                idTipoAtividade: $('#idtipoatividade').val(),
                cargaHoraria: $('#cargahoraria').val(),
                nomeAtividade: $('#nomeatividade').val(),
                resumo: $('#resumo').val(),
                dataAtividade: $('#dataatividade').val(),
                horaAtividade: $('#horaatividade').val()
            },
            success:
                    function (data) {
                        // console.log("resposta servlet->");
                        // console.log(data);
                        if (data == 0) {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar a Atividade do Evento!',
                                showConfirmButton: false,
                                timer: 1000
                            })
                        } else {
                            var jSon = JSON.parse(data);
                            console.log("JSON ATIVIDADE " + data);
                            var id = jSon.idAtividadeEvento;
                            if (id > 0) {
                                var nomeAtividade = "<b>Atividade:</b> " + jSon.nomeAtividade + "<br><b>Data:</b> " + jSon.dataAtividade.replace(/[^\d]/g, "").replace(/^(\d{4})(\d{2})(\d{2})/, "$3/$2/$1")
                                        + "<br><b>Hora:</b> " + jSon.horaAtividade + "<br><b>Carga horária:</b> " + jSon.cargaHoraria + "<br><b>Tipo de Atividade:</b> " + jSon.tipoAtividade.descricao + "<br><b>Resumo:</b> " + jSon.resumo;
                                adcDivAtividadeEvento(id, nomeAtividade);
                                limparDadosAtividade();
                            } else {
                                Swal.fire({
                                    position: 'center',
                                    icon: 'error',
                                    title: 'Erro',
                                    text: 'Não foi possível gravar a Atividade do Evento!',
                                    showConfirmButton: false,
                                    timer: 1000
                                })
                            }
                        }
                    },
            error:
                    function (data) {
                        //window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                    }
        });
    }

    function adcDivAtividadeEvento(idAtividadeEvento, nomeAtividadeEvento) {
        var html = '<div id="divAtv_' + idAtividadeEvento + '">'
                + '<div class="form-group"></div>'
                + '<div class="form-line row">'
                + '<div class="col-sm">'
                + '<div class="input-group input-group-mb-3">'
                + '<div style="background-color: #E9ECEF; width: 100%; border-color: #cacbcc; border-width: 1px; border-style: solid; padding: 10px;">'
                + nomeAtividadeEvento
                + '<hr>'
                + '<div align="right">'
                + '<button type="button" onclick="setAtividadeEvento(' + idAtividadeEvento + ')" class="btn btn-success btn-flat">Editar</button>'
                + '<button type="button" onclick="deletarAtividadeEvento(' + idAtividadeEvento + ')" class="btn btn-danger btn-flat">Remover</button>'
                + '</div></div></div></div></div></div>';
        $("#espacoaddatividadeevento").append(html);
    }

    function setAtividadeEvento(valor) {
        limparDadosAtividade();
        document.getElementById('idatividadeevento').value = valor;
        var idAtividadeEvento = valor;
        if (idAtividadeEvento != "0") {
            $.getJSON('AtividadeEventoCarregar', {idAtividadeEvento: idAtividadeEvento}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idAtividadeEvento;
                if (id != "0") {
                    $('#idatividadeevento').val(respostaServlet.idAtividadeEvento);
                    $('#idtipoatividade').val(respostaServlet.tipoAtividade.idTipoAtividade);
                    $('#cargahoraria').val(respostaServlet.cargaHoraria);
                    $('#nomeatividade').val(respostaServlet.nomeAtividade);
                    $('#resumo').val(respostaServlet.resumo);
                    $('#dataatividade').val(respostaServlet.dataAtividade);
                    $('#horaatividade').val(respostaServlet.horaAtividade);
                    removeLinhaAtividadeEventoHTML(respostaServlet.idAtividadeEvento);
                    $('#btnadicionaratividade').text('Salvar');
                    $('#labelnomeatividade').text('Editando Atividade');
                }
            });
        }
    }

    function limparDadosAtividade() {
        $('#idatividadeevento').val("0");
        $('#idtipoatividade').val("nulo");
        $('#cargahoraria').val("0");
        $('#nomeatividade').val("");
        $('#resumo').val("");
        $('#dataatividade').val("");
        $('#horaatividade').val("");
        $('#btnadicionaratividade').text('Adicionar');
        $('#labelnomeatividade').text('Nome Atividade');
    }

    function deletarAtividadeEvento(idatividadeevento) {
        var id = idatividadeevento;
        console.log(idatividadeevento);

        var titulo = "";
        var tituloConfirmacao = "";
        var confirmButtonText = "";

        titulo = "Você deseja realmente excluir a Atividade do Evento?";
        confirmButtonText = "Sim, exclua a Atividade do Evento!";
        tituloConfirmacao = "Atividade do Evento excluida com sucesso!";

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
                    url: '${pageContext.request.contextPath}/AtividadeEventoExcluir',
                    data: {
                        idAtividadeEvento: id
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
                                        removeLinhaAtividadeEventoHTML(idatividadeevento);
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível excluir a Atividade do Evento!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/EventoListar";
                            }
                });
            }
            ;
        });


    }

    function removeLinhaAtividadeEventoHTML(idatividadeevento) {
        var id = "divAtv_" + idatividadeevento;
        // Removendo um nó a partir do pai
        var node = document.getElementById(id);
        if (node.parentNode) {
            node.parentNode.removeChild(node);
        }

    }
</script>

<jsp:include page="/home/footer.jsp"/>