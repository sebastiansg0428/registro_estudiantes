<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Usuario - Sistema de Estudiantes</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 font-sans p-5">

<h2 class="text-3xl text-center text-gray-800 mb-6">Editar Usuario</h2>

<%
    String idStr = request.getParameter("id");
    String error = request.getParameter("error");
    String msg = request.getParameter("msg");

    if ("registro".equals(error)) {
%>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Hubo un problema al actualizar el usuario. Intenta de nuevo.</div>
<%
    } else if ("sql".equals(error)) {
%>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Error de conexión. Contacta al administrador.</div>
<%
    } else if ("actualizado".equals(msg)) {
%>
    <div class="text-green-600 font-bold text-center mb-4">✅ Usuario actualizado correctamente.</div>
<%
    }

    if (idStr != null) {
        int id = Integer.parseInt(idStr);
        String correo = "";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/registro_estudiantes", "root", "");
            String sql = "SELECT correo, contraseña FROM usuarios WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                correo = rs.getString("correo");
                password = rs.getString("contraseña");
            } else {
%>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Usuario no encontrado.</div>
<%
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
%>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Error: <%= e.getMessage() %></div>
<%
        }
%>

<div class="bg-white rounded-lg shadow-md max-w-md mx-auto p-6">
    <h3 class="text-xl font-semibold text-center mb-4">Editar Usuario</h3>
    <form action="EditarUsuarioServlet" method="post" class="space-y-4">
        <input type="hidden" name="id" value="<%= idStr %>">
        <input type="email" name="correo" value="<%= correo %>" placeholder="Correo electrónico" required
               class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
        <input type="password" name="password" value="<%= password %>" placeholder="Contraseña" required
               class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
        <button type="submit" class="w-full bg-blue-500 text-white py-3 rounded-md hover:bg-blue-600 transition">Actualizar</button>
    </form>
</div>

<a href="bienvenido.jsp" class="block w-48 mx-auto mt-6 bg-blue-500 text-white py-2 rounded hover:bg-blue-600 text-center transition">⬅️ Volver</a>

<%
    }
%>

</body>
</html>
