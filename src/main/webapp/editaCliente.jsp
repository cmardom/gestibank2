<%@ page import="java.util.Objects" %>
<%@ page import="java.util.IllegalFormatCodePointException" %>
<%@ page import="java.text.Normalizer" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css"/>
    <title>Editar Cliente</title>
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

    boolean flagValidaIdentificador = false;
    boolean flagValidaNombre_completo = false;
    boolean flagValidaNombre_notnull = false;
    boolean flagValidaDireccion = false;
    boolean flagValidaDireccionNotNull = false;
    boolean flagValidaTelefono = false;
    boolean flagValidaTelefonoNotNull = false;

    boolean flagValidaFecha_nacimiento = false;

    try{
        /*IDENTIFICADOR = INT*/
        identificador = Integer.parseInt(request.getParameter("identificador"));
        flagValidaIdentificador = true;


        /*NOMBRE COMPLETO = STRING*/
        if (request.getParameter("nombre_completo").isBlank()) throw new Exception("Parámetro vacío o espacios en blanco");
        flagValidaNombre_completo = true;
        Objects.requireNonNull(request.getParameter("nombre_completo"));
        flagValidaNombre_notnull = true;


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

        sqlDate = new java.sql.Date(fechaFormateada.getTime());

    } catch (Exception ex){
        ex.printStackTrace();

        /*Mensajes de error*/
        if (!flagValidaIdentificador){
            session.setAttribute("error", "Error en el IDENTIFICADOR");
        } else if (!flagValidaNombre_completo || !flagValidaNombre_notnull){
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

    if (valida){
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/miBaseDeDatos", "root", "root");

            String query = "UPDATE cliente SET nombre_completo = ?, direccion = ?, telefono = ?, fecha_nacimiento = ? WHERE identificador = ?";

            ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

            //ps = conn.prepareStatement(query);

            int idx = 1;
            ps.setString(idx++, nombre_completo);
            ps.setString(idx++, direccion);
            ps.setString(idx++,telefono);
            ps.setDate(idx++, sqlDate);
            ps.setInt(idx++, identificador);


            int filasAfectadas = ps.executeUpdate();
            System.out.println("Cliente editado. Filas afectadas -> " + filasAfectadas);

        } catch (Exception e){
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
