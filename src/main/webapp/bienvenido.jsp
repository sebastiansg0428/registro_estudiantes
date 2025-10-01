<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <!-- Logo con URL -->
    <div class="flex justify-center mb-6">
        <img src="https://static.vecteezy.com/system/resources/previews/010/398/242/non_2x/star-student-academy-logo-concept-vector.jpg" 
             alt="Logo del sistema" 
             class="w-24 h-24 rounded-full shadow-md">
    </div>
    <title>Bienvenido - Registro de Estudiantes</title>

</head>
<body class="bg-gray-100 font-sans p-5">

    
    <h2 class="text-3xl text-center text-gray-800 mb-6">Bienvenido al Sistema de Registro de Estudiantes</h2>

    <!-- Mensajes dinámicos -->
    <%
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");

    if ("success".equals(msg)) {
    %>
    <div class="text-green-600 font-bold text-center mb-4">✅ Usuario registrado exitosamente.</div>
    <%
    } else if ("actualizado".equals(msg)) {
    %>
    <div class="text-green-600 font-bold text-center mb-4">✅ Usuario actualizado correctamente.</div>
    <%
    } else if ("usuarioExistente".equals(error)) {
    %>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Este correo ya está registrado. Intenta con otro.</div>
    <%
    } else if ("register".equals(error)) {
    %>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Error al registrar usuario. Intenta de nuevo.</div>
    <%
    } else if ("sql".equals(error)) {
    %>
    <div class="text-red-600 font-bold text-center mb-4">⚠ Error de conexión. Contacta al administrador.</div>
    <%
    }
    %>

    <!-- Formulario de Registro -->
    <div class="bg-white rounded-lg shadow-md max-w-md mx-auto p-6 mb-8">
        <h3 class="text-xl font-semibold text-center mb-4">Registrar Nuevo Usuario</h3>
        <form action="RegistrarUsuarioServlet" method="post" class="space-y-4">
            <input type="email" name="correo" placeholder="Correo electrónico" required
                   class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
            <input type="password" name="password" placeholder="Contraseña" required
                   class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
            <button type="submit" class="w-full bg-blue-500 text-white py-3 rounded-md hover:bg-blue-600 transition">Registrar</button>
        </form>
    </div>

    <!-- Listado de Usuarios -->
    <h3 class="text-xl font-semibold text-center mb-4">Listado de Usuarios Registrados</h3>
    <div class="overflow-x-auto">
        <table class="min-w-full bg-white shadow-md rounded-lg overflow-hidden">
            <thead class="bg-blue-500 text-white">
                <tr>
                    <th class="py-3 px-4">ID</th>
                    <th class="py-3 px-4">Correo</th>
                    <th class="py-3 px-4">Contraseña</th>
                    <th class="py-3 px-4">Eliminar</th>
                    <th class="py-3 px-4">Editar</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <%
                    String url = "jdbc:mysql://localhost:3306/registro_estudiantes";
                    String user = "root";
                    String pass = "";
                    String driver = "com.mysql.cj.jdbc.Driver";

                    try {
                        Class.forName(driver);
                        Connection conn = DriverManager.getConnection(url, user, pass);

                        String sql = "SELECT id, correo, contraseña FROM usuarios";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                %>
                <tr class="border-b hover:bg-gray-100">
                    <td class="py-2 px-4"><%= rs.getInt("id") %></td>
                    <td class="py-2 px-4"><%= rs.getString("correo") %></td>
                    <td class="py-2 px-4"><%= rs.getString("contraseña") %></td>
                    <td class="py-2 px-4">
                        <form action="EliminarUsuarioServlet" method="post" 
                              onsubmit="return confirm('⚠ ¿Seguro que quieres eliminar este usuario?');">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition">🗑 Eliminar</button>
                        </form>
                    </td>
                    <td class="py-2 px-4">
                        <form action="EditarUsuario.jsp" method="get">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition">✏️ Editar</button>
                        </form>
                    </td>
                </tr>
                <%
                        }

                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='text-red-600 font-bold'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Botón de Cerrar Sesión -->
    <a href="logout.jsp" class="block w-48 mx-auto mt-6 bg-blue-500 text-white py-2 rounded hover:bg-blue-600 text-center transition">⬅🚪 Cerrar Sesión</a>

</body>
</html>
