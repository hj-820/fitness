<%-- 
    Document   : Staff
    Created on : 11 Apr 2025, 14:45:28
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get session attributes
    String name = (String) session.getAttribute("name");
    String phone = (String) session.getAttribute("phone");
    String email = (String) session.getAttribute("email");
    String position = (String) session.getAttribute("position");


%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Panel</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>


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

    

        <div class="main-content">
            <div class="greeting">Hi, <%= name %></div>
            <h1>Staff Profile</h1>
            <div class="profile-section">

                <!-- Left: Profile Form -->
                <div class="manager-info">
                    <form action="MakeChangesServlet.java" method="post">
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

                <!-- Right: Profile Picture -->
                <div class="profile-pic">
                    <img src="images/profile.jpg" alt="Staff Profile Picture">
                    <caption><%= name %></caption>
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

