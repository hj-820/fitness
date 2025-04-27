<%-- 
    Document   : header
    Created on : 22 Apr 2025, 15:15:07
    Author     : Hong Jie
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Temporary simulation for Manager access
    session.setAttribute("position", "Manager");

    String position = (String) session.getAttribute("position");
    boolean isManager = position != null && position.equalsIgnoreCase("Manager");

    String updated = request.getParameter("updated");
    if ("true".equals(updated)) {
%>
    <script>alert("Profile updated successfully!");</script>
<%
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #f4f6f8;
                display: flex;
                flex-direction: column;
                height: 100vh;
            }

            .header {
                background-color: rgba(253,53,160,255);
                padding: 15px 30px;
                color: white;
                display: flex;
                align-items: center;
            }

            .header img {
                height: 100px;
                margin-right: 20px;
            }

            .header-text {
                font-size: 18px;
            }

            .container {
                display: flex;
                flex: 1;
            }

            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                padding: 20px;
                color: #fff;
            }

            .sidebar h1 {
                margin-bottom: 30px;
                font-size: 24px;
                text-align: center;
            }

            .sidebar ul {
                list-style: none;
            }

            .sidebar ul li {
                margin: 20px 0;
            }

            .sidebar ul li a {
                color: #ecf0f1;
                text-decoration: none;
                font-size: 18px;
                display: block;
                padding: 10px;
                border-radius: 5px;
                transition: background 0.3s;
            }

            .sidebar ul li a:hover {
                background-color: #34495e;
            }

            .profile-pic {
                max-width: 200px;
                text-align: center;
            }

            .profile-pic img {
                width: 100%;
                border-radius: 50%;
                border: 3px solid #1abc9c;
            }

            .profile-pic caption {
                margin-top: 10px;
                font-weight: bold;
                color: #555;
            }

            .user-menu {
                margin-left: auto;
                position: relative;
                cursor: pointer;
            }

            .login-icon {
                height: 40px;
                width: 85px;
                border-radius: 50%;
            }

            .dropdown {
                display: none;
                position: absolute;
                right: 0;
                top: 80px;
                background-color: white;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.2);
                z-index: 999;
            }

            .dropdown a {
                display: block;
                padding: 10px 15px;
                text-decoration: none;
                color: #333;
                white-space: nowrap;
            }

            .dropdown a:hover {
                background-color: #f1f1f1;
            }
            
            .main-content {
                flex: 1;
                padding: 30px;
                background-color: #ffffff;
                overflow-y: auto;
            }

            .main-content h1 {
                margin-bottom: 20px;
                font-size: 28px;
                color: #333;
            }

            .main-content table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            .main-content th, .main-content td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }

            .main-content th {
                background-color: #ecf0f1;
            }

            .add-link {
                display: inline-block;
                margin-top: 15px;
                padding: 10px 20px;
                background-color: rgba(253,53,160,255);
                color: white;
                text-decoration: none;
                border-radius: 6px;
                transition: background-color 0.3s;
            }

            .add-link:hover {
                background-color: #d832a2;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <img src="images/logo.png" alt="Fitness Logo">
            <div class="header-text">
                <strong>The Largest Fitness Specialist Chain Store</strong><br>
                since 2025
            </div>
            <div class="user-menu" onclick="toggleDropdown()">
                <img src="images/logout.png" alt="Login Icon" class="login-icon">
                <div class="dropdown" id="userDropdown">
                    <a href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="sidebar">
                <h1><%= isManager ? "Manager" : "Staff" %> Panel</h1>
                <ul>
                    <li><a href="customer.jsp">Customers</a></li>
                    <li><a href="product.jsp">Products</a></li>
                    <% if (isManager) { %>
                    <li><a href="manageStaff.jsp">Staff</a></li>
                    <li><a href="report.jsp">Reports</a></li>
                <% } %>
                </ul>
            </div>
        

        <script>
            function toggleDropdown() {
                const dropdown = document.getElementById('userDropdown');
                dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            }

            document.addEventListener('click', function(e) {
                const menu = document.querySelector('.user-menu');
                const dropdown = document.getElementById('userDropdown');
                if (!menu.contains(e.target)) {
                    dropdown.style.display = 'none';
                }
            });

            function confirmChanges() {
                return confirm("Are you sure you want to make these changes?");
            }
        </script>
    </body>
</html>