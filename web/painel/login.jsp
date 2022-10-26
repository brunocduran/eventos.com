<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
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
        
        <!-- Font Awesome -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/painel/plugins/fontawesome-free/css/all.min.css">
        <!-- icheck bootstrap -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/painel/plugins/icheck-bootstrap/icheck-bootstrap.min.css">

<!-- JQuery -->
        <script src="${pageContext.request.contextPath}/painel/js/jquery-3.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/painel/js/jquery.mask.min.js"></script>
        <script src="${pageContext.request.contextPath}/painel/js/jquery.maskMoney.min.js"></script>

       
        <!-- Datatable -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/painel/css/jquery.dataTables.min.css"/>
        <script src="${pageContext.request.contextPath}/painel/js/jquery.dataTables.min.js" type="text/javascript"></script>

        <!-- Importação da minha biblioteca de javascrip-->
        <script src="${pageContext.request.contextPath}/painel/js/app.js" type="text/javascript"></script>

        <!-- Mensagem alerta -->
        <script src="${pageContext.request.contextPath}/painel/js/sweetalert2.all.min.js" type="text/javascript"></script>

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>EVENTOS</b>.COM</a>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
        <div id="erro" class="login-box-msg">Faça login para iniciar a sessão!</div>
      <!--<form>-->
        <div class="input-group mb-3">
          <input name="login" id="login" class="form-control" placeholder="Login">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" name="senha" id="senha" class="form-control" placeholder="Senha">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>       
        <div class="row">        
          <div class="col-8">              
              <!-- select -->
            <div class="form-group" id="selecaoUsuario">
              <select name="tipo" id="tipo" class="form-control">
                <option value="">Selecione Tipo Usuário</option>
              </select>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button id="submit" name="submit" class="btn btn-primary btn-block">Entrar</button>
          </div>
          <!-- /.col -->
        </div>
      <!--</form>-->

      <!-- /.social-auth-links -->

      <p class="mb-1">
        <a href="forgot-password.html">Esqueci a senha</a>
      </p>
      <p class="mb-1">
        <a href="${pageContext.request.contextPath}/Cadastrar" class="text-center">Cadastre-se</a>
      </p>
      <p class="mb-0">
        <a href="${pageContext.request.contextPath}/Home" class="text-center">Voltar para Página Inicial</a>
      </p>                         
         
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->

<script>
       $(document).ready(function(){
        console.log("Entrei na função...");
        document.getElementById("selecaoUsuario").style.display = "none";
        
        $("#submit").on("click", function(){
            console.log("entrei na função click do submit");
            
            if ($('#login').val() === ""){
                $('#login').focus();
                $('#erro').html("<div> Por favor, preencher o campo usuário. </div>").show();
                tempo();
                return false;               
            }
            if ($('#senha').val() === ""){
                $('#senha').focus();
                $('#erro').html("<div> Por favor, preencher o campo senha. </div>").show();
                tempo();
                return false;               
            }
            //$('#submit').prop("disabled", true);
            //$('#submit').html('<i class="fa fa-spinner" aria-hidden="true"></i> Aguarde....');
            //var login = ;
            console.log("Login que será enviado" + $('#login').val());
            console.log("Senha que será enviado" + $('#senha').val());
            console.log("Tipo usuario que será enviado" + $('#tipo').val());
            
            $.ajax({
                type : 'post',
                url : '${pageContext.request.contextPath}/UsuarioLogar',
                data : {
                    login : $('#login').val(),
                    senha: $('#senha').val(),
                    tipo: $('#tipo').val()
                },
                success: 
                        function(data){
                            console.log("Resposta da variavel data: "+data);
                            if (data == 'ok'){
                                window.location.href = "${pageContext.request.contextPath}/Painel"     
                            }else if(data == '0'){
                                $('#tipo').empty();
                                document.getElementById("selecaoUsuario").style.display = "none";
                                $('#erro').html("<div> Usuário ou senha inválidos !!! </div>").show(); 
                            }else if(data == '1'){
                                $('#tipo').empty();
                                document.getElementById("selecaoUsuario").style.display = "none";
                                $('#login').focus();
                                $('#login').val("");
                                $('#senha').val("");
                                $('#erro').html("<div> Nível de permissão inválido !!! </div>").show();    
                            }else {
                               BuscarTipoUsuario(data);
                            }
                        },
                error:
                        function (data){
                            RefreshTable();
                        }
            });
        });
        
            function tempo() {
                        setTimeout(function () {
                            $("#wrapper_error").hide();
                        }, 10000); // 3 segundos
                    }
        });
        
    function BuscarTipoUsuario(dados){
        console.log("Entrei na função buscar tipo usuario");
        console.log("Dados recebidos por parametro: "+dados);
         $('#erro').html("<div> Seu perfil possui mais de um nível de permissão, escolha um para logar.</div>").show(); 
        $('#tipo').empty();
        document.getElementById("selecaoUsuario").style.display = "block"; //exibir div do usuario
        
        $.each(JSON.parse(dados), function(index, value){
             $('#tipo').append('<option id="usuario_' + value.idPessoa +'"value="' + value.tipo + '">' + value.tipo + '</option>');
             
             if (value.idPessoa !== ''){
                $('#usuario_'+value.idPessoa).prop({selected: true});
            }else{
                $('#usuario_').prop({selected: true});
            }
        });
      
    }
        
   
</script>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/painel/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/painel/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/painel/js/adminlte.min.js"></script>
</body>
</html>
