<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: muffinsita
  Date: 21/12/23
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Borrar socio</title>
</head>
<body>

<%
    boolean valida = true;
    int identificador = -1;

    try {
        identificador = Integer.parseInt(request.getParameter("identificador"));

    } catch (NumberFormatException nfe) {
        nfe.printStackTrace();
        valida = false;
    }



    if (valida){
        Connection conn = null;
        PreparedStatement ps = null;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/miBaseDeDatos","root", "root");

            String query = "DELETE FROM cliente WHERE identificador = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, identificador);

            int filasAfectadas = ps.executeUpdate();

            System.out.println("Clientes borrados -> " + filasAfectadas);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try { ps.close(); } catch (Exception e) { /* Ignored */ }
            try { conn.close(); } catch (Exception e) { /* Ignored */ }
        }
    }
%>
<script>document.location = "listadoClientes.jsp"</script>

</body>
</html>
