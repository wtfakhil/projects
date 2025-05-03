package WMS;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@SuppressWarnings("serial")
@WebServlet("/updatePassword")  // The URL pattern to access the servlet
public class UpdatePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.sendRedirect("index.jsp?error=Please%20login%20first");
            return;
        }
        
        // Fetch user's email from session
        String userEmail = (String) session.getAttribute("userEmail");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if passwords match
        if (newPassword.equals(confirmPassword)) {
            try {
                // Connect to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");
                
                // Prepare the SQL statement to update the password
                String sql = "UPDATE users SET password_hash = ? WHERE email = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, newPassword); // Store password as it is
                stmt.setString(2, userEmail);
                
                // Execute the update
                int rowsUpdated = stmt.executeUpdate();
                
                // Close resources
                stmt.close();
                conn.close();

                // Prepare PrintWriter for response
                PrintWriter out = response.getWriter();
                
                if (rowsUpdated > 0) {
                    // Password updated successfully
                    out.println("<script>alert('Password updated successfully!'); window.location='usermain.jsp';</script>");
                } else {
                    // Password update failed
                    out.println("<script>alert('Failed to update password.'); window.location='changePassword.jsp';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Database error
                PrintWriter out = response.getWriter();
                out.println("<script>alert('Database error: " + e.getMessage() + "'); window.location='changePassword.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
                // General error
                PrintWriter out = response.getWriter();
                out.println("<script>alert('An unexpected error occurred.'); window.location='changePassword.jsp';</script>");
            }
        } else {
            // Passwords do not match
            PrintWriter out = response.getWriter();
            out.println("<script>alert('Passwords do not match. Please try again.'); window.location='changePassword.jsp';</script>");
        }
    }
}