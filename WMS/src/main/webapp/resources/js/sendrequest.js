document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("manualLoc").addEventListener("click", function () {
        toggleLocation('manual');
    });

    document.getElementById("autoLoc").addEventListener("click", function () {
        toggleLocation('auto');
    });

    document.getElementById("getLocationBtn").addEventListener("click", function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError);
        } else {
            document.getElementById("locationStatus").innerHTML = "<span style='color: red;'>Geolocation not supported.</span>";
        }
    });
});

function toggleLocation(type) {
    if (type === 'manual') {
        document.getElementById("manualLocation").style.display = "block";
        document.getElementById("autoLocation").style.display = "none";
        document.getElementById("area").style.display = "block";
        document.getElementById("landmark").style.display = "block";
        document.getElementById("locationStatus").innerHTML = ""; // Clear status when switching
    } else {
        document.getElementById("manualLocation").style.display = "none";
        document.getElementById("autoLocation").style.display = "block";
        document.getElementById("area").style.display = "none";
		document.getElementById("area").removeAttribute("required");
        document.getElementById("landmark").style.display = "none";
    }
}

function showPosition(position) {
    document.getElementById("latitude").value = position.coords.latitude;
    document.getElementById("longitude").value = position.coords.longitude;
    document.getElementById("locationStatus").innerHTML = "<span style='color: green;'>Location captured successfully!</span>";
}

function showError(error) {
    let errorMessage = "Failed to fetch location!";
    switch (error.code) {
        case error.PERMISSION_DENIED:
            errorMessage = "Permission denied for location access. Please allow location services.";
            break;
        case error.POSITION_UNAVAILABLE:
            errorMessage = "Location information unavailable. Try again later.";
            break;
        case error.TIMEOUT:
            errorMessage = "Location request timed out. Ensure GPS is enabled.";
            break;
        case error.UNKNOWN_ERROR:
            errorMessage = "An unknown error occurred.";
            break;
    }
    console.error("Location Error:", error);
    document.getElementById("locationStatus").innerHTML = "<span style='color: red;'>" + errorMessage + "</span>";
}

// Populate districts based on state
function populateDistricts() {
    const state = document.getElementById("state").value;
    const districtDropdown = document.getElementById("district");
    districtDropdown.innerHTML = '<option value="">Select District</option>'; // Reset

    let districts = [];
    if (state === "Andhra Pradesh") {
        districts = ["Visakhapatnam", "Vijayawada", "Guntur", "Tirupati"];
	} else if (state === "Maharashtra") {
		districts = ["Mumbai", "Pune", "Nagpur", "Nashik"];	
    } else if (state === "Karnataka") {
        districts = ["Bangalore", "Mysore","Mangalore", "Hubli"];
    } else if (state === "Tamil Nadu") {
        districts = ["Chennai", "Coimbatore", "Madurai", "Tiruchirappalli"];
    } else if 		(state === "Telangana") {
		districts = ["Hyderabad", "Warangal", "Nizamabad", "Karimnagar"];
	}

    districts.forEach(district => {
        const option = document.createElement("option");
        option.value = district;
        option.textContent = district;
        districtDropdown.appendChild(option);
    });
}