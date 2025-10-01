<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio de Sesión</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-blue-400 to-teal-300 flex items-center justify-center min-h-screen">

    <div class="max-w-sm w-full bg-white p-8 rounded-2xl shadow-xl text-center">
        <!-- Logo (opcional) -->
        

        <!-- Títulos -->
        <h2 class="text-2xl font-bold text-gray-800 mb-2">Bienvenidos al sistema de registro de estudiantes</h2>
        <h3 class="text-lg text-gray-600 mb-6">Iniciar Sesión</h3>

        <!-- Mensaje de error dinámico -->
        <%
            String error = request.getParameter("error");
            if (error != null) {
                String mensaje = "";
                switch (error) {
                    case "passIncorrecta":
                        mensaje = "⚠ Contraseña incorrecta. Intenta nuevamente.";
                        break;
                    case "noExiste":
                        mensaje = "⚠ Usuario no encontrado. Verifica tu correo.";
                        break;
                    case "sql":
                        mensaje = "⚠ Error de conexión. Contacta al administrador.";
                        break;
                }
        %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= mensaje %>
            </div>
        <%
            }
        %>

        <!-- Formulario -->
        <form action="iniciarSesionServlet" method="post" class="space-y-4">
            <div>
                <label for="usuario" class="block text-left font-semibold text-gray-700 mb-1">Correo electrónico:</label>
                <input type="text" name="correo" id="usuario" placeholder="Ejemplo@hotmail.com" required
                       class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
            </div>

            <div>
                <label for="password" class="block text-left font-semibold text-gray-700 mb-1">Contraseña:</label>
                <input type="password" name="password" id="password" placeholder="********" required
                       class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
            </div>

            <input type="submit" value="Ingresar"
                   class="w-full bg-blue-500 hover:bg-blue-600 text-white font-bold py-3 rounded-lg cursor-pointer transition">
        </form>
    </div>

</body>
</html>



