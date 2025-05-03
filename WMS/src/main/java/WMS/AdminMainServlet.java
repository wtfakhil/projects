package WMS;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/adminmain")
public class AdminMainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.sendRedirect("index.jsp?error=unauthorized");
            return;
        }

        String searchBy = request.getParameter("searchBy");
        String searchValue = request.getParameter("searchValue");
        String listAll = request.getParameter("listAll");

        List<RequestData> requests = new ArrayList<>();

        String dbURL = "jdbc:mysql://localhost:3306/WMS";
        String dbUser = "root";
        String dbPassword = "abhi1234";

        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM requests");
        boolean hasCondition = false;

        if ("true".equals(listAll)) {
            // Show all requests
            // No WHERE clause needed
        } else if (searchBy != null && searchValue != null && !searchValue.trim().isEmpty()) {
            if ("rid".equals(searchBy) || "state".equals(searchBy) || "pincode".equals(searchBy)) {
                queryBuilder.append(" WHERE ").append(searchBy).append(" LIKE ?");
                hasCondition = true;
            }
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement(queryBuilder.toString())) {

                if (hasCondition) {
                    stmt.setString(1, "%" + searchValue + "%");
                }

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        requests.add(new RequestData(
                                rs.getString("rid"),
                                rs.getString("uid"),
                                rs.getString("wasteType"),
                                rs.getString("wasteImage"),
                                rs.getString("locationType"),
                                rs.getString("landmark"),
                                rs.getString("area"),
                                rs.getString("city"),
                                rs.getString("district"),
                                rs.getString("state"),
                                rs.getString("pincode"),
                                rs.getString("latitude"),
                                rs.getString("longitude"),
                                rs.getString("status")
                        ));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("requests", requests);
        request.getRequestDispatcher("adminmain.jsp").forward(request, response);
    }
}