package com.mycompany.registro_estudiantes;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

@WebServlet("/EliminarUsuarioServlet")
public class EliminarUsuarioServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Configuración de la conexión
    private String jdbcURL = "jdbc:mysql://localhost:3306/registro_estudiantes";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";
    private String jdbcDriver = "com.mysql.cj.jdbc.Driver";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener el ID enviado desde el formulario
        String id = request.getParameter("id");

        try {
            // Cargar driver
            Class.forName(jdbcDriver);

            // Conectar a la base de datos
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {

                String sql = "DELETE FROM usuarios WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, Integer.parseInt(id));

                    int filas = stmt.executeUpdate();

                    if (filas > 0) {
                        System.out.println("✅ Usuario con ID " + id + " eliminado correctamente.");
                    } else {
                        System.out.println("⚠ No se encontró un usuario con ID " + id);
                    }
                }
            }

            // Redirigir al listado de usuarios actualizado
            response.sendRedirect("bienvenido.jsp?mensaje=Usuario eliminado");

        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            response.sendRedirect("listadoUsuarios.jsp?error=No se pudo eliminar el usuario");
        }
    }
}

