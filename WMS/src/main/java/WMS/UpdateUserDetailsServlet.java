package WMS;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/updateUserDetails")
public class UpdateUserDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // Get session and check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            out.println("<script>alert('Please login first.'); window.location='index.jsp';</script>");
            return;
        }

        // Fetch user input from the form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String mobile = request.getParameter("mobile");
        String state = request.getParameter("state");
        String district = request.getParameter("district");
        String pincode = request.getParameter("pincode");
        String dob = request.getParameter("dob");

        // Get user email from session
        String userEmail = (String) session.getAttribute("userEmail");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");

            // SQL query to update user details
            String updateSql = "UPDATE users SET first_name = ?, last_name = ?, mobile = ?, state = ?, district = ?, pincode = ?, dob = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(updateSql);
            
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, mobile);
            stmt.setString(4, state);
            stmt.setString(5, district);
            stmt.setString(6, pincode);
            stmt.setString(7, dob);
            stmt.setString(8, userEmail);
            
            int rowsUpdated = stmt.executeUpdate();
            stmt.close();
            conn.close();
            
            if (rowsUpdated > 0) {
                // After successful update, refresh the session with new data
                session.setAttribute("userFirstName", firstName);
                session.setAttribute("userLastName", lastName);
                session.setAttribute("userMobile", mobile);
                session.setAttribute("userState", state);
                session.setAttribute("userDistrict", district);
                session.setAttribute("userPincode", pincode);
                session.setAttribute("userDob", dob);

                out.println("<script>alert('Details updated successfully.'); window.location='accountDetails.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to update details.'); window.location='editDetails.jsp';</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error updating details: " + e.getMessage() + "'); window.location='editDetails.jsp';</script>");
        }
    }
}