package WMS;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");

            // Check if user exists
            String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Successful login -> Create session
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);  // Store email in session
                session.setAttribute("isLoggedIn", true);  // Set a flag

                response.sendRedirect("usermain.jsp");
            } else {
                // Login failed -> Redirect to index with error
                response.sendRedirect("index.jsp?error=invalid");
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=invalid");
        }
    }
}