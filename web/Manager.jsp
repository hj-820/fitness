<%-- 
    Document   : Manager
    Created on : 11 Apr 2025, 14:28:01
    Author     : Hong Jie
--%>


<%@ include file="headerHome.jsp" %>
<%

    String phone = (String) session.getAttribute("phone");
    String email = (String) session.getAttribute("email");
    String position = (String) session.getAttribute("userType");

    if (position == null) {
        response.sendRedirect("staffLogin.jsp");
        return;
    }

    boolean isManager = position.equalsIgnoreCase("Manager");
%>
<%
    String updated = request.getParameter("updated");
    if ("true".equals(updated)) {
%>
    <script>alert("Profile updated successfully!");</script>
<% } %>

<!DOCTYPE html>
<html>
<head>
    <title><%= isManager ? "Manager" : "Staff" %> Panel</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

    .sidebar h2 {
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

    .main-content {
      flex: 1;
      padding: 30px;
    }

    .main-content h1 {
      font-size: 26px;
      margin-bottom: 15px;
    }

    .main-content .greeting {
      font-size: 20px;
      color: #333;
      margin-bottom: 10px;
    }

    .profile-section {
      display: flex;
      gap: 30px;
      flex-wrap: wrap;
      align-items: flex-start;
    }

    .manager-info {
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      flex: 1;
      min-width: 300px;
    }

    .manager-info label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
    }

    .manager-info input {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .manager-info button {
      margin-top: 20px;
      padding: 10px 20px;
      background-color: #1abc9c;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .manager-info button:hover {
      background-color: #16a085;
    }





     
    </style>
</head>
<body>


    <div class="container">
        <div class="sidebar">
            <h2 style="color:white;"><a href="Manager.jsp" style="color:white; text-decoration:none;"><%= isManager ? "Manager" : "Staff" %> Panel</a></h2>
            <ul>
                <li><a href="customer.jsp">Customers</a></li>
                <li><a href="product.jsp">Products</a></li>
                <% if (isManager) { %>
                    <li><a href="manageStaff.jsp">Staff</a></li>
                    <li><a href="report.jsp">Reports</a></li>
                <% } %>
                
            </ul>
        </div>

        <div class="main-content">
            <div class="greeting">Hi, <%= name %></div>
            <h1><%= isManager ? "Manager" : "Staff" %> Profile</h1>
            <div class="profile-section">

                <!-- Profile Form -->
                <div class="manager-info">
                    <form action="MakeChangesServlet" method="post">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" value="<%= name %>" readonly>

                        <label for="phone">Phone:</label>
                        <input type="text" id="phone" name="phone" value="<%= phone %>">

                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= email %>">

                        <label for="position">Position:</label>
                        <input type="text" id="position" name="position" value="<%= position %>" readonly>

                        <button type="submit">Save Changes</button>
                    </form>
                </div>



            </div>
        </div>
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
