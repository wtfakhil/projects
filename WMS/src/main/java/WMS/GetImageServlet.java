package WMS;


import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getImage")
public class GetImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = request.getParameter("rid");
        if (rid == null || rid.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing request ID.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");

            String sql = "SELECT wasteImage FROM requests WHERE rid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, rid);
            rs = stmt.executeQuery();

            if (rs.next()) {
                byte[] imageData = rs.getBytes("wasteImage");
                if (imageData != null) {
                    response.setContentType("image/jpeg");
                    OutputStream out = response.getOutputStream();
                    out.write(imageData);
                    out.flush();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Request ID not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}