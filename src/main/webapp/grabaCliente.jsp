<%@ page import="java.util.Objects" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: muffinsita
  Date: 21/12/23
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Graba Cliente</title>
</head>
<body>
    <%
        boolean valida = true;
        int identificador = -1;
        String nombre_completo = null;
        String direccion = null;
        String telefono = null;
        Date fecha_nacimiento = null;
        java.util.Date fechaFormateada = null;
        java.sql.Date sqlDate = null;

/*
        boolean flagValidaIdentificador = false;
*/
        boolean flagValidaNombre_completo = false;
        boolean flagValidaNombre_notnull = false;
        boolean flagValidaDireccion = false;
        boolean flagValidaDireccionNotNull = false;
        boolean flagValidaTelefono = false;
        boolean flagValidaTelefonoNotNull = false;

        boolean flagValidaFecha_nacimiento = false;

        try{
            /*IDENTIFICADOR = INT*/
           /* identificador = Integer.parseInt(request.getParameter("identificador"));
            flagValidaIdentificador = true;*/

            /*NOMBRE_COMPLETO = STRING*/
            if (request.getParameter("nombre_completo").isBlank()) throw new Exception("Parámetro vacío o espacios en blanco");
            flagValidaNombre_completo = true;
            Objects.requireNonNull(request.getParameter("nombre_completo"));
            flagValidaNombre_notnull = true;

            nombre_completo = request.getParameter("nombre_completo");

            /*DIRECCION = STRING*/
            if (request.getParameter("direccion").isBlank()) throw new Exception ("Parámetro vacío o espacios en blanco");
            flagValidaDireccion = true;
            Objects.requireNonNull(request.getParameter("direccion"));
            flagValidaDireccionNotNull = true;

            direccion = request.getParameter("direccion");


            /*TELEFONO = STRING*/
            if (request.getParameter("telefono").isBlank()) throw new Exception ("Parámetro vacío o espacios en blanco");
            flagValidaTelefono = true;
            Objects.requireNonNull(request.getParameter("telefono"));
            flagValidaTelefonoNotNull = true;

            telefono = request.getParameter("telefono");


            /*FECHA NACIMIENTO = DATE*/
            Objects.requireNonNull(request.getParameter("fecha_nacimiento"));
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            fechaFormateada = format.parse(request.getParameter("fecha_nacimiento"));
            flagValidaFecha_nacimiento = true;
            System.out.println("validafecha_ " + flagValidaFecha_nacimiento);

            sqlDate = new java.sql.Date(fechaFormateada.getTime());









        } catch (Exception e){
            e.printStackTrace();

            /*Mensajes de error*/
           /* if (!flagValidaIdentificador){
                session.setAttribute("error", "Error en el IDENTIFICADOR");
            } else */if (!flagValidaNombre_completo || !flagValidaNombre_notnull){
                session.setAttribute("error", "Error en el NOMBRE_COMPLETO");
            } else if (!flagValidaDireccion || !flagValidaDireccionNotNull) {
                session.setAttribute("error", "Error en la DIRECCION");
            } else if (!flagValidaTelefono || !flagValidaTelefonoNotNull){
                session.setAttribute("error", "Error en el TELEFONO");
            } else if (!flagValidaFecha_nacimiento){
                session.setAttribute("error", "Error en la FECHA");
            }

            valida = false;

        }

        /***************************************/

        if (valida){
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/miBaseDeDatos", "root", "root");

                String query = "INSERT INTO cliente (nombre_completo, direccion, telefono, fecha_nacimiento) VALUES (?, ?, ?, ?)";


                        ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

                int idx = 1;
                //ps.setInt(idx++, identificador);
                ps.setString(idx++, nombre_completo);
                ps.setString(idx++, direccion);
                ps.setString(idx++,telefono);
                ps.setDate(idx, sqlDate);

                int filasAfectadas = ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();

                System.out.println("Entrenamiento grabado. Filas afectadas -> " + filasAfectadas);

                ;} catch (Exception e){
                    e.printStackTrace();
                } finally{

                    try {
                        if (ps != null) ps.close();
                    } catch (Exception ex) {ex.printStackTrace();}
                    try {
                        if (conn != null) conn.close();
                    } catch (Exception ex) {ex.printStackTrace();}

                }

                response.sendRedirect("listadoClientes.jsp");

            } else {
            response.sendRedirect("listadoClientes.jsp");
            }

    %>
</body>
</html>
