<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Send Request</title>
    <link rel="stylesheet" type="text/css" href="resources/css/sendrequest.css">
    <link rel="stylesheet" type="text/css" href="resources/css/usermain.css">
    <script src="resources/js/sendrequest.js" defer></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places"></script>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <a href="usermain.jsp">GRIT Menu</a>
        </div>
        <div class="nav-links">
            <ul class="nav-links">
               
                <li><a href="sendrequest.jsp" class="active">Send Request</a></li>
                <li><a href="viewRequests">My Requests</a></li>
                <li><a href="accountDetails">Account</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <h2>Submit Waste Collection Request</h2>
        <form action="submitRequest" method="post" enctype="multipart/form-data">
            <label>Type of Waste</label>
            <select name="wasteType" required>
                <option value="Plastic">Plastic</option>
                <option value="Organic">Organic</option>
                <option value="E-Waste">E-Waste</option>
                <option value="Metal">Metal</option>
                 <option value="Others">Others</option>
            </select>

            <label>Upload Photo (Max: 5 Mb)</label>
            <input type="file" name="wasteImage" accept="image/*" required>
            
            <label>Location</label>
            <div class="location-options">
                <input type="radio" name="locationType" value="manual" id="manualLoc" checked onclick="toggleLocation('manual')">
                <label for="manualLoc">Manual Entry</label>
                <input type="radio" name="locationType" value="auto" id="autoLoc" onclick="toggleLocation('auto')">
                <label for="autoLoc">Use My Location</label>
                <sub id="locationStatus" style="display:block; color:red;"></sub>
            </div>
            
            <div id="manualLocation">
                <input type="text" name="landmark" id="landmark" placeholder="Landmark (Optional)">
                <input type="text" name="area" id="area" placeholder="Area" required>
            </div>
             <div id="autoLocation" style="display:none;">
                <button type="button" id="getLocationBtn">Use My Location</button>
                <input type="hidden" name="latitude" id="latitude">
                <input type="hidden" name="longitude" id="longitude">
                <div id="map"></div>
            </div>

            <div id="commonLocation">
                <input type="text" name="city" id="city" placeholder="City" required>

                <label for="state">State</label>
                <label for="state">State</label>
                <select name="state" id="state" required onchange="populateDistricts()">
                    <option value="">Select State</option>
                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                    <option value="Maharashtra">Maharashtra</option>
                    <option value="Karnataka">Karnataka</option>
                    <option value="Tamil Nadu">Tamil Nadu</option>
                    <option value="Telangana">Telangana</option>
                </select>

                <label for="district">District</label>
                <select name="district" id="district" required>
                    <option value="">Select District</option>
                </select>

                <input type="text" name="pincode" id="pincode" placeholder="Pincode" pattern="[0-9]{6}" required>
            </div>

           
            
            <button type="submit">Submit Request</button>
        </form>
    </div>
</body>
</html>