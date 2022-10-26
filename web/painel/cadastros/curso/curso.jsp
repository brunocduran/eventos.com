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
                                <th align="center">ID</th>
                                <th align="center">Nome</th>
                                <th align="center">Instituicao</th>
                                <th align="center"></th>
                                <th align="center"></th>                                 
                            </tr> 
                        </thead>
                        <tbody>
                            <c:forEach var="curso" items="${cursos}">
                                <tr>
                                    <td align="right">${curso.idCurso}</td>
                                    <td align="left">${curso.nomeCurso}</td>
                                    <td align="left">${curso.instituicao.nomeInstituicao}</td>
                                    <td align="center">
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal" data-id="" 
                                           onclick="setDadosModal(${curso.idCurso})">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>
                                    <td align="center">
                                        <a href="#" onclick="deletar(${curso.idCurso}, '${curso.situacao}')">
                                            <button class="btn 
                                                    <c:out value="${curso.situacao == 'A' ? 'btn-danger' : 'btn-success'}"/>">
                                                <i class="fas fa-fw
                                                   <c:out value="${curso.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                <strong>
                                                    <c:out value="${curso.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>                                               
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
                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idCurso" id="idCurso" value="" readonly="readonly"/>   
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>   
                            </div>
                            <div class="form-group">
                                <label>Nome do Curso:</label>
                                <input class="form-control" type="text" name="nomeCurso" id="nomeCurso" value=""/>
                            </div>                        
                            <div class="form-group">
                                <label>Instituição:</label>
                                <select class="form-control" name="idInstituicao" id="idInstituicao" required>
                                    <option value ="nulo">Selecione</option>  
                                    <c:forEach var="instituicao" items="${instituicoes}">
                                        <option value="${instituicao.idInstituicao}"
                                                ${curso.instituicao.idInstituicao == instituicao.idInstituicao ? "selected" : ""}>
                                            ${instituicao.nomeInstituicao}
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




    var cidade = ''; // variavel para controle do carregametno de cidade      
    function limparDadosModal() {
        console.log('ENTROU NA FUNCAO LIMPARDADOSMODAL');
        $('#idCurso').val("0");
        $('#nomeCurso').val("");
        $('#idInstituicao').val("");
    }

    function setDadosModal(valor) {
        console.log('ENTROU NA FUNCAO SET DADOS MODAL');
        limparDadosModal();
        document.getElementById('idCurso').value = valor;
        var idCurso = valor;
        if (idCurso != "0") {
            //existe administrador pra buscar (alteracao)
            $.getJSON('CursoCarregar', {idCurso: idCurso}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idCurso;
                if (id != "0") {
                    $('#idCurso').val(respostaServlet.idCurso);
                    $('#nomeCurso').val(respostaServlet.nomeCurso);
                    $('#idInstituicao').val(respostaServlet.instituicao.idInstituicao);
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
            titulo = "Você deseja realmente ativar o curso?";
            confirmButtonText = "Sim, ative o curso!";
            tituloConfirmacao = "Curso ativado com sucesso!";
        } else {
            titulo = "Você deseja realmente inativar o curso?";
            confirmButtonText = "Sim, inative o curso!";
            tituloConfirmacao = "Curso inativado com sucesso!";
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
                    url: '${pageContext.request.contextPath}/CursoExcluir',
                    data: {
                        idCurso: id
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
                                        window.location.href = "${pageContext.request.contextPath}/CursoListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível ativar/inativar o curso!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/CursoListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/CursoListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log('Entrei na validação de campos:');
        if (document.getElementById("nomeCurso").value == "") {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome do Curso!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#nomeCurso").focus();
        } else {
            gravarDados();
        }
    }

    function gravarDados() {
        console.log("Gravando dados....");
        $.ajax({
            type: 'post',
            url: 'CursoCadastrar',
            data: {
                idCurso: $('#idCurso').val(),
                nomeCurso: $('#nomeCurso').val(),
                idInstituicao: $('#idInstituicao').val(),
                situacao: $('#situacao').val()
            },
            success:
                    function (data) {
                        console.log("resposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                title: 'Curso gravado com sucesso!',
                                icon: "success",
                                confirmButtonColor: '#3085d6',
                                showConfirmButton: 'OK'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = "${pageContext.request.contextPath}/CursoListar";
                                }
                            });
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o curso!',
                                showConfirmButton: false,
                                timer: 1000
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/CursoListar";
                    }
        });
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Curso</strong>";
        document.getElementById('menucurso').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>