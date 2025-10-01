package com.mycompany.registro_estudiantes;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegistrarUsuarioServlet")
public class RegistrarUsuarioServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Datos de conexión a la BD
    private String jdbcURL = "jdbc:mysql://localhost:3306/registro_estudiantes";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {

                // 1️⃣ Verificar si el usuario ya existe
                PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM usuarios WHERE correo = ?");
                checkStmt.setString(1, correo);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Usuario ya registrado
                    response.sendRedirect(request.getContextPath() + "/registro.jsp?error=usuarioExistente");
                    return; // Detener ejecución
                }

                // 2️⃣ Insertar nuevo usuario con contraseña encriptada
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                PreparedStatement insertStmt = conn.prepareStatement(
                        "INSERT INTO usuarios (correo, contraseña) VALUES (?, ?)");
                insertStmt.setString(1, correo);
                insertStmt.setString(2, hashedPassword);

                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    // Registro exitoso
                    response.sendRedirect(request.getContextPath() + "/registro.jsp?msg=success");
                } else {
                    // Fallo al insertar usuario
                    response.sendRedirect(request.getContextPath() + "/registro.jsp?error=registro");
                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/registro.jsp?error=sql");
        }
    }
}
