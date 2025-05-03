<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Random" %>

<%
    // Check if user is logged in
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("index.jsp?error=Please%20login%20first");
        return;
    }

    // Fetch the user's email from session
    String userEmail = (String) sessionObj.getAttribute("userEmail");
    String mobile = "";
    String otp = "";
    String message = "";

    // Get the user's mobile number from the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WMS", "root", "abhi1234");
        
        String sql = "SELECT mobile FROM users WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, userEmail);
        
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            mobile = rs.getString("mobile");
        }
        
        rs.close();
        stmt.close();
        conn.close();
        
    } catch (Exception e) {
        e.printStackTrace();
    }

    // OTP generation logic
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String enteredMobile = request.getParameter("mobile");

        if (enteredMobile != null && enteredMobile.equals(mobile)) {
            Random rand = new Random();
            otp = String.format("%04d", rand.nextInt(10000)); // Generate 4 digit OTP
            message = "Your OTP is: <sub style='color: darkgreen;'>" + otp + "</sub>";
            sessionObj.setAttribute("generatedOtp", otp); // Store OTP in session
        } else if (enteredMobile != null) {
            message = "Mobile number does not match!";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link rel="stylesheet" type="text/css" href="resources/css/usermain.css">
     <link rel="stylesheet" type="text/css" href="resources/css/changePassword.css">
    

    <script>
        // Function to validate OTP in real-time
        function validateOtp() {
            var enteredOtp = document.getElementById("otp").value;
            var generatedOtp = "<%= otp %>"; // Retrieve the generated OTP from session
            var submitButton = document.getElementById("submitBtn");

            // Enable or disable submit button based on OTP validation
            if (enteredOtp === generatedOtp) {
                submitButton.disabled = false; // Enable the submit button
            } else {
                submitButton.disabled = true; // Disable the submit button
            }
        }
    </script>
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
        <h2>Change Password</h2>
        
        <!-- Mobile Number and OTP Generation Form -->
        <form action="changePassword.jsp" method="post">
            <label for="mobile">Enter Mobile Number:</label>
            <input type="text" id="mobile" name="mobile" pattern="^[6-9][0-9]{9}$" required><br><br>
            
            <button type="submit">Generate OTP</button>
        </form>
        
        <!-- OTP Display -->
        <div class="message">
            <%= message %>
        </div>

        <!-- If OTP was generated, show the OTP input and new password fields -->
        <% if (otp != null && !otp.isEmpty()) { %>
        <form action="updatePassword" method="post">
            <label for="otp">Enter OTP:</label>
            <input type="text" id="otp" name="otp" required oninput="validateOtp()"><br><br>
            
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br><br>

            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>

            <button type="submit" id="submitBtn" disabled>Change Password</button>
        </form>
        <% } %>
    </div>

</body>
</html>