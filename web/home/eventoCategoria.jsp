<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/home/header.jsp"/>
<jsp:include page="/home/navbar.jsp"/>
<div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
    <div class="navbar-nav mr-auto py-0">
        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link active">Home</a>                           
        <a href="${pageContext.request.contextPath}/home/contact.jsp" class="nav-item nav-link">Contato</a>                          
    </div>
</div>
</div>
</nav>
</div>
</div>
</div>
<!-- Navbar End -->


<!-- Products Start -->
<div class="container-fluid pt-5 pb-3">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Nome</span></h2>
    <div class="row px-xl-5">
        <c:forEach var="evento" items="${eventos}">
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${evento.imagem}" alt="">
                        <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href="${pageContext.request.contextPath}/EventoCarregarHome?idEvento=${evento.idEvento}"><i class="fa fa-search"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate">${evento.cidade.nomeCidade} - ${evento.cidade.estado.siglaEstado}</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="${pageContext.request.contextPath}/EventoCarregarHome?idEvento=${evento.idEvento}">${evento.nomeEvento}</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento">
                                <c:if test="${evento.dataInicioEvento == evento.dataTerminoEvento}">
                                    ${evento.dataInicioEventoFormatada}
                                </c:if>
                                <c:if test="${evento.dataInicioEvento != evento.dataTerminoEvento}">
                                    ${evento.dataInicioEventoFormatada} à ${evento.dataTerminoEventoFormatada}
                                </c:if>  
                            </small>
                        </div>
                    </div>
                </div>
            </div>                       
        </c:forEach>  

    </div>
</div>

<script>
    function converterData(data){
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    if (data == null || data.trim().equals("")){
    return null;
    } else{
    Date date = fmt.parse(data);
    return date; }
    }
</script>

<jsp:include page="/home/footer.jsp"/>