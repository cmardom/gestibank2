<%--
  Created by IntelliJ IDEA.
  User: muffinsita
  Date: 18/12/23
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>

<html>
<head>
    <title>Listado de clientes</title>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/miBaseDeDatos", "root", "root");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery("SELECT * FROM cliente");
%>

<h2>GESTIBANK</h2>
<h3>Nuestros clientes</h3>
<table style="width: 100%; padding-left: 20px">
    <tr style="background-color: antiquewhite">
        <th>Identificador</th>
        <th>Nombre completo</th>
        <th>Dirección</th>
        <th>Teléfono</th>
        <th>Fecha de nacimiento</th>
    </tr>

    <%
        while (listado.next()) {

    %>
    <tr text-align: center>
        <td >
            <%=listado.getInt("identificador")%>
        </td>
        <td style="border: 1px solid green">
            <%=listado.getString("nombre_completo")%>
        </td>
        <td style="border: 1px solid green">
            <%=listado.getString("direccion")%>
        </td>
        <td style="border: 1px solid green">
            <%=listado.getString("telefono")%>
        </td>
        <td style="border: 1px solid green">
            <%=listado.getDate("fecha_nacimiento")%>
        </td>

        <td style="border-bottom: 1px dotted green">
            <div>
                <form method="get" action="editaCliente.jsp" style="display: flex">
                    <input type="hidden" name="identificador" value="<%=listado.getInt("identificador")%>" />
                    <input type="hidden" name="nombre_completo" value="<%=listado.getString("nombre_completo")%>" />
                    <input type="hidden" name="direccion" value="<%=listado.getString("direccion")%>" />
                    <input type="hidden" name="telefono" value="<%=listado.getString("telefono")%>" />
                    <input type="hidden" name="fecha_nacimiento" value="<%=listado.getDate("fecha_nacimiento")%>" />
                    <input class="btn-editar-cliente" type="submit" value="EDITAR" style="background-color: cornflowerblue; color: white">
                </form>

                <form method="get" action="borrarCliente.jsp">
                    <input type="hidden" name="identificador" value="<%=listado.getInt("identificador")%>"/>
                    <input type="submit" value="Borrar cliente" style="background-color: darkred; color: white">
                </form>

            </div>

        </td>

    </tr>

    <%
        } //fin while
        s.close();
        listado.close();
        conexion.close();
    %>
</table>
<br>
<form method="post" action="grabaCliente.jsp" style="padding-left: 20px; border-top: 1px solid black">
    <input type="hidden" type="number" name="identificador" placeholder="identificador">
    <input type="text" name="nombre_completo" placeholder="nombre completo">
    <input type="text" name="direccion" placeholder="direccion">
    <input type="text" name="telefono" placeholder="telefono">
    <input type="date" name="fecha_nacimiento" placeholder="fecha nacimiento">
    <button type="submit" style="background-color: darkcyan; color: white">Grabar cliente</button>
</form>

<%
    String mensajeError = (String) session.getAttribute("error");

    if (mensajeError != null){
%>
<span style="color:red"><%=mensajeError%></span>
<%
    session.removeAttribute("error");
    }

%>
<br>
<form method="post" action="buscaCliente.jsp" style="padding-left: 20px; border-top: 1px solid black">
    <input type="text" name="nombre_completo" placeholder="nombre completo">
    <input class="btn-buscar-cliente" type="submit" value="BUSCAR" style="background-color: gainsboro; color: black">
</form>
<p style="text-align: center">__̴ı̴̴̡̡̡ ̡͌l̡̡̡ ̡͌l̡*̡̡ ̴̡ı̴̴̡ ̡̡͡|̲̲̲͡͡͡ ̲▫̲͡ ̲̲̲͡͡π̲̲͡͡ ̲̲͡▫̲̲͡͡ ̲|̡̡̡ ̡ ̴̡ı̴̡̡ ̡͌l̡̡̡̡.___</p>
<%
    mensajeError = (String)session.getAttribute("error");

    if (mensajeError != null) {
%>
<span style="color:red"><%=mensajeError%></span>
<%
        session.removeAttribute("error");
    }
%>



</body>
</html>
