<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css"/>
    <title>Buscar Cliente</title>
</head>
<body>
<%
    String nombreBuscado = request.getParameter("nombre_completo");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/miBaseDeDatos", "root", "root");
    Statement s = conexion.createStatement();

    String query = "SELECT * FROM cliente WHERE nombre_completo LIKE '%" + nombreBuscado + "%'";
    ResultSet listado = s.executeQuery(query);
%>

<h3> Resultados para el nombre: <%=nombreBuscado%></h3>

<%
    if (listado.next()) {
%>
<table style="padding-left: 20px">
    <tr>
        <th>Nombre</th>
    </tr>
    <%
        do {
    %>
    <tr>
        <td style="border: 1px solid green"><%= listado.getString("nombre_completo") %></td>
        <td>
            <form method="get" action="detalleCliente.jsp">
                <input type="hidden" name="identificador" value="<%=listado.getInt("identificador") %>"/>
                <input type="hidden" name="nombre_completo" value="<%=listado.getString("nombre_completo") %>"/>
                <input type="hidden" name="direccion" value="<%=listado.getString("direccion") %>"/>
                <input type="hidden" name="telefono" value="<%=listado.getString("telefono") %>"/>
                <input type="hidden" name="fecha_nacimiento" value="<%=listado.getDate("fecha_nacimiento") %>"/>
                <input class="btn-ver-detalles" type="submit" value="VER DETALLES" style="background-color: darkcyan; color: white">
            </form>
        </td>
    </tr>
    <%
        } while (listado.next());
    %>
</table>
<%
    } else {
        session.setAttribute("error", "No se encontraron clientes nombrados" + nombreBuscado);
        response.sendRedirect("listadoClientes.jsp");
    }
    listado.close();
    s.close();
    conexion.close();
%>
</body>
</html>
