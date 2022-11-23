<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/home/header.jsp"/>
<jsp:include page="/home/navbar.jsp"/>
<div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
    <div class="navbar-nav mr-auto py-0">
        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link active">Home</a>                           
        <a href="${pageContext.request.contextPath}/ContatoNovo" class="nav-item nav-link">Contato</a>                          
    </div>
</div>
</div>
</nav>
</div>
</div>
</div>
<!-- Navbar End -->


<!-- Carousel Start -->
<div class="container-fluid mb-3">
    <div class="row px-xl-5">
        <div class="col-lg-8">
            <div id="header-carousel" class="carousel slide carousel-fade mb-30 mb-lg-0" data-ride="carousel">
                <ol class="carousel-indicators">
                    <!--<li data-target="#header-carousel" data-slide-to="0" class="active"></li>-->
                    <c:forEach var="i" begin="0" end="${sessionScope.qtdBanner - 1}">
                        <li data-target="#header-carousel" data-slide-to="${i}" class="${i == 0 ? 'active' : ''}"></li>      
                    </c:forEach>
                </ol>
                <div class="carousel-inner">
                    <c:forEach var="banner" items="${bannersCentrais}">                        
                    <div class="carousel-item position-relative <c:out value="${sessionScope.minID == banner.idConfiguracaoBanner ? 'active' : ''}"/>"  style="height: 430px;">
                        <img class="position-absolute w-100 h-100" src="${banner.imagem}" style="object-fit: cover;">
                        <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                            <div class="p-3" style="max-width: 700px;">
                                <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown texto-banner">${banner.tituloBanner}</h1>
                                <p class="mx-md-5 px-5 animate__animated animate__bounceIn texto-banner">
                                  ${banner.msgBanner}  
                                </p>
                                
                                <p class="mx-md-5 px-5 animate__animated animate__bounceIn texto-banner">
                                 <c:if test="${banner.evento.dataInicioEvento == banner.evento.dataTerminoEvento}">
                                    ${banner.evento.dataInicioEventoFormatada}
                                </c:if>
                                <c:if test="${banner.evento.dataInicioEvento != banner.evento.dataTerminoEvento}">
                                    ${banner.evento.dataInicioEventoFormatada} à ${banner.evento.dataTerminoEventoFormatada}
                                </c:if>     
                                    
                                </p>
                                <p class="mx-md-5 px-5 animate__animated animate__bounceIn texto-banner">
                                  ${banner.evento.cidade.nomeCidade} - ${banner.evento.cidade.estado.siglaEstado}  
                                </p>
                                <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="${pageContext.request.contextPath}/EventoCarregarHome?idEvento=${banner.evento.idEvento}">Inscreva-se</a>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                  
                    
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <c:forEach var="banner" items="${bannerSuperior}">
            <div class="product-offer mb-30" style="height: 200px;">
                <img class="img-fluid" src="${banner.imagem}" alt="">
                <div class="offer-text">
                    <h6 class="text-white text-uppercase texto-banner">${banner.evento.curso.instituicao.nomeInstituicao}</h6>
                    <h3 class="text-white mb-3 texto-banner">${banner.tituloBanner}</h3>
                    <a href="${pageContext.request.contextPath}/EventoCarregarHome?idEvento=${banner.evento.idEvento}" class="btn btn-primary">Inscreva-se</a>
                </div>
            </div>
            </c:forEach>
             <c:forEach var="banner" items="${bannerInferior}">
            <div class="product-offer mb-30" style="height: 200px;">
                <img class="img-fluid" src="${banner.imagem}" alt="">
                <div class="offer-text">
                    <h6 class="text-white text-uppercase texto-banner">${banner.evento.curso.instituicao.nomeInstituicao}</h6>
                    <h3 class="text-white mb-3 texto-banner">${banner.tituloBanner}</h3>
                    <a href="${pageContext.request.contextPath}/EventoCarregarHome?idEvento=${banner.evento.idEvento}" class="btn btn-primary">Inscreva-se</a>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Carousel End -->

<!-- Products Start -->
<div class="container-fluid pt-5 pb-3">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Escolha um Evento</span></h2>
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
<!-- Products End -->
<div class="container-fluid pt-5 pb-3">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Instituições</span></h2>
</div>

<!-- Vendor Start -->
<div class="container-fluid py-5">
    <div class="row px-xl-5">
        <div class="col">
            <div class="owl-carousel vendor-carousel">
                <c:forEach var="instituicao" items="${instituicoes}">
                    <div class="bg-light p-4">
                        <img src="${instituicao.imagem}" alt="${instituicao.nomeInstituicao}">
                    </div>                        
                </c:forEach>                    
            </div>
        </div>
    </div>
</div>
<!-- Vendor End -->

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