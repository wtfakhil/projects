<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    // Check if user is logged in
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("index.jsp?error=Please%20login%20first");
        return;
    }
    
    // Fetch the user's email from session
    String userEmail = (String) sessionObj.getAttribute("userEmail");
    
    String firstName = "";
    String lastName = "";
    String mobile = "";
    String state = "";
    String district = "";
    String pincode = "";
    String dob = "";
    
    // Get the user details from the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");
        
        String sql = "SELECT first_name, last_name, mobile, state, district, pincode, dob FROM users WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, userEmail);
        
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            firstName = rs.getString("first_name");
            lastName = rs.getString("last_name");
            mobile = rs.getString("mobile");
            state = rs.getString("state");
            district = rs.getString("district");
            pincode = rs.getString("pincode");
            dob = rs.getString("dob");
        }
        
        rs.close();
        stmt.close();
        conn.close();
        
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Account Details</title>
    <link rel="stylesheet" type="text/css" href="resources/css/usermain.css">
    <link rel="stylesheet" type="text/css" href="resources/css/editDetails.css">
    
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">
            <a href="usermain.jsp">GRIT Menu</a>
        </div>
        <ul class="nav-links">
            <li><a href="sendrequest.jsp">Send Request</a></li>
            <li><a href="viewRequests">My Requests</a></li>
            <li><a href="accountDetails.jsp">Account</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h2>Edit Account Details</h2>

        <form action="updateUserDetails" method="post">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="<%= firstName %>" required><br><br>
            
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="<%= lastName %>" required><br><br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= userEmail %>" readonly><br><br>
            
            <label for="mobile">Phone Number:</label>
            <input type="text" id="mobile" name="mobile" value="<%= mobile %>" pattern="^[6-9][0-9]{9}$" required><br><br>
            
            <label for="state">State:</label>
            <input type="text" id="state" name="state" value="<%= state %>" required><br><br>
            
            <label for="district">District:</label>
            <input type="text" id="district" name="district" value="<%= district %>" required><br><br>
            
            <label for="pincode">Pincode:</label>
            <input type="text" id="pincode" name="pincode" value="<%= pincode %>" pattern="^[0-9]{6}$" required><br><br>
            
            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" value="<%= dob %>" required><br><br>

            <button type="submit">Update Details</button>
        </form>
    </div>

</body>
</html>