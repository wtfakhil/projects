<%@ page import="java.util.List" %>
<%@ page import="WMS.RequestData" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="resources/css/adminmain.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin-top: 60px;
            padding: 0;
            background-color: #ecf0f1;
        }

        .dashboard-container {
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            padding:50px;
            text-align: center;
            color: black;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .navbar {
            background-color: #2c3e50;
            padding: 10px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar .logo a {
            color: lightgreen;
            text-decoration: none;
            font-size: 20px;
            font-weight: bold;
        }

        .navbar .nav-links {
            display: flex;
            align-items: center;
            list-style: none;
        }

        .navbar .nav-links li a {
            color: white;
            margin-left: 15px;
            text-decoration: none;
            font-weight: 500;
        }

        .logo-glow {
    
    width: 70px; /* Ensure it's a perfect square for a proper circle */
    margin-left:350px;
    margin-right: 550px;
    border-radius: 50%; /* Makes it a perfect circle */
    animation: glow 2s infinite alternate;
    object-fit: cover; /* Ensures image fits nicely inside the circle */
}


        @keyframes glow {
            0% { filter: drop-shadow(0 0 4px #00c6ff); }
            100% { filter: drop-shadow(0 0 12px #00c6ff); }
        }

        .request-table button {
            background: linear-gradient(135deg, #6dd5fa, #2980b9);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
            box-shadow: 0 4px 12px rgba(41, 128, 185, 0.4);
        }

        .request-table button:hover {
            transform: scale(1.07);
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            box-shadow: 0 0 12px #00c6ff, 0 0 20px #0072ff;
        }

        .request-table button:active {
            transform: scale(0.97);
            box-shadow: 0 0 10px #00c6ff inset;
        }

        .request-table tr:hover {
            background-color: #34495e;
            transform: translateY(-2px);
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            animation: rowHoverGlow 0.4s ease-out;
            color: white;
        }

        @keyframes rowHoverGlow {
            0% {
                background-color: #34495e;
                box-shadow: 0px 0px 10px #8e44ad, 0px 0px 20px #3498db;
            }
            100% {
                background-color: #3d566e;
                box-shadow: 0px 0px 20px #8e44ad, 0px 0px 30px #3498db;
            }
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .request-table {
                width: 95%;
            }

            .request-table th, .request-table td {
                font-size: 14px;
            }
        }

        .thumbnail {
            width: 100px;
            height: 100px;
            cursor: pointer;
            border: 1px solid #ccc;
            object-fit: cover;
        }

        .popup {
            display: none;
            position: fixed;
            z-index: 999;
            padding-top: 60px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.8);
        }

        .popup-content {
            display: block;
            margin: auto;
            max-width: 90%;
            max-height: 80%;
        }

        .close {
            position: absolute;
            top: 30px;
            right: 50px;
            color: white;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%
    String statusUpdate = request.getParameter("statusUpdate");
    if ("success".equals(statusUpdate)) {
%>
<script>
    alert("Status updated successfully!");
</script>
<%
    }
%>

<nav class="navbar">
    <div class="logo">
        <a href="adminmain.jsp">GRIT[A]: Green Response For Immediate Trash Admin</a>
    </div>
    <ul class="nav-links">
        <img src="resources/images/grit.png" alt="GRIT Logo" class="logo-glow">
        <li><a href="adminlogout.jsp">Logout</a></li>
    </ul>
</nav>

<div class="dashboard-container">
    <h2>Admin Dashboard - Waste Management</h2>

    <form id="searchForm" method="GET" action="adminmain">
        <label for="searchBy">Search by:</label>
        <select name="searchBy" id="searchBy">
            <option value="rid" <%= "rid".equals(request.getParameter("searchBy")) ? "selected" : "" %>>Request ID</option>
            <option value="state" <%= "state".equals(request.getParameter("searchBy")) ? "selected" : "" %>>State</option>
            <option value="pincode" <%= "pincode".equals(request.getParameter("searchBy")) ? "selected" : "" %>>Pincode</option>
        </select>
        <input type="text" id="searchValue" name="searchValue" placeholder="Enter search term"
               value="<%= request.getParameter("searchValue") != null ? request.getParameter("searchValue") : "" %>">
        <button type="submit">Search</button>
        <br><br>
        <button type="submit" name="listAll" value="true">List All Requests</button>
    </form>
    <br>

    <table class="request-table">
        <thead>
            <tr>
                <th>Request ID</th>
                <th>User ID</th>
                <th>Waste Type</th>
                <th>Location</th>
                <th>Google Maps</th>
                <th>Waste Image</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<RequestData> requests = (List<RequestData>) request.getAttribute("requests");
                if (requests != null && !requests.isEmpty()) {
                    for (RequestData req : requests) {
            %>
            <tr>
                <td><%= req.getRid() %></td>
                <td><%= req.getUid() %></td>
                <td><%= req.getWasteType() %></td>
                <td><%= req.getArea() %>, <%= req.getCity() %>, <%= req.getState() %> - <%= req.getPincode() %></td>
                <td>
                    <%
                        if (req.getLatitude() == null || req.getLongitude() == null) {
                    %>
                        No location entered
                    <%
                        } else {
                    %>
                        <a href="https://www.google.com/maps?q=<%= req.getLatitude() %>,<%= req.getLongitude() %>" target="_blank">View on Map</a>
                    <%
                        }
                    %>
                </td>
                <td>
                    <img src="getImage?rid=<%= req.getRid() %>" alt="Waste Image" class="thumbnail" onclick="showPopup(this.src)">
                </td>
                <td>
                    <form method="POST" action="UpdateStatusServlet">
                        <input type="hidden" name="rid" value="<%= req.getRid() %>">
                        <select name="status">
                            <option value="Pending" <%= "Pending".equals(req.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="In Progress" <%= "In Progress".equals(req.getStatus()) ? "selected" : "" %>>In Progress</option>
                            <option value="Rejected" <%= "Rejected".equals(req.getStatus()) ? "selected" : "" %>>Rejected</option>
                            <option value="Escalated to Authorities" <%= "Escalated to Authorities".equals(req.getStatus()) ? "selected" : "" %>>Escalated to Authorities</option>
                            <option value="Completed" <%= "Completed".equals(req.getStatus()) ? "selected" : "" %>>Completed</option>
                        </select>
                        <button type="submit">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">No matching records found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<!-- Image Popup Modal -->
<div id="imagePopup" class="popup">
    <span class="close" onclick="closePopup()">&times;</span>
    <img class="popup-content" id="popupImage">
</div>

<script>
    function showPopup(src) {
        const popup = document.getElementById("imagePopup");
        const popupImg = document.getElementById("popupImage");
        popup.style.display = "block";
        popupImg.src = src;
    }

    function closePopup() {
        document.getElementById("imagePopup").style.display = "none";
    }

    window.onclick = function(event) {
        const popup = document.getElementById("imagePopup");
        if (event.target === popup) {
            popup.style.display = "none";
        }
    };
</script>

</body>
</html>
