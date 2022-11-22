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
            <a href="${pageContext.request.contextPath}/EventoNovo" class="btn btn-success mb-4 adicionar">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>

            <div class="card shadow">
                <div class="card-body">
                    <table id="datatable" class="display">
                        <thead>
                            <tr>
                                <th align="center">ID</th>
                                <th align="center">Nome Evento</th>
                                <th align="left">Data Início</th>
                                <th align="left">Data Término</th>
                                <th align="left">Status</th>
                                <th align="center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="evento" items="${eventos}">
                                <tr>
                                    <td align="right">${evento.idEvento}</td>
                                    <td align="left">${evento.nomeEvento}</td>
                                    <td align="left"><fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataInicioEvento}"/></td>
                                    <td align="left"><fmt:formatDate pattern="dd/MM/yyyy" value="${evento.dataTerminoEvento}"/></td>
                                    <td align="left">
                                        <c:if test="${evento.situacaoEvento == 'A'}">
                                            Ativo
                                        </c:if>

                                        <c:if test="${evento.situacaoEvento == 'I'}">
                                            Inativo
                                        </c:if>

                                        <c:if test="${evento.situacaoEvento == 'E'}">
                                            Encerrado
                                        </c:if>

                                        <c:if test="${evento.situacaoEvento == 'F'}">
                                            Finalizado
                                        </c:if> 
                                    </td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/EventoGerenciar?idEvento=${evento.idEvento}" class="btn btn-group-lg btn-primary">
                                            <i class="fas fa-cog"></i><Strong> Gerenciar </Strong> </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
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

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Evento</strong>";
        document.getElementById('agrupamentoevento').classList.add("menu-open");
        document.getElementById('menueventoagrupamento').classList.add("active");
        document.getElementById('menuevento').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>