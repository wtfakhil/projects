<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
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
    <title>User Dashboard</title>
    <link rel="stylesheet" type="text/css" href="resources/css/usermain.css">
</head>
<body>

   <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">
            <a href="usermain.jsp">GRIT Home</a>
             <img src="resources/images/grit.png" alt="GRIT Logo" class="logo-glow">
        </div>
        <ul class="nav-links">
            <li><a href="logout.jsp" class="logout-btn">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h2>Welcome to Your Dashboard</h2>
        <p>Hello, <%= sessionObj.getAttribute("userEmail") %>!</p>

        <div class="button-group">
            <a href="sendrequest.jsp" class="main-btn">Send Request</a>
            <a href="viewRequests" class="main-btn">My Requests</a>
            <a href="accountDetails" class="main-btn">Account Details</a>
        </div>
    </div>

</body>
</html>