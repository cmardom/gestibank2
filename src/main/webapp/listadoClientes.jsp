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
    <title>Title</title>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clientes", "root", "root");
    Statement s = con.createStatement();

    ResultSet listado = s.executeQuery("SELECT * FROM cliente");
%>

<h2>GESTIBANK</h2>
<table>
    <tr>
        <th>Código</th>
        <th>Nombre</th>
        <th>Dirección</th>
        <th>Teléfono</th>
        <th>Fecha de nacimiento</th>
    </tr>

    <%
        while (listado.next()) {

        }
    %>
    <tr>
        <td>
            <%=listado.getInt("identificador")%>
        </td>
        <td>
            <%=listado.getString("nombre_completo")%>
        </td>
        <td>
            <%=listado.getString("direccion")%>
        </td>
        <td>
            <%=listado.getString("telefono")%>
        </td>
        <td>
            <%=listado.getDate("fecha_nacimiento")%>
        </td>

        <td>
            <div>
                <form method="get" action="formularioEditarCliente.jsp">
                    <input type="hidden" name="identificador" value="<%=listado.getInt("identificador")%>" />
                    <input type="hidden" name="nombre_completo" value="<%=listado.getString("nombre_completo")%>" />
                    <input type="hidden" name="direccion" value="<%=listado.getString("direccion")%>" />
                    <input type="hidden" name="telefono" value="<%=listado.getString("telefono")%>" />
                    <input type="hidden" name="fecha_nacimiento" value="<%=listado.getDate("fecha_nacimiento")%>" />
                </form>

                <form method="get" action="borrarCliente.jsp">
                    <input type="hidden" name="identificador" value="<%=listado.getInt("identificador")%>"/>
                    <input type="submit" value="Borrar cliente">
                </form>

            </div>

        </td>

    </tr>

    <%
        } //fin while
        s.close();
        listado.close();
        con.close();
    %>
</table>
<br>
<form method="post" action="grabarCliente.jsp">
    <input type="number" name="identificador" placeholder="identificador">
    <input type="text" name="nombre_completo" placeholder="nombre completo">
    <input type="text" name="direccion" placeholder="direccion">
    <input type="text" name="telefono" placeholder="telefono">
    <input type="date" name="fecha_nacimiento" placeholder="fecha nacimiento">
</form>

<%
    String mensajeError = (String) session.getAttribute("error");

    if (error != null){
%>
<span style="color:red"><%=mensajeError%></span>
<%
    session.removeAttribute("error");
    }

%>




</body>
</html>
