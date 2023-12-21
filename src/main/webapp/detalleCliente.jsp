<%--
  Created by IntelliJ IDEA.
  User: muffinsita
  Date: 21/12/23
  Time: 18:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Detalle cliente</title>
</head>
<body>
<%
  String nombre_completo = request.getParameter("nombre_completo");
%>
  <h3>Detalles del Cliente con nombre <%=nombre_completo%></h3>
<table style="width: 100%; padding-left: 20px; display: flex; flex-direction: column; justify-content: center; align-items: center">
    <tr style="background-color: antiquewhite; text-align: center">
      <th>Identificador</th>
      <th>Nombre completo</th>
      <th>Dirección</th>
      <th>Teléfono</th>
      <th>Fecha de nacimiento</th>
    </tr>
    <tr style="text-align: center">
      <td><%= request.getParameter("identificador") %></td>
      <td><%= request.getParameter("nombre_completo") %></td>
      <td><%= request.getParameter("direccion") %></td>
      <td><%= request.getParameter("telefono") %></td>
      <td><%= request.getParameter("fecha_nacimiento") %></td>
    </tr>
  </table>
  <br>
  <form method="post" action="listadoClientes.jsp" >
    <input type="submit" value="Volver a listado de clientes" style="background-color: darkcyan; color: white">
  </form>
  <p style="text-align: center">__̴ı̴̴̡̡̡ ̡͌l̡̡̡ ̡͌l̡*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___</p>

</body>
</html>
