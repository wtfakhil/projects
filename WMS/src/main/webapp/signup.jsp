<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - E-Swachha Track</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Correct CSS path -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signup.css?v=1">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="resources/js/script.js" defer></script> <!-- External JS -->
</head>
<body>

    <div class="signup-container">
    <h2>Sign Up</h2>
    <form action="register" method="post" onsubmit="return validateForm()">
        <!-- Name Row -->
        <div class="row">
            <div class="col">
                <label>First Name</label>
                <input type="text" name="firstName" required>
            </div>
            
            <div class="col">
                <label>Last Name</label>
                <input type="text" name="lastName" required>
            </div>
            
        </div>

            <!-- Email & Mobile -->
        <label>Email Address</label>
        <input type="email" name="email" required>

        <label>Mobile Number</label>
        <input type="text" name="mobile" pattern="[6-9][0-9]{9}" title="Enter a valid 10-digit mobile number" required>

        <!-- Password & Strength Indicator -->
        <label>Password</label>
        <input type="password" id="password" name="password" required>
        <span id="strengthMessage"></span>

        <label>Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>

        <!-- Date of Birth -->
        <label>Date of Birth</label>
        <input type="date" name="dob" required>

            <!-- State & District Dropdowns -->
            <label>State</label>
            <select id="state" name="state" required>
                <option value="">Select State</option>
                <option value="Andhra Pradesh">Andhra Pradesh</option>
                <option value="Telangana">Telangana</option>
                <option value="Karnataka">Karnataka</option>
                <option value="Maharashtra">Maharashtra</option>
                <option value="Tamil Nadu">Tamil Nadu</option>
                <!-- Add all Indian states -->
            </select>

            <label>District</label>
            <select id="district" name="district" required>
                <option value="">Select District</option>
            </select>

            <!-- Pincode -->
            <label>Pincode</label>
            <input type="text" id="pincode" name="pincode" pattern="[0-9]{6}" title="Enter a valid 6-digit Pincode" required>
				<br>
            <!-- Submit Button -->
            <div class="signup-button">
            	<button type="submit">Sign Up</button>
            </div>
        </form>
       </div>
    

</body>
</html>