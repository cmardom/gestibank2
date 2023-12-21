<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: muffinsita
  Date: 21/12/23
  Time: 18:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Editar Cliente</title>
</head>
<body>
<%
    int identificador = Integer.parseInt(request.getParameter("identificador"));
    String nombre_completo = request.getParameter("nombre_completo");
    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    Date fecha_nacimiento = new Date(request.getParameter("fecha_nacimiento"));
%>
    <h1>Edita el cliente con el identificador <%=identificador%></h1>
    <form method="post" action="editaCliente.jsp" >
        <input type="hidden" name="identificador" value="<%=identificador%>"><br>
        <input type="text" name="nombre_completo" value="<%=nombre_completo%>"><br>
        <input type="text" name="direccion" value="<%=direccion%>"><br>
        <input type="text" name="telefono" value="<%=telefono%>"><br>
        <input type="date" name="fecha_nacimiento" value="<%=fecha_nacimiento%>"><br><br>
        <input type="submit" value="EDITAR" style="background-color: cornflowerblue; color: white">
    </form>
<p style="text-align: center">__̴ı̴̴̡̡̡ ̡͌l̡̡̡ ̡͌l̡*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___</p>


</body>
</html>
