package WMS;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/viewRequests")
public class ViewRequestsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get session and user email
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            out.println("<script>alert('Please login first.'); window.location='index.jsp';</script>");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String uid = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");

            // Query to fetch the user's UID based on their email
            String sql = "SELECT uid FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                uid = rs.getString("uid"); // Get the UID
            }

            rs.close();
            stmt.close();

            if (uid == null) {
                out.println("<script>alert('User not found.'); window.location='index.jsp';</script>");
                return;
            }

            // Fetch requests for the user based on UID
            String requestSql = "SELECT * FROM requests WHERE uid = ?";
            PreparedStatement requestStmt = conn.prepareStatement(requestSql);
            requestStmt.setString(1, uid);
            ResultSet requestRs = requestStmt.executeQuery();

            // Create a list to store requests
            List<Request> requests = new ArrayList<>();

            // Process the result set and populate the requests list
            while (requestRs.next()) {
                String rid = requestRs.getString("rid");
                String wasteType = requestRs.getString("wasteType");
                String location = requestRs.getString("landmark") + ", " + requestRs.getString("area") + ", " +
                        requestRs.getString("city") + ", " + requestRs.getString("district") + ", " +
                        requestRs.getString("state") + ", " + requestRs.getString("pincode");
                String status= requestRs.getString("status");

                // Add request to the list
                requests.add(new Request(rid, wasteType, location, status));
            }

            // Close resources
            requestRs.close();
            requestStmt.close();
            conn.close();

            // Pass the list of requests to the JSP page
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("viewRequests.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error fetching requests: " + e.getMessage() + "'); window.location='usermain.jsp';</script>");
        }
    }

    // Inner class to represent a request
    public static class Request {
        private String rid;
        private String wasteType;
        private String location;
        private String status;

        // Constructor
        public Request(String rid, String wasteType, String location, String status) {
            this.rid = rid;
            this.wasteType = wasteType;
            this.location = location;
            this.status = status;
        }

        // Getters
        public String getRid() {
            return rid;
        }

        public String getWasteType() {
            return wasteType;
        }

        public String getLocation() {
            return location;
        }

        public String getStatus() {
            return status;
        }
    }
}