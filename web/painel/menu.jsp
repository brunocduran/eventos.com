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
            <div class="row">
                <div class="col-8">
                    <div class="card bg-gradient-success" style="position: relative; left: 0px; top: 0px;">
                        <div class="card-header border-0 ui-sortable-handle" style="cursor: move;">

                            <h3 class="card-title">
                                <i class="far fa-calendar-alt"></i>
                                Calendário
                            </h3>
                            <!-- tools card -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-success btn-sm" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <button type="button" class="btn btn-success btn-sm" data-card-widget="remove">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <!-- /. tools -->
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body pt-0" style="display: block;">
                            <!--The calendar -->
                            <div id="calendar" style="width: 100%"><div class="bootstrap-datetimepicker-widget usetwentyfour"><ul class="list-unstyled"><li class="show"><div class="datepicker"><div class="datepicker-days" style=""><table class="table table-sm"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Month"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5" title="Select Month">November 2022</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Month"></span></th></tr><tr><th class="dow">Su</th><th class="dow">Mo</th><th class="dow">Tu</th><th class="dow">We</th><th class="dow">Th</th><th class="dow">Fr</th><th class="dow">Sa</th></tr></thead><tbody><tr><td data-action="selectDay" data-day="10/30/2022" class="day old weekend">30</td><td data-action="selectDay" data-day="10/31/2022" class="day old">31</td><td data-action="selectDay" data-day="11/01/2022" class="day">1</td><td data-action="selectDay" data-day="11/02/2022" class="day">2</td><td data-action="selectDay" data-day="11/03/2022" class="day">3</td><td data-action="selectDay" data-day="11/04/2022" class="day">4</td><td data-action="selectDay" data-day="11/05/2022" class="day weekend">5</td></tr><tr><td data-action="selectDay" data-day="11/06/2022" class="day weekend">6</td><td data-action="selectDay" data-day="11/07/2022" class="day">7</td><td data-action="selectDay" data-day="11/08/2022" class="day">8</td><td data-action="selectDay" data-day="11/09/2022" class="day">9</td><td data-action="selectDay" data-day="11/10/2022" class="day">10</td><td data-action="selectDay" data-day="11/11/2022" class="day">11</td><td data-action="selectDay" data-day="11/12/2022" class="day weekend">12</td></tr><tr><td data-action="selectDay" data-day="11/13/2022" class="day weekend">13</td><td data-action="selectDay" data-day="11/14/2022" class="day">14</td><td data-action="selectDay" data-day="11/15/2022" class="day">15</td><td data-action="selectDay" data-day="11/16/2022" class="day">16</td><td data-action="selectDay" data-day="11/17/2022" class="day">17</td><td data-action="selectDay" data-day="11/18/2022" class="day">18</td><td data-action="selectDay" data-day="11/19/2022" class="day weekend">19</td></tr><tr><td data-action="selectDay" data-day="11/20/2022" class="day weekend">20</td><td data-action="selectDay" data-day="11/21/2022" class="day">21</td><td data-action="selectDay" data-day="11/22/2022" class="day">22</td><td data-action="selectDay" data-day="11/23/2022" class="day active today">23</td><td data-action="selectDay" data-day="11/24/2022" class="day">24</td><td data-action="selectDay" data-day="11/25/2022" class="day">25</td><td data-action="selectDay" data-day="11/26/2022" class="day weekend">26</td></tr><tr><td data-action="selectDay" data-day="11/27/2022" class="day weekend">27</td><td data-action="selectDay" data-day="11/28/2022" class="day">28</td><td data-action="selectDay" data-day="11/29/2022" class="day">29</td><td data-action="selectDay" data-day="11/30/2022" class="day">30</td><td data-action="selectDay" data-day="12/01/2022" class="day new">1</td><td data-action="selectDay" data-day="12/02/2022" class="day new">2</td><td data-action="selectDay" data-day="12/03/2022" class="day new weekend">3</td></tr><tr><td data-action="selectDay" data-day="12/04/2022" class="day new weekend">4</td><td data-action="selectDay" data-day="12/05/2022" class="day new">5</td><td data-action="selectDay" data-day="12/06/2022" class="day new">6</td><td data-action="selectDay" data-day="12/07/2022" class="day new">7</td><td data-action="selectDay" data-day="12/08/2022" class="day new">8</td><td data-action="selectDay" data-day="12/09/2022" class="day new">9</td><td data-action="selectDay" data-day="12/10/2022" class="day new weekend">10</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Year"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5" title="Select Year">2022</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Year"></span></th></tr></thead><tbody><tr><td colspan="7"><span data-action="selectMonth" class="month">Jan</span><span data-action="selectMonth" class="month">Feb</span><span data-action="selectMonth" class="month">Mar</span><span data-action="selectMonth" class="month">Apr</span><span data-action="selectMonth" class="month">May</span><span data-action="selectMonth" class="month">Jun</span><span data-action="selectMonth" class="month">Jul</span><span data-action="selectMonth" class="month">Aug</span><span data-action="selectMonth" class="month">Sep</span><span data-action="selectMonth" class="month">Oct</span><span data-action="selectMonth" class="month active">Nov</span><span data-action="selectMonth" class="month">Dec</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Decade"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5" title="Select Decade">2020-2029</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Decade"></span></th></tr></thead><tbody><tr><td colspan="7"><span data-action="selectYear" class="year old">2019</span><span data-action="selectYear" class="year">2020</span><span data-action="selectYear" class="year">2021</span><span data-action="selectYear" class="year active">2022</span><span data-action="selectYear" class="year">2023</span><span data-action="selectYear" class="year">2024</span><span data-action="selectYear" class="year">2025</span><span data-action="selectYear" class="year">2026</span><span data-action="selectYear" class="year">2027</span><span data-action="selectYear" class="year">2028</span><span data-action="selectYear" class="year">2029</span><span data-action="selectYear" class="year old">2030</span></td></tr></tbody></table></div><div class="datepicker-decades" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev" data-action="previous"><span class="fa fa-chevron-left" title="Previous Century"></span></th><th class="picker-switch" data-action="pickerSwitch" colspan="5">2000-2090</th><th class="next" data-action="next"><span class="fa fa-chevron-right" title="Next Century"></span></th></tr></thead><tbody><tr><td colspan="7"><span data-action="selectDecade" class="decade old" data-selection="2006">1990</span><span data-action="selectDecade" class="decade" data-selection="2006">2000</span><span data-action="selectDecade" class="decade" data-selection="2016">2010</span><span data-action="selectDecade" class="decade active" data-selection="2026">2020</span><span data-action="selectDecade" class="decade" data-selection="2036">2030</span><span data-action="selectDecade" class="decade" data-selection="2046">2040</span><span data-action="selectDecade" class="decade" data-selection="2056">2050</span><span data-action="selectDecade" class="decade" data-selection="2066">2060</span><span data-action="selectDecade" class="decade" data-selection="2076">2070</span><span data-action="selectDecade" class="decade" data-selection="2086">2080</span><span data-action="selectDecade" class="decade" data-selection="2096">2090</span><span data-action="selectDecade" class="decade old" data-selection="2106">2100</span></td></tr></tbody></table></div></div></li><li class="picker-switch accordion-toggle"></li></ul></div></div>
                        </div>
                        <!-- /.card-body -->
                    </div>
                </div>

                <div class="col-4">
                    <div class="info-box mb-3 bg-info">
                        <span class="info-box-icon"><i class="far fa-money-bill-alt"></i></i></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">Despesas</span>
                            <span class="info-box-number">163,921</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>

                    <div class="info-box mb-3 bg-success">
                        <span class="info-box-icon"><i class="fas fa-hand-holding-usd"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">Doações</span>
                            <span class="info-box-number">92,050</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>

                    <div class="info-box mb-3 bg-warning">
                        <span class="info-box-icon"><i class="fas fa-users"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">Inscrições</span>
                            <span class="info-box-number">0</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>

                    <div class="info-box mb-3 bg-danger">
                        <span class="info-box-icon"><i class="fas fa-dollar-sign"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">Recebimento</span>
                            <span class="info-box-number">0,0</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                </div>
            </div>
        </div>
    </div>

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