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
                                <div class="card card-default">
                                    <div class="card-header">
                                        <h3 class="card-title">Cadastro de Evento</h3>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="bs-stepper">
                                            <div class="bs-stepper-header" role="tablist">
                                                <!-- Configuração do cabecalho do passo a passo -->
                                                <div class="step" data-target="#dadosproduto-part">
                                                    <button type="button" class="step-trigger" role="tab" aria-controls="dadosproduto-part"
                                                            id="dadosproduto-part-trigger">
                                                        <span class="bs-stepper-circle">1</span>
                                                        <span class="bs-stepper-label">Dados</span>
                                                    </button>
                                                </div>
                                                <div class="line"></div>
                                                <div class="step" data-target="#organizadores-part">
                                                    <button type="button" class="step-trigger" role="tab" aria-controls="organizadores-part"
                                                            id="organizadores-part-trigger">
                                                        <span class="bs-stepper-circle">2</span>
                                                        <span class="bs-stepper-label">Organizadores</span>
                                                    </button>
                                                </div>
                                                <div class="line"></div>
                                                <div class="step" data-target="#atividades-part">
                                                    <button type="button" class="step-trigger" role="tab" aria-controls="atividades-part" id="atividades-part-trigger">
                                                        <span class="bs-stepper-circle">3</span>
                                                        <span class="bs-stepper-label">Atividades</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="bs-stepper-content">
                                                <div id="dadosproduto-part" class="content" role="tabpanel" aria-labelledby="dadosproduto-part-trigger">
                                                    <div class="card-body">
                                                        <div class="form-group">
                                                            <div class="form-line row">
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
                                                                <div class="col-6">
                                                                    <label for="nomeevento" id="labelnomeevento">Nome Evento</label>
                                                                    <input type="text" class="form-control" maxlength="100" value="${evento.nomeEvento}"
                                                                           id="nomeevento" name="nomeevento" placeholder="Digite o nome do evento">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="datainicioevento" id="labeldatainicioevento">Data Início</label>
                                                                    <input class="form-control" type="date" name="datainicioevento" id="datainicioevento" value="${evento.dataInicioEvento}"
                                                                           maxLength="8" />
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="dataterminoevento" id="labeldataterminoevento">Data Término</label>
                                                                    <input class="form-control" type="date" name="dataterminoevento" value="${evento.dataTerminoEvento}"
                                                                           id="dataterminoevento" maxLength="5" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <div class="col-sm">
                                                                    <label for="valorevento" id="labelvalorevento">Valor</label>
                                                                    <input class="form-control" style="text-align:right;"
                                                                           type="number" min="0" max="100" step=".01"
                                                                           value="<fmt:formatNumber value='${evento.valorEvento}'/>"
                                                                           id="valorevento" name="valorevento">
                                                                </div>
                                                                <div class="col-sm">
                                                                    <label for="valoreventoprazo" id="labelvaloreventoprazo">Valor Prazo</label>
                                                                    <input class="form-control" style="text-align:right;"
                                                                           type="number" min="0" max="100" step=".01"
                                                                           value="<fmt:formatNumber value='${evento.valorEventoPrazo}'/>"
                                                                           id="valoreventoprazo" name="valoreventoprazo">
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <!-- Loop das cidades -->                                                                
                                                                <div class="col-sm">
                                                                    <label id="labelcidade" for="idcidade">Cidade</label>
                                                                    <select class="form-control" name="idcidade" id="idcidade" required>
                                                                        <option value="nulo">Selecione</option>
                                                                        <c:forEach var="cidade" items="${cidades}">
                                                                            <option value="${cidade.idCidade}" ${evento.cidade.idCidade == cidade.idCidade ? "selected" : ""}>
                                                                                ${cidade.nomeCidade}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>    
                                                                <!-- Loop dos cursos -->
                                                                <div class="col-sm">
                                                                    <label id="labelcurso" for="idcurso">Curso</label>
                                                                    <select class="form-control" name="idcurso" id="idcurso" required>
                                                                        <option value="nulo">Selecione</option>
                                                                        <c:forEach var="curso" items="${cursos}">
                                                                            <option value="${curso.idCurso}" ${evento.curso.idCurso == curso.idCurso ? "selected" : ""}>
                                                                                ${curso.nomeCurso}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>  
                                                                <!-- Loop das categorias -->
                                                                <div class="col-sm">
                                                                    <label id="labelcategoriaevento" for="idcategoriaevento">Categoria</label>
                                                                    <select class="form-control" name="idcategoriaevento" id="idcategoriaevento" required>
                                                                        <option value="nulo">Selecione</option>
                                                                        <c:forEach var="categoriaEvento" items="${categoriaeventos}">
                                                                            <option value="${categoriaEvento.idCategoriaEvento}" ${evento.categoriaEvento.idCategoriaEvento == categoriaEvento.idCategoriaEvento ? "selected" : ""}>
                                                                                ${categoriaEvento.nome}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>  
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <div class="col-sm">
                                                                    <label for="informacaoevento" id="labelinformacaoevento">Informações</label>
                                                                    <textarea class="form-control" id="informacaoevento" name="informacaoevento" rows="3"
                                                                              placeholder="Digite detalhes do evento"
                                                                              maxlength="500">${evento.informacaoEvento}</textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="card-body">
                                                                <div class="form-group">
                                                                    <center>
                                                                        <img alt="imagem" clas="img-thumbnail" src="${evento.imagem}"
                                                                             name="target" id="target" width="200" height="200">
                                                                        <br></br>
                                                                        <input type="file" id="gallery-photo-add"
                                                                               class="inputfile" onchange="uploadFile()"/>
                                                                        Tamanho recomendado para imagem: 500 x 500 px<br>
                                                                        <label for="gallery-photo-add" class="btn btn-primary">
                                                                            <i class="nav-icon fas fa-file-upload"></i>
                                                                            Selecionar Foto
                                                                        </label>                                       
                                                                    </center>       
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div align="right">
                                                            <button class="btn btn-success" id="salvarecontinuar" onclick="validarCamposEvento()">Salvar e continuar <i
                                                                    class="fa fa-arrow-right"></i></button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--</form>-->
                                                <!-- Fim dos dados iniciais do evento -->
                                                <!-- Inicio organizadores -->
                                                <div id="organizadores-part" class="content" role="tabpanel" aria-labelledby="organizadores-part-trigger">
                                                    <div class="card-body">
                                                        <div class="form-group">                                                            
                                                            <div class="form-line row">
                                                                <div class="col-sm">

                                                                    <input class="form-control" 
                                                                           type="hidden"
                                                                           name="idorganizadorevento" id="idorganizadorevento"
                                                                           value="0" readonly="readonly">
                                                                    <label for="idorganizador" id="labelorganizador">Organizador</label>
                                                                    <div class="input-group input-group-mb-3">                                                                        
                                                                        <select class="form-control" name="idorganizador" id="idorganizador" required>
                                                                            <option value="nulo">Selecione</option>
                                                                            <c:forEach var="organizador" items="${organizadores}">
                                                                                <option value="${organizador.idOrganizador}"}>
                                                                                    ${organizador.nomeRazaoPessoa}
                                                                                </option>
                                                                            </c:forEach>
                                                                        </select>                                                                       
                                                                    </div>
                                                                </div>                                                                
                                                                <div class="col-sm">
                                                                    <label for="idfuncao" id="labelfuncao">Função</label>
                                                                    <div class="input-group input-group-mb-3">                                                                        
                                                                        <select class="form-control" name="idfuncao" id="idfuncao" required>
                                                                            <option value="nulo">Selecione</option>
                                                                            <c:forEach var="funcao" items="${funcoes}">
                                                                                <option value="${funcao.idFuncao}"}>
                                                                                    ${funcao.descricao}
                                                                                </option>
                                                                            </c:forEach>
                                                                        </select>
                                                                        <span class="input-group-append">
                                                                            <button type="button" onclick="validarCamposOrganizador()"
                                                                                    class="btn btn-primary btn-flat" id="btnadicionarorganizador">Adicionar</button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div id="espacoaddorganizador">
                                                            <!-- falta fazer o loop para trazer os organizadores ao carregar-->



                                                        </div>
                                                        <div class="form-group"></div>
                                                        <hr>
                                                        <div align="right">
                                                            <button class="btn btn-primary" onclick="stepper.previous()"><i class="fa fa-arrow-left"></i> Voltar </button>
                                                            <button class="btn btn-success" onclick="stepper.next()"> Salvar e continuar <i class="fa fa-arrow-right"></i></button>
                                                        </div>


                                                    </div>
                                                </div>
                                                <!-- Fim código de barras -->
                                                <!-- Inicio fotos produto -->
                                                <div id="atividades-part" class="content" role="tabpanel" aria-labelledby="atividades-part-trigger">
                                                    <div class="card-body">
                                                        <div class="form-group">

                                                            <div class="form-line row">
                                                                <input class="form-control" type="hidden" name="idatividadeevento" id="idatividadeevento"
                                                                       value="{evento.idatividadeevento}" readonly="readonly">

                                                                <div class="col-sm">
                                                                    <label for="nomeatividade" id="labelnomeatividade">Nome Atividade</label>
                                                                    <input type="text" class="form-control" maxlength="100" value=""
                                                                           id="nomeatividade" name="nomeatividade" placeholder="Digite o nome da atividade">
                                                                </div>
                                                                <div class="col-sm">
                                                                    <label for="datainicioevento" id="labeldatainicioevento">Data Início</label>
                                                                    <input class="form-control" type="date" name="datainicioevento" id="datainicioevento" value=""
                                                                           maxLength="8" />
                                                                </div>
                                                                <div class="col-sm">
                                                                    <label for="dataterminoevento" id="labeldataterminoevento">Data Término</label>
                                                                    <input class="form-control" type="date" name="dataterminoevento" value=""
                                                                           id="dataterminoevento" maxLength="5" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <div class="col-sm">

                                                                    <label id="labeltipoatividade" for="idtipoatividade">Tipo Atividade</label>
                                                                    <select class="form-control" id="idtipoatividade" name="idtipoatividade">
                                                                        <option id="0" value="0">Selecione o tipo atividade</option>
                                                                        {loop="tiposatividades"}
                                                                        <option id="${value.idtipoatividade}" value="${value.idcidade}" 
                                                                                {if="$value.idcidade == $evento.idcidade"} selected {/if}>
                                                                            ${value.nomemarca}
                                                                        </option>
                                                                        {/loop}
                                                                    </select>
                                                                </div>

                                                                <div class="col-sm">
                                                                    <label for="cargahoraria" id="labelcargahoraria">Carga Horária</label>
                                                                    <input type="text" class="form-control" maxlength="100" value=""
                                                                           id="cargahoraria" name="cargahoraria" placeholder="00">
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">                    
                                                                <div class="col-sm">
                                                                    <label for="resumo" id="labelreumo">Resumo</label>
                                                                    <textarea class="form-control" id="resumo" name="resumo" rows="3"
                                                                              placeholder="Digite detalhes da atividade"
                                                                              maxlength="500"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div align="right">
                                                            <button class="btn btn-primary" onclick="adcDivAtividadeEvento()">Adicionar</button>
                                                        </div>

                                                        <hr>    

                                                        <div id="espacoaddatividadeevento">
                                                            <!--Configurar loop-->
                                                            <div class="input-group input-group-mb-3">
                                                                <input type="text" class="form-control" id="${value.idatividadeevento}"
                                                                       value="${value.nomeatividadeevento}" disabled />
                                                                <span class="input-group-append">
                                                                    <button type="button" onclick="deletar(${value.idatividadeevento})"
                                                                            class="btn btn-danger btn-flat">Remover</button>
                                                                </span>
                                                            </div>

                                                        </div>
                                                        <hr>                  
                                                        <div align="right">
                                                            <button class="btn btn-primary" onclick="stepper.previous()"><i class="fa fa-arrow-left"></i> Voltar </button>
                                                            <a class="btn btn-success" href="/painel/produto">Finalizar</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Fim fotos produto -->

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card -->
                            </div>
                        </div>
                        <!-- /.row -->

                    </div>
                    <!-- /.row -->
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
    function adcDivAtividadeEvento(idatividadeevento, nomeAtividadeEvento) {
        var html = '<div id="divAtv_' + idatividadeevento + '">'//alterar para o id da atividade evento
                + '<div class="form-group"></div><div class="form-line row">'
                + '<div class="col-sm">'
                + '<div class="input-group input-group-mb-3">'
                + '<input type="text" class="form-control" id="divAtv_123" value="Atividade Evento" disabled/>'//alterar o id e value
                + '<span class="input-group-append">'
                + '<button type="button" onclick="deletarAtividadeEvento(' + 123 + ')" class="btn btn-danger btn-flat">Remover</button>'//alterar o valor do deletar
                + '</span></div></div></div> '
                + '</div>';
        $("#espacoaddatividadeevento").append(html);
    }


    function deletarAtividadeEvento(idatividadeevento) {
        /*var url = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2)) + "/codigobarraproduto";
         var dados = "idcodigobarraproduto=" + idcodigobarraproduto;
         
         Swal.fire({
         title: 'Você tem certeza?',
         text: 'Deseja retirar o organizador do evento?',
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#3085d6',
         cancelButtonColor: '#d33',
         confirmButtonText: 'Sim',
         cancelButtonText: 'Cancelar'
         }).then((result) => {
         if (result.isConfirmed) {
         $.ajax({
         asyc: false,
         type: "POST",
         url: url + "/deletar",
         data: dados,
         dataType: "json",
         error: function (xhr) {
         Swal.fire({
         position: 'center',
         icon: 'error',
         title: 'Erro',
         text: 'Não foi possível excluir o codigo de barras do produto!',
         showConfirmButton: true,
         timer: 10000
         }).then(function () {
         window.location.href = url;
         })
         },
         success: function (data) {
         if (data.resultado == 'ok') {
         removeLinhaCodBarraHTML(idcodigobarraproduto);
         }
         }
         });
         
         }
         ;
         });*/

        removeLinhaAtividadeEventoHTML(idatividadeevento);
    }

    function removeLinhaAtividadeEventoHTML(idatividadeevento) {
        var id = "divAtv_" + idatividadeevento;
        // Removendo um nó a partir do pai
        var node = document.getElementById(id);
        if (node.parentNode) {
            node.parentNode.removeChild(node);
        }

//#################################################################################################################################     

    }
</script>
<jsp:include page="/painel/footer.jsp"/>