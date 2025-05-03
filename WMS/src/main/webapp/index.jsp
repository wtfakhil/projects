<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to G R I T</title>
    <link rel="stylesheet" type="text/css" href="resources/css/style.css">
  
    
</head>
<body>

    <div class="container-box">
        <!-- Left Side - Welcome Message -->
       <div class="left-box">
    <video autoplay muted loop  class="bg-video">
        <source src="resources/videos/index stock.mp4" type="video/mp4">
        
    </video>

    <div class="text-content">
        <h1>Welcome to<br> G R I T</h1>
        <p class="grit-subtitle">Green Response for Immediate Trash<br>  <br> <br> All Rights Reserved <br>@SVUCE</p>
    </div>
</div>

        <!-- Right Side - Login Form -->
        <div class="right-box">
            <div class="login-form">
              <img src="resources/images/grit.png" alt="GRIT Logo" class="logo-glow">
                <h2>Login</h2>
                <form action="login" method="post">
                    <input type="email" name="email" placeholder="Email Address" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Sign In</button>
                </form>

                <!-- Error Message for Wrong Credentials -->
                <% String error = request.getParameter("error");
                   if (error != null && error.equals("invalid")) { %>
                    <p class="error-text" style="color: red;font-size: 8px;">Email or password is incorrect.</p>
                <% } %>

                <div class="signup-text">
                    Not a user yet? <a href="signup.jsp">Sign up here</a>
                </div>
            </div>
        </div>
    </div>
        
    

</body>
</html>