<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/home/header.jsp"/>
<jsp:include page="/home/navbar.jsp"/>

<div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
    <div class="navbar-nav mr-auto py-0">
        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link">Home</a>

        <a href="${pageContext.request.contextPath}/home/contact.jsp" class="nav-item nav-link active">Contato</a>
    </div>

</div>
</div>
</nav>
</div>
</div>
</div>
<!-- Navbar End -->
<div class="container-fluid">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Contate-nos</span></h2>
    <div class="row px-xl-5">
        <div class="col-lg-7 mb-5">
            <div class="bg-light p-30">
                <div id="success"></div>

                <div class="control-group">
                    <input type="text" class="form-control" name="nome" id="nome" placeholder="Seu Nome"
                           required="required" data-validation-required-message="Por favor, insira seu nome" />
                    <p class="help-block text-danger"></p>
                </div>
                <div class="control-group">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Seu E-mail"
                           required="required" data-validation-required-message="Por favor, informe seu e-mail" />
                    <p class="help-block text-danger"></p>
                </div>
                <div class="control-group">
                    <input type="text" class="form-control" id="assunto" name="assunto" placeholder="Assunto"
                           required="required" data-validation-required-message="Assunto" />
                    <p class="help-block text-danger"></p>
                </div>
                <div class="control-group">
                    <textarea class="form-control" rows="9" id="mensagem" name="mensagem" placeholder="Mensagem"
                              required="required"
                              data-validation-required-message="Escreva sua mensagem..."></textarea>
                    <p class="help-block text-danger"></p>
                </div>
                <div>
                    <button class="btn btn-primary py-2 px-4" type="submit" id="sendMessageButton" onclick="validarCampos()">Enviar Mensagem</button>
                </div>

            </div>
        </div>
        <div class="col-lg-5 mb-5">
            <div class="bg-light p-30 mb-30">
                <iframe style="width: 100%; height: 250px;"
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3742.932550924576!2d-50.230541585250265!3d-20.261631886418858!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9497f6227db8ac47%3A0xe0474566805fee39!2sFunda%C3%A7%C3%A3o%20Educacional%20de%20Fernand%C3%B3polis%20-%20FEF!5e0!3m2!1spt-BR!2sbr!4v1653966678554!5m2!1spt-BR!2sbr"
                        frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
            </div>
            <div style="height: 162px" class="bg-light p-30">
                <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>Av. Theotonio Vilela, s/n - Campus Universitário, Fernandópolis - SP, 15608-380</p>
                <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>eventos@eventos.com</p>
                <p class="mb-2"><i class="fa fa-phone-alt text-primary mr-3"></i>(17) 3465-0000</p>
            </div>
        </div>
    </div>
</div>
<!-- Contact End -->

<script>
    function validarCampos() {
        console.log("entrei na validação de campos");

        if (document.getElementById("nome").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#nome").focus();
        } else if (document.getElementById("email").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o email!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#email").focus();
        } else if (document.getElementById("assunto").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a assunto!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#assunto").focus();
        } else if (document.getElementById("mensagem").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o mensagem!',
                showConfirmButton: true,
                timer: 2000
            });
            $("#mensagem").focus();
        } else {
            enviarMensagem();
        }
    }

    function enviarMensagem() {
        console.log("Enviando mensagem ....");
        
        $.ajax({
            type: 'post',
            url: 'EnviarContato',
            data: {
                nome: $('#nome').val(),
                email: $('#email').val(),
                assunto: $('#assunto').val(),
                mensagem: $('#mensagem').val()
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Estado gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                //window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o estado!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                //window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        console.log("erro no envio");
                        //window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                    }
        });
    }
    
</script>
<jsp:include page="/home/footer.jsp"/>