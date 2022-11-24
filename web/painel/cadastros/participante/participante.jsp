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
            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-target=".bd-example-modal-lg" data-ad="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="datatable" class="display">
                            <thead>
                                <tr>
                                    <th align="center">ID</th>
                                    <th align="center">Nome</th>
                                    <th align="center">CPF/CNPJ</th>
                                    <th align="center">Cidade - UF</th>
                                    <th align="center"></th>
                                    <th align="center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="participante" items="${participantes}">
                                    <tr>
                                        <td align="right">${participante.idParticipante}</td>
                                        <td align="left">${participante.nomeRazaoPessoa}</td>
                                        <td align="left">${participante.cpfCnpjPessoa}</td>
                                        <td align="left">${participante.cidade.nomeCidade} - ${participante.cidade.estado.siglaEstado}</td>
                                        <td align="center">
                                            <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                               data-id="" onclick="setDadosModal(${participante.idParticipante})">
                                                <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                        </td>
                                        <td align="center">
                                            <a href="#" onclick="deletar(${participante.idParticipante}, '${participante.situacao}')">
                                                <button class="btn
                                                        <c:out value="${participante.situacao == 'A' ? 'btn-danger':'btn-success'}"/>">
                                                    <i class="fas fa-fw
                                                       <c:out value="${participante.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                    <Strong>
                                                        <c:out value="${participante.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>
                                                    </Strong>
                                                </button></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal fade bd-example-modal-lg" id="modaladicionar" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Adicionar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idpessoa" id="idpessoa" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="idadministrador" id="idparticipante" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label id="labelcpfcnpj">CPF/CNPJ</label>
                                        <input class="form-control" type="text" name="cpfcnpjpessoa" id="cpfcnpjpessoa" value=""/>
                                    </div>
                                    <div class="col-sm">
                                        <label>RG/IE</label>
                                        <input class="form-control" type="text" name="rgiepessoa" id="rgiepessoa" value=""/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>Nome/Razão Social</label>
                                        <input class="form-control" type="text" name="nomerazaopessoa" id="nomerazaopessoa"/>
                                    </div>
                                    <div class="col-sm">
                                        <label>Logradouro</label>
                                        <input class="form-control" type="text" name="logradouropessoa" id="logradouropessoa"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">                                                                 
                                    <div class="col-sm">
                                        <label>Número</label>
                                        <input class="form-control" type="text" name="numlogradouropessoa" id="numlogradouropessoa" value=""/>
                                    </div>
                                    <div class="col-sm">
                                        <label>Bairro</label>
                                        <input class="form-control" type="text" name="bairropessoa" id="bairropessoa" value=""/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>CEP</label>
                                        <input class="form-control" type="text" name="ceppessoa" id="ceppessoa" value="" placeholder="00000-000" oninput="criaMascaraCEP()" maxLength="8"/>
                                    </div>
                                    <div class="col-sm">
                                        <label>Estado</label>
                                        <select class="form-control" name="idestado" id="idestado" onchange="BuscarCidadesPorEstado()" required>
                                            <option value="nulo">Selecione</option>
                                            <c:forEach var="estado" items="${estados}">
                                                <option value="${estado.idEstado}" ${participante.cidade.estado.idEstado == estado.idEstado ? "selected" : ""}>
                                                    ${estado.nomeEstado}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm">
                                        <label>Cidade</label>
                                        <select class="form-control" name="idcidade" id="idcidade" required>
                                            <option value="nulo">Selecione</option>
                                            <c:forEach var="cidade" items="${cidades}">
                                                <option value="${cidade.idCidade}" ${participante.cidade.idCidade == cidade.idCidade ? "selected" : ""}>
                                                    ${cidade.nomeCidade} 
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label class="m-t-0 header-title">Data Nascimento/Fundação</label>
                                        <input class="form-control" type="date" name="datanascfundpessoa" id="datanascfundpessoa" value=""/>
                                    </div>
                                    <div class="col-sm">                                        
                                        <label>Telefone</label>
                                        <input class="form-control" type="tel" name="telefonepessoa" id="telefonepessoa" value="" placeholder="(00) 00000-0000" oninput="criaMascaraTelefone()" maxLength="11"/>
                                    </div>
                                    <div class="col-sm">
                                        <label>E-mail</label>
                                        <input class="form-control" type="email" name="emailpessoa" id="emailpessoa" placeholder="exemplo@email.com"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">  
                                    <div class="col-sm">
                                        <label>Sexo</label>
                                        <select class="form-control" name="sexoparticipante" id="sexoparticipante">
                                            <option value="N" ${participante.sexoParticipante == 'N' ? "selected" : ""}>Prefiro não dizer</option>  
                                            <option value="F" ${participante.sexoParticipante == 'F' ? "selected" : ""}>Feminino</option>
                                            <option value="M" ${participante.sexoParticipante == 'M' ? "selected" : ""}>Masculino</option>               
                                        </select>
                                    </div>   
                                    <div class="col-sm">
                                        <label id="labellogin">Login</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="inputGroupPrepend2">@</span>
                                            </div>
                                            <input class="form-control" type="text" name="login" id="login" value="" size="20" maxlength="20" required/>
                                        </div>
                                    </div>
                                    <div class="col-sm">
                                        <label>Senha</label>
                                        <input class="form-control" type="password" name="senha" id="senha" value="" size="20" maxlength="20" required/>
                                    </div>
                                </div>                                
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <a href="#" onclick="validarCampos()">
                                    <button type="button" class="btn btn-success">Salvar</button>
                                </a>
                            </div>
                        </div>
                    </div>
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
        //$("#datatable").DataTable({});
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

    var cidade = ''; //variavel para controle do carregamento de cidades
    function limparDadosModal() {
        $('#idpessoa').val("0");
        $('#idparticipante').val("0");
        $('#situacao').val("");
        $('#cpfcnpjpessoa').val("");
        $('#rgiepessoa').val("");
        $('#nomerazaopessoa').val("");
        $('#datanascfundPessoa').val("");
        $('#telefonepessoa').val("");
        $('#logradouropessoa').val("");
        $('#sexoparticipante').val("Prefiro não dizer");
        $('#numlogradouropessoa').val("");
        $('#bairropessoa').val("");
        $('#ceppessoa').val("");
        $('#emailpessoa').val("");
        $('#login').val("");
        $('#senha').val("");
        $('#idestado').val("0");
    }

    function setDadosModal(valor) {
        limparDadosModal();
        document.getElementById('idpessoa').value = valor;
        document.getElementById('idparticipante').value = valor;
        document.getElementById('login').readOnly = false;
        document.getElementById('labellogin').innerHTML = "Login";
        document.getElementById('login').classList.remove("is-invalid");
        document.getElementById('login').classList.remove("is-valid");
        document.getElementById('labelcpfcnpj').innerHTML = "CPF/CNPJ";
        document.getElementById('cpfcnpjpessoa').classList.remove("is-valid");
        document.getElementById('cpfcnpjpessoa').classList.remove("is-invalid");
        var idPar = valor;
        if (idPar != "0") {
            $.getJSON('ParticipanteCarregar', {idParticipante: idPar}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idParticipante;
                if (id != "0") {
                    $('#idpessoa').val(respostaServlet.idPessoa);
                    $('#idparticipante').val(respostaServlet.idParticipante);
                    $('#situacao').val(respostaServlet.situacao);
                    $('#cpfcnpjpessoa').val(respostaServlet.cpfCnpjPessoa);
                    $('#rgiepessoa').val(respostaServlet.rgIePessoa);
                    $('#nomerazaopessoa').val(respostaServlet.nomeRazaoPessoa);
                    $('#datanascfundpessoa').val(respostaServlet.dataNascFundPessoa);
                    $('#telefonepessoa').val(respostaServlet.telefonePessoa);
                    $('#logradouropessoa').val(respostaServlet.logradouroPessoa);
                    $('#sexoparticipante').val(respostaServlet.sexoParticipante);
                    $('#numlogradouropessoa').val(respostaServlet.numLogradouroPessoa);
                    $('#bairropessoa').val(respostaServlet.bairroPessoa);
                    $('#ceppessoa').val(respostaServlet.cepPessoa);
                    $('#emailpessoa').val(respostaServlet.emailPessoa);
                    $('#login').val(respostaServlet.login);
                    $('#senha').val(respostaServlet.senha);
                    $('#idestado').val(respostaServlet.cidade.estado.idEstado);
                    cidade = respostaServlet.cidade.idCidade;
                    BuscarCidadesPorEstado();
                    document.getElementById('login').readOnly = true;
                }
                criaMascaraTelefone();
                trocaMascaraCpfCnpj($('#cpfcnpjpessoa').val());
                criaMascaraCEP();
            });
        }
    }

    function carregarPessoa(v) {
        var idM = v;
        var tipoPessoa = 'participante';
        $(document).ready(function () {
            $.getJSON('PessoaBuscarCpfCnpj', {cpfcnpjpessoa: idM, tipopessoa: tipoPessoa}, function (respostaPar) {
                console.log(respostaPar);
                if (respostaPar != null) {
                    $('#idparticipante').val(respostaPar.idParticipante);
                    $('#idpessoa').val(respostaPar.idPessoa);
                    $('#situacao').val(respostaPar.situacao);
                    $('#cpfcnpjpessoa').val(respostaPar.cpfCnpjPessoa);
                    $('#rgiepessoa').val(respostaPar.rgIePessoa);
                    $('#nomerazaopessoa').val(respostaPar.nomeRazaoPessoa);
                    $('#datanascfundpessoa').val(respostaPar.dataNascFundPessoa);
                    $('#telefonepessoa').val(respostaPar.telefonePessoa);
                    $('#sexoparticipante').val(respostaPar.sexoParticipante);
                    $('#logradouropessoa').val(respostaPar.logradouroPessoa);
                    $('#numlogradouropessoa').val(respostaPar.numLogradouroPessoa);
                    $('#bairropessoa').val(respostaPar.bairroPessoa);
                    $('#ceppessoa').val(respostaPar.cepPessoa);
                    $('#emailpessoa').val(respostaPar.emailPessoa);
                    $('#login').val(respostaPar.login);
                    if ($('#login').val() != '') {
                        document.getElementById('login').readOnly = true;
                    }
                    $('#senha').val(respostaPar.senha);
                    var datanasc = respostaPar.dataNascFundPessoa;
                    console.log(datanasc);
                    $('#datanascfundpessoa').val(datanasc);
                    $('#idestado').val(respostaPAr.cidade.estado.idEstado);
                    cidade = respostaPar.cidade.idCidade;
                    BuscarCidadesPorEstado();

                } else {
                    tipoPessoa = 'pessoa';
                    $.getJSON('PessoaBuscarCpfCnpj', {cpfcnpjpessoa: idM, tipopessoa: tipoPessoa}, function (respostaPessoa) {
                        console.log(respostaPessoa);
                        var id = respostaPessoa.idPessoa;
                        if (id != "0")
                        {
                            $('#idpessoa').val(respostaPessoa.idPessoa);
                            $('#cpfcnpjpessoa').val(respostaPessoa.cpfCnpjPessoa);
                            $('#rgiepessoa').val(respostaPessoa.rgIePessoa);
                            $('#nomerazaopessoa').val(respostaPessoa.nomeRazaoPessoa);
                            $('#datanascfundpessoa').val(respostaPessoa.dataNascFundPessoa);
                            $('#telefonepessoa').val(respostaPessoa.telefonePessoa);
                            $('#logradouropessoa').val(respostaPessoa.logradouroPessoa);
                            $('#numlogradouropessoa').val(respostaPessoa.numLogradouroPessoa);
                            $('#bairropessoa').val(respostaPessoa.bairroPessoa);
                            $('#ceppessoa').val(respostaPessoa.cepPessoa);
                            $('#emailpessoa').val(respostaPessoa.emailPessoa);
                            $('#login').val(respostaPessoa.login);
                            $('#senha').val(respostaPessoa.senha);
                            var datanasc = respostaPessoa.dataNascFundPessoa;
                            console.log(datanasc);
                            $('#datanascfundpessoa').val(datanasc);
                            $('#idestado').val(respostaPessoa.cidade.estado.idEstado);
                            cidade = respostaPessoa.cidade.idCidade;
                            BuscarCidadesPorEstado();
                            if ($('#login').val() != '') {
                                document.getElementById('login').readOnly = true;
                            }
                        }
                        criaMascaraTelefone();
                        trocaMascaraCpfCnpj($('#cpfcnpjpessoa').val());
                        criaMascaraCEP();
                    });
                }
                criaMascaraTelefone();
                trocaMascaraCpfCnpj($('#cpfcnpjpessoa').val());
                criaMascaraCEP();
            });
        });
        document.getElementById('labelcpfcnpj').innerHTML = "<FONT COLOR='green'>CPF/CNPJ válido</FONT>";
        document.getElementById('cpfcnpjpessoa').classList.add("is-valid");
        document.getElementById('cpfcnpjpessoa').classList.remove("is-invalid");
    }

    function deletar(codigo, situacao) {
        var id = codigo;
        console.log(codigo);

        var titulo = "";
        var tituloConfirmacao = "";
        var confirmButtonText = "";

        if (situacao == 'I') {
            titulo = "Você deseja realmente ativar o Participante?";
            confirmButtonText = "Sim, ative o Participante!";
            tituloConfirmacao = "Participante ativado com sucesso!";

        } else {
            titulo = "Você deseja realmente inativar o Participante?";
            confirmButtonText = "Sim, inative o Participante!";
            tituloConfirmacao = "Participante inativado com sucesso!";
        }

        Swal.fire({
            title: 'Você tem certeza?',
            text: titulo,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: confirmButtonText,
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/ParticipanteExcluir',
                    data: {
                        idParticipante: id
                    },
                    success:
                            function (data) {
                                if (data == 1) {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'success',
                                        title: 'Sucesso',
                                        text: tituloConfirmacao,
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/ParticipanteListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'Não foi possível ativar/inativar Participante!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/ParticipanteListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/ParticipanteListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log("entrei na validação de campos");

        url = "PessoaVerificarLogin?login=" + document.getElementById("login").value;
        $.getJSON(url, function (result) {
            console.log(result);
            if (document.getElementById("cpfcnpjpessoa").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o CPF/CNPJ!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#cpfcnpjpessoa").focus();
            } else if (document.getElementById('cpfcnpjpessoa').classList == "form-control is-invalid") {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o CPF/CNPJ!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#cpfcnpjpessoa").focus();
            } else if (document.getElementById("nomerazaopessoa").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o Nome!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#nomerazaopessoa").focus();
            } else if (document.getElementById("idcidade").value == 'nulo') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique a Cidade!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#idcidade").focus();
            } else if (document.getElementById("login").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o Login!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#login").focus();
            } else if ((result == 1) && (document.getElementById('login').readOnly == false)) {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o Login!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#login").focus();
            } else if (document.getElementById("senha").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique a Senha!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#senha").focus();
            } else if (document.getElementById("datanascfundpessoa").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique a Data de Nascimento/Fundação!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#datanascfundpessoa").focus();
            } else {
                gravarDados();
            }
        }).fail(function (obj, textStatus, error) {
            alert('Erro do servidor: ' + textStatus + ', ' + error);
        });
    }

    function gravarDados() {
        console.log("Gravando dados ....");
        let telefonepessoa = document.getElementById(`telefonepessoa`).value.replace(/([^0-9])+/g, "");
        let ceppessoa = document.getElementById(`ceppessoa`).value.replace(/([^0-9])+/g, "");

        $.ajax({
            type: 'post',
            url: 'ParticipanteCadastrar',
            data: {
                idparticipante: $('#idparticipante').val(),
                idpessoa: $('#idpessoa').val(),
                cpfcnpjpessoa: $('#cpfcnpjpessoa').unmask().val(),
                rgiepessoa: $('#rgiepessoa').val(),
                nomerazaopessoa: $('#nomerazaopessoa').val(),
                datanascfundpessoa: $('#datanascfundpessoa').val(),
                telefonepessoa: telefonepessoa,
                logradouropessoa: $('#logradouropessoa').val(),
                sexoparticipante: $('#sexoparticipante').val(),
                numlogradouropessoa: $('#numlogradouropessoa').val(),
                bairropessoa: $('#bairropessoa').val(),
                ceppessoa: ceppessoa,
                emailpessoa: $('#emailpessoa').val(),
                login: $("#login").val(),
                senha: $("#senha").val(),
                idcidade: $("#idcidade").val(),
                situacao: $("#situacao").val()
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
                                text: 'Participante gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/ParticipanteListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possível gravar o Participante!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/ParticipanteListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/ParticipanteListar";
                    }
        });
    }

    function BuscarCidadesPorEstado() {
        $('#idcidade').empty();
        idEst = $('#idestado').val();
        console.log("entrou buscar estado");
        if (idEst != 'null') {
            console.log("estado = " + idEst);
            url = "CidadeBuscarPorEstado?idestado=" + idEst;
            $.getJSON(url, function (result) {
                $.each(result, function (index, value) {
                    $('#idcidade').append('<option id="cidade_' + value.idCidade + '"value="' + value.idCidade + '">' + value.nomeCidade + '</option>');
                    console.log(value.idCidade);
                    if (cidade !== '') {
                        $('#cidade_' + cidade).prop({selected: true});
                    } else {
                        $('#cidade_').prop({selected: true});
                    }
                });
            }).fail(function (obj, textStatus, error) {
                alert('Erro do servidor: ' + textStatus + ', ' + error);
            });
        }
    }

    function criaMascaraTelefone() {
        const maximoInput = document.getElementById(`telefonepessoa`).maxLength;
        let valorInput = document.getElementById(`telefonepessoa`).value;
        let valorSemPonto = document.getElementById(`telefonepessoa`).value.replace(/([^0-9])+/g, "");
        const mascaras = valorInput.replace(/[^\d]/g, "").replace(/^(\d{2})(\d{5})(\d{4})/, "($1) $2-$3");

        valorInput.length === maximoInput ? document.getElementById(`telefonepessoa`).value = mascaras
                : document.getElementById(`telefonepessoa`).value = valorSemPonto;
    }

    function criaMascaraCEP() {
        const maximoInput = document.getElementById(`ceppessoa`).maxLength;
        let valorInput = document.getElementById(`ceppessoa`).value;
        let valorSemPonto = document.getElementById(`ceppessoa`).value.replace(/([^0-9])+/g, "");
        const mascaras = valorInput.replace(/[^\d]/g, "").replace(/(\d{5})(\d{3})/, "$1-$2");

        valorInput.length === maximoInput ? document.getElementById(`ceppessoa`).value = mascaras
                : document.getElementById(`ceppessoa`).value = valorSemPonto;
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Participante</strong>";
        document.getElementById('agrupamentocadastrosgerais').classList.add("menu-open");
        document.getElementById('menucadastrosgerais').classList.add("active");
        document.getElementById('menuparticipante').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

    //verificao do login
    $('#login').blur(function verificarLogin() {
        var login = $('#login').val();

        if (document.getElementById('login').readOnly == false) {

            if (login == '') {
                document.getElementById('labellogin').innerHTML = "<FONT COLOR='red'>Login inválido</FONT>";
                document.getElementById('login').classList.remove("is-valid");
                document.getElementById('login').classList.add("is-invalid");
            } else {
                var login = $('#login').val();
                console.log("entrou no verificar login: " + login);
                if (login != '') {
                    url = "PessoaVerificarLogin?login=" + login;
                    $.getJSON(url, function (result) {
                        console.log(result);
                        if (result == 1) {
                            document.getElementById('labellogin').innerHTML = "<FONT COLOR='red'>Login indisponível</FONT>";
                            document.getElementById('login').classList.remove("is-valid");
                            document.getElementById('login').classList.add("is-invalid");
                        } else if (result == 0) {
                            document.getElementById('labellogin').innerHTML = "<FONT COLOR='green'>Login disponível</FONT>";
                            document.getElementById('login').classList.remove("is-invalid");
                            document.getElementById('login').classList.add("is-valid");
                        }
                    }).fail(function (obj, textStatus, error) {
                        alert('Erro do servidor: ' + textStatus + ', ' + error);
                    });
                }
            }
        }
    });

</script>
<%@include file="/painel/footer.jsp"%>