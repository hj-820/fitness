<%@page import="domain.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="headerHome.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fitness Hub - Profile</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --dark-color: #2c3e50;
            --primary-color: rgba(253,53,160,1);
            --secondary-color: rgba(184,58,255,1);
            --hover-bg: rgba(255, 255, 255, 0.08);
            --active-bg: rgba(255, 255, 255, 0.15);
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f5f5f5;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        /* Updated Sidebar to match purchaseHistory.jsp */
        .sidebar {
            background-color: #222;
            color: white;
            padding: 20px 0;
            width: 250px;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            position: sticky;
            top: 0;
        }

        .sidebar-header {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-nav {
            margin-top: 30px;
        }

        .nav-item {
            padding: 15px 25px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            color: white;
        }

        .nav-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .nav-item a {
            color: white;
            text-decoration: none;
        }

        .nav-item.active {
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 3px solid var(--primary-color);
        }

        .main-content {
            flex-grow: 1;
            padding: 30px;
        }
        
        .profile-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            padding-bottom:100px;
            width: 100%;
            max-width: none; /* or increase this value */
            margin: 0 auto;
        }
        
        .profile-header {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .profile-header h2 {
            color: var(--dark-color);
            margin-bottom: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .password-container {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #7f8c8d;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(253,53,160,0.3);
        }
    </style>
</head>
<body>
    <div style="display: flex;">
    <div class="sidebar">
            <div>
                <div class="sidebar-header">
                    <h2>FITNESS CONCEPT</h2>
                    <p>Member Dashboard</p>
                </div>

                <div class="sidebar-nav">
                    <div class="nav-item active">
                        <i class="fas fa-user"></i> <a href="profile.jsp">Profile Management</a>
                    </div>
                    <div class="nav-item">
                        <i class="fas fa-shopping-cart"></i> <a href="purchaseHistory.jsp">Purchase History</a>
                    </div>
                </div>
            </div>
        </div>


    <div class="main-content">
        <div class="profile-container">
            <div class="profile-header">
                <h2>Edit Profile</h2>
                <p>Update your personal information</p>
            </div>
            
            <% if (request.getParameter("error") != null) { %>
                <div style="color: red; margin-bottom: 20px;">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>
            
            <% if (request.getParameter("success") != null) { %>
                <div style="color: green; margin-bottom: 20px;">
                    <%= request.getParameter("success") %>
                </div>
            <% } %>
            
            <form action="UpdateProfileServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" value="<%= (session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "") %>" readonly>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" value="<%= (session.getAttribute("phone") != null ? session.getAttribute("phone") : "") %>">
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" value="<%= (session.getAttribute("email") != null ? session.getAttribute("email") : "") %>">
                </div>
                
                <div class="form-group password-container">
                    <label for="currentPassword">Current Password (required for changes)</label>
                    <input type="password" id="currentPassword" name="currentPassword" required>
                    <span class="toggle-password" onclick="togglePasswordVisibility('currentPassword')">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
                
                <div class="form-group password-container">
                    <label for="newPassword">New Password (leave blank to keep current)</label>
                    <input type="password" id="newPassword" name="newPassword">
                    <span class="toggle-password" onclick="togglePasswordVisibility('newPassword')">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
                
                <div class="form-group password-container">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword">
                    <span class="toggle-password" onclick="togglePasswordVisibility('confirmPassword')">
                        <i class="fas fa-eye"></i>
                    </span>
                </div>
                
                <button type="submit" class="btn-submit">Update Profile</button>
            </form>
        </div>
    </div>
                
<%@ include file="footer.jsp" %>

    <script>
        function togglePasswordVisibility(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = field.nextElementSibling.querySelector('i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
        
        function validateForm() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                alert("New password and confirmation don't match!");
                return false;
            }
            
            return confirm("Are you sure you want to update your profile information?");
        }
    </script>
</body>
</html>