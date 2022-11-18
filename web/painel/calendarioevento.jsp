<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<html lang="pt-br">
    <head>
        <meta charset='utf-8' />
        <link href='${pageContext.request.contextPath}/painel/fullcalendar/css/fullcalendar.min.css' rel='stylesheet' />
        <link href='${pageContext.request.contextPath}/painel/fullcalendar/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
        <link href='${pageContext.request.contextPath}/painel/fullcalendar/css/personalizado.css' rel='stylesheet' />
        <script src='${pageContext.request.contextPath}/painel/fullcalendar/js/moment.min.js'></script>
        <script src='${pageContext.request.contextPath}/painel/fullcalendar/js/jquery.min.js'></script>
        <script src='${pageContext.request.contextPath}/painel/fullcalendar/js/fullcalendar.min.js'></script>
        <script src='${pageContext.request.contextPath}/painel/fullcalendar/locale/pt-br.js'></script>
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
    </head>
    <body>

        <div id='calendar'></div>

    </body>
</html>
