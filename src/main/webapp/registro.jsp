<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro de Usuario - Sistema de Estudiantes</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 font-sans p-5">

    <h2 class="text-3xl text-center text-gray-800 mb-6">Registro de Usuario</h2>

    <!-- Mensajes dinámicos -->
    <%
        String error = request.getParameter("error");
        String msg = request.getParameter("msg");

        if ("usuarioExistente".equals(error)) {
    %>
        <div class="text-red-600 font-bold text-center mb-4">⚠ Este correo ya está registrado. Intenta con otro.</div>
    <%
        } else if ("registro".equals(error)) {
    %>
        <div class="text-red-600 font-bold text-center mb-4">⚠ Hubo un problema al registrar el usuario.</div>
    <%
        } else if ("sql".equals(error)) {
    %>
        <div class="text-red-600 font-bold text-center mb-4">⚠ Error de conexión. Contacta al administrador.</div>
    <%
        } else if ("success".equals(msg)) {
    %>
        <div class="text-green-600 font-bold text-center mb-4">✅ Registro exitoso. Ahora puedes iniciar sesión.</div>
    <%
        }
    %>

    <!-- Formulario de Registro -->
    <div class="bg-white rounded-lg shadow-md max-w-md mx-auto p-6">
        <h3 class="text-xl font-semibold text-center mb-4">Registrar Nuevo Usuario</h3>
        <form action="RegistrarUsuarioServlet" method="post" class="space-y-4">
            <input type="email" name="correo" placeholder="Correo electrónico" required
                   class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
            <input type="password" name="password" placeholder="Contraseña" required
                   class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
            <button type="submit" class="w-full bg-blue-500 text-white py-3 rounded-md hover:bg-blue-600 transition">Registrar</button>
        </form>
    </div>

    <a href="index.jsp" class="block w-48 mx-auto mt-6 bg-blue-500 text-white py-2 rounded hover:bg-blue-600 text-center transition">⬅️ Volver a Iniciar Sesión</a>

</body>
</html>

