# Waste Monitoring and Management System

This web application is designed to improve waste management by providing a platform for citizens to report waste and for municipal officers to manage waste disposal[cite: 62, 63, 64].

## Overview

The system uses web technologies such as JSP, JDBC, MySQL, HTML, CSS, and JavaScript to enable efficient waste reporting and disposal[cite: 62]. It aims to create cleaner and healthier surroundings by facilitating real-time waste identification and organized cleanup processes[cite: 63, 64]. The platform offers login access for both municipal officers and users[cite: 65]. Users can upload photos and location details of waste, which are then relayed to the authorities for action[cite: 66, 67].

## Features

* **User Reporting:** Citizens can log in, upload photos, and provide location details of waste[cite: 66].
* **Real-time Tracking:** Municipal officers can identify and locate waste in real-time[cite: 64].
* **Efficient Communication:** The system relays waste information to the relevant authorities for prompt action[cite: 67].
* **User-friendly Interface:** The platform is designed to be accessible to users with limited technical knowledge[cite: 68].
* **Improved Waste Management:** The system streamlines waste disposal efforts and promotes community participation in maintaining a clean environment[cite: 69].

## Files Included

### Java Servlets and Classes

* **AccountDetailsServlet.java:** Handles fetching and displaying user account details.
* **AdminLogin.java:** Implements login functionality for administrative users.
* **AdminMainServlet.java:** Serves as the main servlet for the admin interface, managing requests.
* **GetImageServlet.java:** Retrieves and serves image data.
* **LoginServlet.java:** Handles login functionality for regular users.
* **RequestData.java:** Defines the structure for request-related data.
* **SendRequestServlet.java:** Handles the submission of user requests, including image uploads.
* **SignupRegister.java:** Implements user registration and signup.
* **UpdatePassword.java:** Allows users to update their passwords.
* **UpdateStatusServlet.java:** Updates the status of waste disposal requests.

### HTML Files

* **Index.html:** Main entry point for user login/registration.
* **MCD.html:** (Potentially a placeholder or specific page within a user flow - needs context from usage).
* **Yes.html:** (Potentially an intermediate page in a user flow - needs context from usage).

### Configuration

* **web.xml:** Deployment descriptor for the web application.

## Database

The application uses a MySQL database to store user information, waste reports, and other data[cite: 62].

## Technologies Used

* JSP
* JDBC
* MySQL
* HTML
* CSS
* JavaScript [cite: 62]

## Existing System Limitations

The existing waste management systems often rely on manual reporting, leading to:

* Delays in response[cite: 70, 71].
* Inefficient tracking of waste sites[cite: 71].
* Minimal public participation[cite: 72].
* Challenges in waste segregation[cite: 73].
* Inefficiencies in waste removal due to fixed schedules[cite: 74].

## Proposed System Advantages

This system offers improvements over existing systems by:

* Enabling easy waste reporting through a web-based platform[cite: 75, 76].
* Providing real-time tracking of waste[cite: 77].
* Enhancing community engagement[cite: 78].
* Improving waste segregation[cite: 79].
* Optimizing waste collection routes and response times[cite: 80].

## How to Run

1.  **Database Setup:** Create a MySQL database named "WMS" and configure the connection details in the Java files.
2.  **Build the Application:** Compile the Java files and package the application into a WAR file.
3.  **Deploy:** Deploy the WAR file to a servlet container (e.g., Tomcat).
4.  **Access:** Access the application through a web browser.

**Note:** The HTML files `MCD.html` and `Yes.html` appear to be unrelated to the core waste management functionality and might be part of a different application or test.
