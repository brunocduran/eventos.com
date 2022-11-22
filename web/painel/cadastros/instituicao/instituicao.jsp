<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/painel/header.jsp" />

<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <!-- Page  heading -->
            <p class="mb-4"> Planilha de Registros </p>
            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-id="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <table id="datatable" class="display">
                        <thead>
                            <tr>
                                <th align="left">ID</th>
                                <th align="left">Nome</th>
                                <th align="center">CNPJ</th>
                                <th align="right"></th>
                                <th align="center"></th>                                 
                            </tr> 
                        </thead>
                        <tbody>
                            <c:forEach var="instituicao" items="${instituicoes}">
                                <tr>
                                    <td align="right">${instituicao.idInstituicao}</td>
                                    <td align="left">${instituicao.nomeInstituicao}</td>
                                    <td align="left">${instituicao.cnpj}</td>
                                    <td align="center">
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal" data-id="" 
                                           onclick="setDadosModal(${instituicao.idInstituicao})">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>
                                    <td align="center">
                                        <a href="#" onclick="deletar(${instituicao.idInstituicao}, '${instituicao.situacao}')">
                                            <button class="btn 
                                                    <c:out value="${instituicao.situacao == 'A' ? 'btn-danger' : 'btn-success'}"/>">
                                                <i class="fas fa-fw
                                                   <c:out value="${instituicao.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                <strong>
                                                    <c:out value="${instituicao.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>                                               
                                                </strong>
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
                            <div class="col">
                                <div class="card shadow mb-4">
                                    <div class="card-body">
                                        <div class="form-group">
                                            <center>
                                                <img alt="imagem" clas="img-thumbnail" src=""
                                                     name="target" id="target" width="170" height="200">
                                                <br></br>
                                                <input type="file" id="gallery-photo-add"
                                                       class="inputfile" onchange="uploadFile()"/>
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
                                <input class="form-control" type="hidden" name="idInstituicao" id="idInstituicao" value="" readonly="readonly"/>   
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>   
                            </div>
                            <div class="form-group">
                                <label> Nome da Instituição </label>
                                <input class="form-control" type="text" name="nomeInstituicao" id="nomeInstituicao" value=""/>
                            </div>                        
                            <div class="form-group">
                                <label> CNPJ:  </label>
                                <input class="form-control" type="text" name="cnpj" id="cnpj" onblur="preencheMascaraCNPJ()"
                                       value="" size="18" maxlength="14"/>
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
        console.log('entrei ready do js local');

        $('#datatable').DataTable({
            "oLanguage": {
                "sProcessing": "Processando...",
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "Nenhum registro encontrado",
                "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando de 0 até 0 de 0 registros",
                "sInfoFiltered": "",
                "sInfoPostFix": "",
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

    function preencheMascaraCNPJ() {
        console.log('teste');
        valorDigitado = document.getElementById('cnpj').value;
        valorDigitado = valorDigitado.replace(/\D/g, "")
        v = valorDigitado;
        v = v.replace(/\D/g, "");                           //Remove tudo o que não é dígito
        v = v.replace(/^(\d{2})(\d)/, "$1.$2");             //Coloca ponto entre o segundo e o terceiro dígitos
        v = v.replace(/^(\d{2})\.(\d{3})(\d)/, "$1.$2.$3"); //Coloca ponto entre o quinto e o sexto dígitos
        v = v.replace(/\.(\d{3})(\d)/, ".$1/$2");           //Coloca uma barra entre o oitavo e o nono dígitos
        v = v.replace(/(\d{4})(\d)/, "$1-$2");              //Coloca um hífen depois do bloco de quatro dígitos
        document.getElementById('cnpj').value = v;
    }


    var cidade = ''; // variavel para controle do carregametno de cidade      
    function limparDadosModal() {
        console.log('ENTROU NA FUNCAO LIMPARDADOSMODAL');
        $('#idInstituicao').val("0");
        $('#nomeInstituicao').val("");
        $('#cnpj').val("");
        $('#target').val("");
    }

    function setDadosModal(valor) {
        console.log('ENTROU NA FUNCAO SET DADOS MODAL');
        limparDadosModal();
        document.getElementById('idInstituicao').value = valor;
        var idInstituicao = valor;
        if (idInstituicao != "0") {
            //existe administrador pra buscar (alteracao)
            $.getJSON('InstituicaoCarregar', {idInstituicao: idInstituicao}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idInstituicao;
                if (id != "0") {
                    $('#idInstituicao').val(respostaServlet.idInstituicao);
                    $('#nomeInstituicao').val(respostaServlet.nomeInstituicao);
                    $('#cnpj').val(respostaServlet.cnpj);
                    $('#situacao').val(respostaServlet.situacao);
                    document.getElementById("target").src = respostaServlet.imagem;
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
            titulo = "Você deseja realmente ativar a instituição?";
            confirmButtonText = "Sim, ative a instituição!";
            tituloConfirmacao = "Instituição ativada com sucesso!";
        } else {
            titulo = "Você deseja realmente inativar a instituição?";
            confirmButtonText = "Sim, inative a instituição!";
            tituloConfirmacao = "Instituição inativada com sucesso!";
        }


        Swal.fire({
            title: 'Você tem certeza ?',
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
                    url: '${pageContext.request.contextPath}/InstituicaoExcluir',
                    data: {
                        idInstituicao: id
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
                                        window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível ativar/inativar instituição!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log('Entrei na validação de campos:');
        if (document.getElementById("nomeInstituicao").value == "") {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome da Instituição!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#descricao").focus();
        } else if (document.getElementById("cnpj").value == "") {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o CNPJ da Instituição!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#datadocumento").focus();
        } else {
            gravarDados();
        }
    }




    function gravarDados() {
        console.log("Gravando dados....");
        var target = document.getElementById("target").src;
        $.ajax({
            type: 'post',
            url: 'InstituicaoCadastrar',
            data: {
                idInstituicao: $('#idInstituicao').val(),
                nomeInstituicao: $('#nomeInstituicao').val(),
                cnpj: $('#cnpj').val(),
                situacao: $('#situacao').val(),
                imagem: target
            },
            success:
                    function (data) {
                        console.log("resposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                title: 'Instituição gravada com sucesso!',
                                icon: "success",
                                confirmButtonColor: '#3085d6',
                                showConfirmButton: 'OK'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
                                }
                            });
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar a Instituição!',
                                showConfirmButton: false,
                                timer: 1000
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/InstituicaoListar";
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

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Instituição</strong>";
        document.getElementById('agrupamentocadastrosgerais').classList.add("menu-open");
        document.getElementById('menucadastrosgerais').classList.add("active");
        document.getElementById('menuinstituicao').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>