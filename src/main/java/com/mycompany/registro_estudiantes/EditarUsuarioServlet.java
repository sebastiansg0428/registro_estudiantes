package com.mycompany.registro_estudiantes;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditarUsuarioServlet")
public class EditarUsuarioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        String url = "jdbc:mysql://localhost:3306/registro_estudiantes";
        String user = "root";
        String pass = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pass);

            String sql = "UPDATE usuarios SET correo=?, contraseña=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            ps.setInt(3, id);

            int filas = ps.executeUpdate();
            ps.close();
            conn.close();

            if (filas > 0) {
                response.sendRedirect("bienvenido.jsp?msg=actualizado");
            } else {
                response.sendRedirect("EditarUsuario.jsp?id=" + id + "&error=registro");
            }
        } catch (Exception e) {
            response.sendRedirect("EditarUsuario.jsp?id=" + id + "&error=sql");
        }
    }
}
