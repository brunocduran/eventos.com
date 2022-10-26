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


    <!-- Carousel Start -->
    <div class="container-fluid mb-3">
        <div class="row px-xl-5">
            <div class="col-lg-8">
                <div id="header-carousel" class="carousel slide carousel-fade mb-30 mb-lg-0" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#header-carousel" data-slide-to="0" class="active"></li>
                        <li data-target="#header-carousel" data-slide-to="1"></li>
                        <li data-target="#header-carousel" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item position-relative active" style="height: 430px;">
                            <img class="position-absolute w-100 h-100" src="${pageContext.request.contextPath}/home/img/carousel-2.jpg" style="object-fit: cover;">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown texto-banner">II Arraiá da FEF</h1>
                                    <p class="mx-md-5 px-5 animate__animated animate__bounceIn texto-banner">03 de Junho de 2022 às 19:00 no Salão de Eventos da Pastoral da Igreja Aparecida</p>
                                    <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="#">Inscreva-se</a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item position-relative" style="height: 430px;">
                            <img class="position-absolute w-100 h-100" src="${pageContext.request.contextPath}/home/img/carousel-1.jpg" style="object-fit: cover;">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown texto-banner">IV SEMANA INTEGRADA DE CURSOS</h1>
                                    <p class="mx-md-5 px-5 animate__animated animate__bounceIn texto-banner">10 de Abril de 2022 às 19:00 no Salão de Eventos da Pastoral da Igreja Aparecida</p>
                                    <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="#">Inscreva-se</a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item position-relative" style="height: 430px;">
                            <img class="position-absolute w-100 h-100" src="${pageContext.request.contextPath}/home/img/carousel-3.jpg" style="object-fit: cover;">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown texto-banner">X SEMANA ACADÊMICA USP</h1>
                                    <p class="mx-md-5 px-5 animate__animated animate__bounceIn texto-banner">De 10 a 16 de Agosto de 2022 - Campus USP São Paulo</p>
                                    <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="#">Inscreva-se</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="product-offer mb-30" style="height: 200px;">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/home/img/offer-1.jpg" alt="">
                    <div class="offer-text">
                        <h6 class="text-white text-uppercase texto-banner">UFSCAR</h6>
                        <h3 class="text-white mb-3 texto-banner">Semana da Biologiar</h3>
                        <a href="" class="btn btn-primary">Inscreva-se</a>
                    </div>
                </div>
                <div class="product-offer mb-30" style="height: 200px;">
                    <img class="img-fluid" src="${pageContext.request.contextPath}/home/img/offer-2.jpg" alt="">
                    <div class="offer-text">
                        <h6 class="text-white text-uppercase texto-banner">UNIBR</h6>
                        <h3 class="text-white mb-3 texto-banner">Semana Integrada</h3>
                        <a href="" class="btn btn-primary">Inscreva-se</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Carousel End -->

    <!-- Products Start -->
    <div class="container-fluid pt-5 pb-3">
        <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Escolha um Evento</span></h2>
        <div class="row px-xl-5">
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-1.jpg" alt="">
                        <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">II Arraiá FEF</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 03/06/2022 </small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-2.jpg" alt="">
                        <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">XV SEMANA ESTÉTICA</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 11/04/2022 à 13/04/2022 </small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-3.jpg" alt="">
                         <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">XV SEMANA QUIMÍCA</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 11/04/2022 à 13/04/2022 </small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-4.jpg" alt="">
                         <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">XV SEMANA FISIOTERAPIA</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 11/04/2022 à 13/04/2022 </small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-5.jpg" alt="">
                         <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">XV SEMANA SISTEMAS</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 14/10/2021 </small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-6.jpg" alt="">
                         <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">XV SEMANA BIOLOGIA</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 13/10/2021 à 15/10/2021 </small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-7.jpg" alt="">
                        <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">XV SEMANA SISTEMAS</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 14/10/2021 </small>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-lg-3 col-md-4 col-sm-6 pb-1">
                <div class="product-item bg-light mb-4">
                    <div class="product-img position-relative overflow-hidden">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/home/img/product-8.jpg" alt="">
                         <div class="product-action">
                            <a class="btn btn-outline-dark btn-square" href=""><i class="far fa-heart"></i></a>
                        </div>
                    </div>
                    <div class="text-center py-4">
                        <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                        <i class="fas fa-map-marker-alt"> </i> <span class="h6 text-decoration-none text-truncate"> Fernandópolis-SP</span>
                        <div class="d-flex align-items-center justify-content-center mt-2">

                            <a class="h4 text-decoration-none text-truncate" href="">IX SIG</a>
                        </div>
                        <div class="d-flex align-items-center justify-content-center mb-1">
                            <small class="border data-evento"> 13/10/2021 à 15/10/2021 </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Products End -->
    
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Instituições</span></h2>
    
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
    
<jsp:include page="/home/footer.jsp"/>