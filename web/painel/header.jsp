<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="pt-br">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>EVENTOS.COM</title>

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/painel/css/all.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/painel/css/adminlte.min.css">

        <!-- JQuery -->
        <script src="${pageContext.request.contextPath}/painel/js/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/painel/js/jquery.mask.min.js"></script>
        <script src="${pageContext.request.contextPath}/painel/js/jquery.maskMoney.min.js"></script>

        <!-- Ionicons -->
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

        <script src="${pageContext.request.contextPath}/painel/plugins/bs-stepper/js/bs-stepper.min.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/painel/plugins/bs-stepper/css/bs-stepper.min.css">


        <!-- Datatable -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/painel/css/jquery.dataTables.min.css"/>
        <script src="${pageContext.request.contextPath}/painel/js/jquery.dataTables.min.js" type="text/javascript"></script>

        <!-- Importação da minha biblioteca de javascrip-->
        <script charset="utf-8" src="${pageContext.request.contextPath}/painel/js/validacoes.js" type="text/javascript"></script>

        <!-- Mensagem alerta -->
        <script src="${pageContext.request.contextPath}/painel/js/sweetalert2.all.min.js" type="text/javascript"></script>
    </head>

    <body class="hold-transition sidebar-mini">
        <div class="wrapper">
            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <!-- navbar superior -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                    </li>
                    <li class="nav-item d-none d-sm-inline-block">
                        <a class="nav-link active" id="titulopainel"></a>
                    </li>
                </ul>

                <!-- navbar superior direito -->
                <ul class="navbar-nav ml-auto">

                    <!-- usuario Menu -->
                    <li class="nav-item dropdown">
                        <a class="nav-link" data-toggle="dropdown" href="#">
                            <i class="fas fa-user-circle"></i>
                            <span class="hidden-xs">${sessionScope.nomeusuario} - ${sessionScope.tipousuario}</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                            <div class="dropdown-divider"></div>

                            <c:if test="${sessionScope.tipousuario == 'Administrador'}">
                                <a href="${pageContext.request.contextPath}/AdministradorLogadoCarregar?idAdministrador=${sessionScope.idusuario}" class="dropdown-item">
                                    <i class="fas fa-user"></i> Meu Perfil
                                </a>
                            </c:if>

                            <c:if test="${sessionScope.tipousuario == 'Organizador'}">
                                <a href="${pageContext.request.contextPath}/OrganizadorLogadoCarregar?idOrganizador=${sessionScope.idusuario}" class="dropdown-item">
                                    <i class="fas fa-user"></i> Meu Perfil
                                </a>
                            </c:if>

                            <c:if test="${sessionScope.tipousuario == 'Participante'}">
                                <a href="${pageContext.request.contextPath}/ParticipanteLogadoCarregar?idParticipante=${sessionScope.idusuario}" class="dropdown-item">
                                    <i class="fas fa-user"></i> Meu Perfil
                                </a>
                            </c:if>   

                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/Home" class="dropdown-item">
                                <i class="fas fa-home"></i> Home
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/UsuarioDeslogar" class="dropdown-item">
                                <i class="fas fa-power-off"></i>
                                <i class="bi bi-geo-alt"></i> Logout
                            </a>
                        </div>
                    </li>
                </ul>

            </nav>

            <!-- Menu lateral -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <!-- Topo Logo -->
                <a href="${pageContext.request.contextPath}/Painel" class="brand-link">
                    <img src="${pageContext.request.contextPath}/painel/img/logo.png" class="brand-image img-circle elevation-3"
                         style="opacity: .8">
                    <span class="brand-text font-weight-light">EVENTOS.COM</span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">

                    <!-- Menu com os paineis -->
                    <nav class="mt-2">
                        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <li class="nav-header">MENU</li>
                                <c:if test="${sessionScope.tipousuario == 'Administrador' or sessionScope.tipousuario == 'Organizador'}">
                                <li class="nav-item" id="agrupamentocadastrosgerais">
                                    <a href="#" class="nav-link" id="menucadastrosgerais">
                                        <i class="nav-icon far fa-circle"></i>
                                        <p>
                                            Cadastros Gerais
                                            <i class="fas fa-angle-left right"></i>
                                        </p>
                                    </a>
                                    <ul class="nav nav-treeview">

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/EstadoListar" class="nav-link" id="menuestado">
                                                <i class="nav-icon fas fa-map-marked-alt"></i>
                                                <p>
                                                    Estado
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/CidadeListar" class="nav-link" id="menucidade">
                                                <i class="nav-icon fas fa-map-marker-alt"></i>
                                                <p>
                                                    Cidade
                                                </p>
                                            </a>
                                        </li>                                    

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/InstituicaoListar" class="nav-link" id="menuinstituicao">
                                                <i class="nav-icon fas fa-university"></i>
                                                <p>
                                                    Instituição
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/CursoListar" class="nav-link" id="menucurso">
                                                <i class="nav-icon fas fa-graduation-cap"></i>
                                                <p>
                                                    Curso
                                                </p>
                                            </a>
                                        </li>

                                        <c:if test="${sessionScope.tipousuario == 'Administrador'}">
                                            <li class="nav-item" >
                                                <a href="${pageContext.request.contextPath}/AdministradorListar" class="nav-link" id="menuadministrador">
                                                    <i class="nav-icon fas fa-user-tie"></i>
                                                    <p>
                                                        Administrador
                                                    </p>
                                                </a>
                                            </li>
                                        </c:if>

                                        <li class="nav-item" >
                                            <a href="${pageContext.request.contextPath}/OrganizadorListar" class="nav-link" id="menuorganizador">
                                                <i class="nav-icon fas fa-user"></i>
                                                <p>
                                                    Organizador
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item" >
                                            <a href="${pageContext.request.contextPath}/ParticipanteListar" class="nav-link" id="menuparticipante">
                                                <i class="nav-icon fas fa-user"></i>
                                                <p>
                                                    Participante
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item" >
                                            <a href="${pageContext.request.contextPath}/PatrocinadorListar" class="nav-link" id="menupatrocinador">
                                                <i class="nav-icon fas fa-user"></i>
                                                <p>
                                                    Patrocinador
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item" >
                                            <a href="${pageContext.request.contextPath}/FornecedorListar" class="nav-link" id="menufornecedor">
                                                <i class="nav-icon fas fa-user"></i>
                                                <p>
                                                    Fornecedor
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/TipoTrabalhoListar" class="nav-link" id="menutipotrabalho">
                                                <i class="nav-icon fas fa-cube"></i>
                                                <p>
                                                    Tipo de Trabalho
                                                </p>
                                            </a>
                                        </li>

                                    </ul>
                                </li>
                            </c:if> 

                            <c:if test="${sessionScope.tipousuario == 'Administrador' or sessionScope.tipousuario == 'Organizador'}">
                                <li class="nav-item" id="agrupamentoevento">
                                    <a href="#" class="nav-link" id="menueventoagrupamento">
                                        <i class="nav-icon far fa-circle"></i>
                                        <p>
                                            Evento
                                            <i class="fas fa-angle-left right"></i>
                                        </p>
                                    </a>
                                    <ul class="nav nav-treeview">

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/TipoAtividadeListar" class="nav-link" id="menutipoatividade">
                                                <i class="nav-icon fas fa-toolbox"></i>
                                                <p>
                                                    Tipo de Atividade
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/FuncaoListar" class="nav-link" id="menufuncao">
                                                <i class="nav-icon fas fa-cube"></i>
                                                <p>
                                                    Função do Organizador
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/CategoriaEventoListar" class="nav-link" id="menucategoriaevento">
                                                <i class="nav-icon fas fa-cube"></i>
                                                <p>
                                                    Categoria do Evento
                                                </p>
                                            </a>
                                        </li>

                                        <li class="nav-item">
                                            <a href="${pageContext.request.contextPath}/EventoListar" class="nav-link" id="menuevento">
                                                <i class="nav-icon far fa-calendar-alt"></i>
                                                <p>
                                                    Evento
                                                </p>
                                            </a>
                                        </li>

                                        <c:if test="${sessionScope.tipousuario == 'Administrador'}">
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/ConfiguracaoBannerListar" class="nav-link" id="menuconfiguracaobanner">
                                                    <i class="nav-icon fas fa-image"></i>
                                                    <p>
                                                        Configuração Banner
                                                    </p>
                                                </a>
                                            </li>
                                            
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/DoacaoListar" class="nav-link" id="menudoacao">
                                                    <i class="nav-icon fas fa-hand-holding-usd"></i>
                                                    <p>
                                                        Doação
                                                    </p>
                                                </a>
                                            </li>
                                            
                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/DespesaListar" class="nav-link" id="menudespesa">
                                                    <i class="nav-icon fas fa-money-check-alt"></i>
                                                    <p>
                                                        Despesa
                                                    </p>
                                                </a>
                                            </li>

                                            <li class="nav-item">
                                                <a href="${pageContext.request.contextPath}/CalendarioEvento" class="nav-link" id="menuconfiguracaobanner">
                                                    <i class="nav-icon fas fa-calendar-alt"></i>
                                                    <p>
                                                        Calendário de Eventos
                                                    </p>
                                                </a>
                                            </li>
                                        </c:if>

                                    </ul>
                                </li>
                            </c:if>

                            <c:if test="${sessionScope.tipousuario == 'Participante'}">
                                <li class="nav-item">
                                    <a href="${pageContext.request.contextPath}/EventoListarParticipante" class="nav-link" id="menuevento">
                                        <i class="nav-icon far fa-calendar-alt"></i>
                                        <p>
                                            Eventos
                                        </p>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </aside>