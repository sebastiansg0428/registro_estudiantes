package com.mycompany.registro_estudiantes;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// BCrypt
import org.mindrot.jbcrypt.BCrypt;


public class iniciarSesionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Datos de conexión a la BD
    private String jdbcURL = "jdbc:mysql://localhost:3306/registro_estudiantes";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String passwordIngresada = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT contraseña FROM usuarios WHERE correo = ?")) {

                stmt.setString(1, correo);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String passwordBD = rs.getString("contraseña");

                    // Comparar con BCrypt
                    if (BCrypt.checkpw(passwordIngresada, passwordBD)) {
                        // ✅ Login correcto
                        HttpSession session = request.getSession();
                        session.setAttribute("usuario", correo);

                        response.sendRedirect(request.getContextPath() + "/bienvenido.jsp?msg=loginok");
                    } else {
                        // ❌ Contraseña incorrecta
                        response.sendRedirect(request.getContextPath() + "/index.jsp?error=passIncorrecta");
                    }
                } else {
                    // ❌ Usuario no encontrado
                    response.sendRedirect(request.getContextPath() + "/index.jsp?error=noExiste");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=sql");
        }
    }
}




