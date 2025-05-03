package WMS;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = request.getParameter("rid");
        String newStatus = request.getParameter("status");

        String dbURL = "jdbc:mysql://localhost:3306/WMS";
        String dbUser = "root";
        String dbPassword = "abhi1234";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE requests SET status = ? WHERE rid = ?")) {
                stmt.setString(1, newStatus);
                stmt.setString(2, rid);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ Trigger success alert
        response.sendRedirect("adminmain?statusUpdate=success");
    }
}