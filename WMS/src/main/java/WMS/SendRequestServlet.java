package WMS;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/submitRequest")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Limit file size to 5MB
public class SendRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Check if session exists and if 'userEmail' attribute is set
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            out.println("<script>alert('Please login first.'); window.location='index.jsp';</script>");
            return;
        }

        // Get the user's email from the session
        String userEmail = (String) session.getAttribute("userEmail"); // Get logged-in user's email

        // Get the user's UID from the database using the userEmail
        String uid = null;
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");

            // Query to get the user ID from the users table based on the userEmail
            String sql = "SELECT uid FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                uid = rs.getString("uid"); // Get the UID from the result
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error fetching user details: " + e.getMessage() + "'); window.location='sendrequest.jsp';</script>");
            return;
        }

        // If UID is not found, show an error and exit
        if (uid == null) {
            out.println("<script>alert('User not found. Please login again.'); window.location='index.jsp';</script>");
            return;
        }

        // Generate the request ID in the format: XX1234 (2 letters + 4 digits)
        String rid = generateRequestID();
        String wasteType = request.getParameter("wasteType");
        String locationType = request.getParameter("locationType");

        // Handle optional fields
        String landmark = request.getParameter("landmark");
        String area = request.getParameter("area");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");

        // Handle file upload
        Part filePart = request.getPart("wasteImage");
        InputStream imageStream = filePart.getInputStream();

        try {
            // Insert the data into the requests table
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");

            // SQL query to insert the request data
            String insertSql = "INSERT INTO requests (rid, uid, wasteType, wasteImage, locationType, landmark, area, city, district, state, pincode, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);

            // Set parameters for the insert query
            insertStmt.setString(1, rid);
            insertStmt.setString(2, uid); // Use UID instead of userEmail
            insertStmt.setString(3, wasteType);
            insertStmt.setBinaryStream(4, imageStream, (int) filePart.getSize());
            insertStmt.setString(5, locationType);
            insertStmt.setString(6, landmark);
            insertStmt.setString(7, area);
            insertStmt.setString(8, city);
            insertStmt.setString(9, district);
            insertStmt.setString(10, state);
            insertStmt.setString(11, pincode);
            insertStmt.setString(12, latitude.isEmpty() ? null : latitude);
            insertStmt.setString(13, longitude.isEmpty() ? null : longitude);

            int rowsInserted = insertStmt.executeUpdate();
            insertStmt.close();
            conn.close();

            if (rowsInserted > 0) {
                out.println("<script>alert('Request submitted successfully!'); window.location='usermain.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to submit request.'); window.location='sendrequest.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Database error: " + e.getMessage() + "'); window.location='sendrequest.jsp';</script>");
        }
    }

    // Method to generate the request ID in the format "XX1234"
    private String generateRequestID() {
        String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random rand = new Random();

        // Generate 2 random letters
        char letter1 = letters.charAt(rand.nextInt(letters.length()));
        char letter2 = letters.charAt(rand.nextInt(letters.length()));

        // Generate 4 random digits
        int digits = rand.nextInt(9000) + 1000; // Ensures 4 digits (1000-9999)

        return "" + letter1 + letter2 + digits;
    }
}