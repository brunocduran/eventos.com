<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <c:if test="${sessionScope.tipousuario == 'Administrador' or sessionScope.tipousuario == 'Organizador'}">
        <div class="content-header">
            <div class="container-fluid">

                <div class="row">
                    <div class="col-9">
                        <div class="row">
                            
                            <div class="col-4">
                                <div class="small-box bg-dark">
                                    <div class="inner">                  
                                        <h3>${sessionScope.qtdInstituicoes}</h3>                
                                        <p> <c:out value="${sessionScope.qtdInstituicoes <= 1 ? 'Instituição' : 'Instituições'}"/></p>
                                    </div>              
                                    <div class="icon" style="color: #D0D3D4;">
                                        <i class="fas fa-university"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/InstituicaoListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                                
                            <div class="col-4">
                                <div class="small-box bg-dark">
                                    <div class="inner">
                                        <h3>${sessionScope.qtdCursos}</h3>
                                        <p><c:out value="${sessionScope.qtdCursos <= 1 ? 'Curso' : 'Cursos'}"/></p>
                                    </div>
                                    <div class="icon" style="color: #D0D3D4;">
                                        <i class="fas fa-graduation-cap"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/CursoListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                                
                            <div class="col-4">
                                <div class="small-box bg-dark">
                                    <div class="inner">
                                        <h3>${sessionScope.qtdFornecedores}</h3>
                                        <p><c:out value="${sessionScope.qtdFornecedores <= 1 ? 'Fornecedor' : 'Fornecedores'}"/></p>
                                    </div>
                                    <div class="icon" style="color: #D0D3D4;">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/FornecedorListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                                
                        </div>
                        <div class="row">
                            
                            <div class="col-4">
                                <div class="small-box bg-dark">
                                    <div class="inner">
                                        <h3>${sessionScope.qtdParticipantes}</h3>
                                        <p><c:out value="${sessionScope.qtdParticipantes <= 1 ? 'Participante' : 'Participantes'}"/></p>
                                    </div>
                                    <div class="icon" style="color: #D0D3D4;">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/ParticipanteListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                                
                            <div class="col-4">
                                <div class="small-box bg-dark">
                                    <div class="inner">
                                        <h3>${sessionScope.qtdEventos}</h3>
                                        <p><c:out value="${sessionScope.qtdEventos <= 1 ? 'Evento em Andamento' : 'Eventos em Andamento'}"/></p>
                                    </div>
                                    <div class="icon" style="color: #D0D3D4;">
                                        <i class="far fa-calendar-alt"></i>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/EventoListar" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                                
                            <div class="col-4">
                                <div class="small-box bg-dark">
                                    <div class="inner">
                                        <h3>0</h3>
                                        <p>Inscrições</p>
                                    </div>
                                    <div class="icon" style="color: #D0D3D4;">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <a href="#" class="small-box-footer">Mais Informações <i class="fas fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                                
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="info-box mb-3 bg-danger">
                            <span class="info-box-icon"><i class="far fa-money-bill-alt"></i></i></i></span>

                            <div class="info-box-content">
                                <span class="info-box-text">Despesas</span>
                                <span class="info-box-number">${sessionScope.totalDespesa}</span>
                            </div>
                        </div>

                        <div class="info-box mb-3 bg-info">
                            <span class="info-box-icon"><i class="fas fa-hand-holding-usd"></i></span>

                            <div class="info-box-content">
                                <span class="info-box-text">Doações</span>
                                <span class="info-box-number">${sessionScope.totalDoacao}</span>
                            </div>
                        </div>

                        <div class="info-box mb-3 bg-success">
                            <span class="info-box-icon"><i class="fas fa-dollar-sign"></i></span>

                            <div class="info-box-content">
                                <span class="info-box-text">Recebimento</span>
                                <span class="info-box-number">-</span>
                            </div>
                        </div>
                    </div>     

                </div>


            </div>
        </div>  
    </c:if>
</div>




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