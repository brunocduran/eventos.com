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
                                                <!-- Dados Iniciais do produto 
                                                -->
                                                <div id="dadosproduto-part" class="content" role="tabpanel" aria-labelledby="dadosproduto-part-trigger">
                                                    <div class="card-body">
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <input class="form-control" type="hidden" name="idevento" id="idevento"
                                                                       value="{evento.idevento}" readonly="readonly">
                                                                <input class="form-control" type="hidden" name="situacaoevento" id="situacaoevento"
                                                                       value="{evento.situacaoevento}" readonly="readonly">
                                                                <input class="form-control" type="hidden" name="saldocaixa" id="saldocaixa"
                                                                       value="{evento.saldocaixa}" readonly="readonly">
                                                                <input class="form-control" type="hidden" name="situacaocaixa" id="situacaocaixa"
                                                                       value="{evento.situacaocaixa}" readonly="readonly">
                                                                <div class="col-6">
                                                                    <label for="nomeevento" id="labelnomeevento">Nome Evento</label>
                                                                    <input type="text" class="form-control" maxlength="100" value="${evento.nomeevento}"
                                                                           id="nomeevento" name="nomeevento" placeholder="Digite o nome do evento">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="datainicioevento" id="labeldatainicioevento">Data Início</label>
                                                                    <input class="form-control" type="date" name="datainicioevento" id="datainicioevento" value="${evento.datainicioevento}"
                                                                           maxLength="8" />
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="dataterminoevento" id="labeldataterminoevento">Data Término</label>
                                                                    <input class="form-control" type="date" name="dataterminoevento" value="${evento.dataterminoevento}"
                                                                           id="dataterminoevento" maxLength="5" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <!-- Loop das marcas -->
                                                                <div class="col-sm">
                                                                    <label id="labelmarca" for="idcidade">Cidade</label>
                                                                    <select class="form-control" id="idcidade" name="idcidade">
                                                                        <option id="0" value="0">Selecione a cidade</option>
                                                                        {loop="$marcas"}
                                                                        <option id="${value.idcidade}" value="${value.idcidade}" 
                                                                                {if="$value.idcidade == $evento.idcidade"} selected {/if}>
                                                                            ${value.nomemarca}
                                                                        </option>
                                                                        {/loop}
                                                                    </select>
                                                                </div>
                                                                <!-- Loop dos grupos -->
                                                                <div class="col-sm">
                                                                    <label id="labelgrupo" for="idcurso">Curso</label>
                                                                    <select class="form-control" id="idcurso" name="idcurso">
                                                                        <option id="0" value="0">Selecione o curso</option>
                                                                        {loop="$grupos"}
                                                                        <option id="${value.idcurso}" value="${value.idcurso}" 
                                                                                {if="$value.idcurso == $evento.idcurso"} selected {/if}>
                                                                            ${value.nomegrupo}</option>
                                                                        {/loop}
                                                                    </select>
                                                                </div>
                                                                <!-- Loop dos subgrupos -->
                                                                <div class="col-sm">
                                                                    <label id="labelsubgrupo" for="idcategoria">Categoria</label>
                                                                    <select class="form-control" id="idcategoria" name="idcategoria">
                                                                        <option id="0" value="0">Selecione a categoria</option>
                                                                        {loop="$subgrupos"}
                                                                        <option id="${value.idcategoria}" value="${value.idcategoria}"
                                                                                {if="$value.idcategoria == $evento.idcategoria"} selected {/if}>${value.nomesubgrupo}</option>
                                                                        {/loop}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <div class="col-sm">
                                                                    <label for="nomeeventodetalhada" id="labelnomeeventodetalhada">Informações</label>
                                                                    <textarea class="form-control" id="nomeeventodetalhada" name="nomeeventodetalhada" rows="3"
                                                                              placeholder="Digite detalhes do evento"
                                                                              maxlength="500"></textarea>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="card-body">
                                                                <div class="form-group">
                                                                    <center>
                                                                        <img alt="imagem" clas="img-thumbnail" src=""
                                                                             name="target" id="target" width="170" height="200">
                                                                        <br></br>
                                                                        <input type="file" id="gallery-photo-add"
                                                                               class="inputfile" onchange="uploadFile()"/>
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
                                                            <button class="btn btn-success" id="salvarecontinuar" onclick="stepper.next()">Salvar e continuar <i
                                                                    class="fa fa-arrow-right"></i></button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--</form>-->
                                                <!-- Fim dos dados iniciais do produto -->
                                                <!-- Inicio código de barras -->
                                                <div id="organizadores-part" class="content" role="tabpanel" aria-labelledby="organizadores-part-trigger">
                                                    <div class="card-body">
                                                        <div class="form-group">
                                                            <div class="form-line row">
                                                                <div class="col-sm">

                                                                    <label for="nomeeventodetalhada" id="labelcodigobarraproduto">Organizadores</label>
                                                                    <div class="input-group input-group-mb-3">
                                                                        <select class="form-control" id="idorganizador" name="idorganizador">
                                                                            <option id="0" value="0">Selecione o Organizador</option>

                                                                            <option id="${value.idcategoria}" value="${value.idorganizador}"
                                                                                    selected {/if}>${value.nomeorganizador}</option>

                                                                        </select>
                                                                        <span class="input-group-append">
                                                                            <button type="button" onclick="adcDivOrganizador()"
                                                                                    class="btn btn-primary btn-flat" id="adicionarcodigobarraproduto">Adicionar</button>
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div id="espacoaddorganizador">

                                                            <!-- Loop dos códigos de barras já cadastrados-->

                                                            <div id="div_${value.idorganizadorevento}">
                                                                <div class="form-group"></div>
                                                                <div class="form-line row">
                                                                    <div class="col-sm">
                                                                        <div class="input-group input-group-mb-3">
                                                                            <input type="text" class="form-control" id="${value.idorganizadorevento}"
                                                                                   value="${value.nomeorganizador}" disabled />
                                                                            <span class="input-group-append">
                                                                                <button type="button" onclick="deletar(${value.idorganizadorevento})"
                                                                                        class="btn btn-danger btn-flat">Remover</button>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div> 
                                                        </div>
                                                        <div class="form-group"></div>
                                                        <hr>
                                                        <div align="right">
                                                            <button class="btn btn-primary" onclick="stepper.previous()"><i class="fa fa-arrow-left"></i> Voltar </button>
                                                            <button class="btn btn-success" onclick="stepper.next()"> Salvar e continuar <i class="fa fa-arrow-right"></i></button>
                                                        </div>
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
                                                                <input type="text" class="form-control" maxlength="100" value="${evento.nomeevento}"
                                                                       id="nomeatividade" name="nomeatividade" placeholder="Digite o nome da atividade">
                                                            </div>
                                                            <div class="col-sm">
                                                                <label for="datainicioevento" id="labeldatainicioevento">Data Início</label>
                                                                <input class="form-control" type="date" name="datainicioevento" id="datainicioevento" value="${evento.datainicioevento}"
                                                                       maxLength="8" />
                                                            </div>
                                                            <div class="col-sm">
                                                                <label for="dataterminoevento" id="labeldataterminoevento">Data Término</label>
                                                                <input class="form-control" type="date" name="dataterminoevento" value="${evento.dataterminoevento}"
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
                                                                <input type="text" class="form-control" maxlength="100" value="${evento.cargahoraria}"
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

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Evento</strong>";
        document.getElementById('menuevento').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });


    //ADCIONAR ORGANIZADOR#############################################################################################################
    function adcDivOrganizador(idorganizador, nomeOrganizador) {
        var html = '<div id="divOrg_123">'//alterar para o id do organizador
                + '<div class="form-group"></div><div class="form-line row">'
                + '<div class="col-sm">'
                + '<div class="input-group input-group-mb-3">'
                + '<input type="text" class="form-control" id="divOrg_123" value="Organizador" disabled/>'//alterar o id e value
                + '<span class="input-group-append">'
                + '<button type="button" onclick="deletarOrganizador(' + 123 + ')" class="btn btn-danger btn-flat">Remover</button>'//alterar o valor do deletar
                + '</span></div></div></div> '
                + '</div>';
        $("#espacoaddorganizador").append(html);
    }

    function deletarOrganizador(idorganizador) {
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

        removeLinhaOrganizadorHTML(idorganizador);
    }

    function removeLinhaOrganizadorHTML(idcodigobarraproduto) {
        var id = "divOrg_" + idcodigobarraproduto;
        // Removendo um nó a partir do pai
        var node = document.getElementById(id);
        if (node.parentNode) {
            node.parentNode.removeChild(node);
        }

    }

    //ADCIONAR ATIVIDADE EVENTO########################################################################################################
    function adcDivAtividadeEvento(idatividadeevento, nomeAtividadeEvento) {
        var html = '<div id="divAtv_123">'//alterar para o id da atividade evento
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