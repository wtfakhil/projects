<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="WMS.ViewRequestsServlet.Request" %> <!-- Correct package path -->
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
    <title>Your Requests</title>
    <link rel="stylesheet" type="text/css" href="resources/css/usermain.css">
      <link rel="stylesheet" type="text/css" href="resources/css/viewRequests.css">
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
            <li><a href="accountDetails">Account</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h2>Your Requests</h2>
        <table class="request-table">
            <thead>
                <tr>
                    <th>Request ID</th>
                    <th>Waste Type</th>
                    <th>Location</th>
                    <th>Status</th>
                    
                </tr>
            </thead>
            <tbody>
                <%-- Iterate through the requests list passed from the servlet --%>
                <%
                    List<Request> requests = (List<Request>) request.getAttribute("requests");
                    if (requests != null) {
                        for (Request req : requests) {
                %>
                <tr>
                    <td><%= req.getRid() %></td>
                    <td><%= req.getWasteType() %></td>
                    <td><%= req.getLocation() %></td>
                    <td><%= req.getStatus() %></td>
                   
                </tr>
                <%
                        }
                    } else {
                        out.println("<tr><td colspan='5'>No requests found.</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>