<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("isLoggedIn") == null) {
        response.sendRedirect("index.jsp?error=Please%20login%20first");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Details</title>
    <link rel="stylesheet" type="text/css" href="resources/css/usermain.css">
    <link rel="stylesheet" type="text/css" href="resources/css/accountDetails.css">
    
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
            <li><a href="#">Account</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h2>User Account Details</h2>

        <!-- User Information -->
        <div class="user-details">
            <p><strong>First Name:</strong> <%= request.getAttribute("firstName") %></p>
            <p><strong>Last Name:</strong> <%= request.getAttribute("lastName") %></p>
            <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
            <p><strong>Date of Birth:</strong> <%= request.getAttribute("dob") %></p>
        </div>

        <!-- Edit and Change Password options -->
        <div class="options">
            <a href="editDetails.jsp" class="button">Edit Details</a>
            <a href="changePassword.jsp" class="button">Change Password</a>
        </div>
    </div>

</body>
</html>