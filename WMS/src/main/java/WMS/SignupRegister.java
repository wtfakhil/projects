package WMS;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet("/register")
public class SignupRegister extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Get form data from request
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String dob = request.getParameter("dob");
        String state = request.getParameter("state");
        String district = request.getParameter("district");
        String pincode = request.getParameter("pincode");

        // Generate a UUID for user ID
        String userId = UUID.randomUUID().toString();

        // JDBC Connection and Insert Query
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS","root","abhi1234");

            // Prepare SQL Insert Query
            String sql = "INSERT INTO users (uid, first_name, last_name, email, mobile, password_hash, dob, state, district, pincode, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, firstName);
            stmt.setString(3, lastName);
            stmt.setString(4, email);
            stmt.setString(5, mobile);
            stmt.setString(6, password);
            stmt.setString(7, dob);
            stmt.setString(8, state);
            stmt.setString(9, district);
            stmt.setString(10, pincode);

            // Execute Update
            int rowsInserted = stmt.executeUpdate();

            // PrintWriter for response
            PrintWriter pw = response.getWriter();
            response.setContentType("text/html");

            if (rowsInserted > 0) {
                pw.println("<html><body>");
                pw.println("<h2 style='color:green;'>Registration Successful!</h2>");
                pw.println("<p><a href='index.jsp'>Go to Home Page</a></p>");
                pw.println("</body></html>");
            } else {
                pw.println("<html><body>");
                pw.println("<h2 style='color:red;'>Registration Failed!</h2>");
                pw.println("<p><a href='index.jsp'>Go to Home Page</a></p>");
                pw.println("</body></html>");
            }

            // Close resources
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter pw = response.getWriter();
            response.setContentType("text/html");
            pw.println("<html><body>");
            pw.println("<h2 style='color:red;'>Database Error! Please try again.</h2>");
            pw.println("<p><a href='index.jsp'>Go to Home Page</a></p>");
            pw.println("</body></html>");
        }
    }
}