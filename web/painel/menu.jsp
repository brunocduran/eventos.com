<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <c:if test="${sessionScope.tipousuario == 'Administrador' or sessionScope.tipousuario == 'Organizador'}">   
                <div class="row">
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-info">
                            <div class="inner">                  
                                <h3>${sessionScope.qtdInstituicoes}</h3>                
                                <p> <c:out value="${sessionScope.qtdInstituicoes <= 1 ? 'Instituição' : 'Instituições'}"/></p>
                            </div>              
                            <div class="icon">
                                <i class="ion ion-home"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/InstituicaoListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-success">
                            <div class="inner">
                                <h3>${sessionScope.qtdCursos}</h3>
                                <p><c:out value="${sessionScope.qtdCursos <= 1 ? 'Curso' : 'Cursos'}"/></p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-university"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/CursoListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-warning">
                            <div class="inner">
                                <h3>${sessionScope.qtdParticipantes}</h3>
                                <p><c:out value="${sessionScope.qtdParticipantes <= 1 ? 'Participante' : 'Participantes'}"/></p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-person-add"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/ParticipanteListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-danger">
                            <div class="inner">
                                <h3>${sessionScope.qtdFornecedores}</h3>
                                <p><c:out value="${sessionScope.qtdFornecedores <= 1 ? 'Fornecedor' : 'Fornecedores'}"/></p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-bag"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/FornecedorListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                </div>
            </c:if>
        </div>
    </div>
    <div class="content-header">
        <div class="container-fluid">
            <div class="card shadow">
                <div class="card-body">
                     <div id='calendar'></div>
                    
                  

                </div> </div> </div>

    </div>
</div>


<script>

    function generateColor() {
        const letters = '0123456789ABCDEF';
        let color = '#';

        for (let i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }

    $(document).ready(function () {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            defaultDate: Date(),
            navLinks: true, // can click day/week names to navigate views
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: [
    <c:forEach var="evento" items="${eventos}">
                {id: '${evento.idEvento}',
                    title: '${evento.nomeEvento}',
                    start: '${evento.dataInicioEvento}',
                    end: '${evento.dataTerminoEventoCalendario}',
                    color: generateColor()
                },
    </c:forEach>
            ]
        });
    });
</script>

<style type="text/css">
    #calendar{
        width: 700px;
        margin: 0 20px 20px 0;
    }

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