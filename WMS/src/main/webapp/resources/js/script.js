// Password Strength Checker
document.getElementById("password").addEventListener("keyup", function() {
    var password = this.value;
    var strengthMessage = document.getElementById("strengthMessage");

    if (password.length < 6) {
        strengthMessage.innerHTML = "Weak Password";
        strengthMessage.style.color = "red";
    } else if (password.match(/[A-Z]/) && password.match(/[0-9]/) && password.match(/[@$!%*?&]/)) {
        strengthMessage.innerHTML = "Strong Password";
        strengthMessage.style.color = "green";
    } else {
        strengthMessage.innerHTML = "Medium Strength Password";
        strengthMessage.style.color = "orange";
    }
});

// Districts based on State Selection
document.getElementById("state").addEventListener("change", function() {
    var state = this.value;
    var district = document.getElementById("district");
    district.innerHTML = "<option value=''>Select District</option>";

    var districtsByState = {
        "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur", "Tirupati"],
        "Telangana": ["Hyderabad", "Warangal", "Nizamabad", "Karimnagar"],
        "Karnataka": ["Bangalore", "Mysore", "Mangalore", "Hubli"],
        "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik"],
        "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai", "Tiruchirappalli"]
        // Add more states and districts
    };

    if (state in districtsByState) {
        districtsByState[state].forEach(function(dist) {
            var option = document.createElement("option");
            option.value = dist;
            option.text = dist;
            district.appendChild(option);
        });
    }
});

// Form Validation
function validateForm() {
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return false;
    }
    return true;
}