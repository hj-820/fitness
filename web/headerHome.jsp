<%-- 
    Document   : headerHome
    Created on : 28 Apr 2025, 01:07:42
    Author     : Hong Jie
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.setAttribute("position", "Manager");
    String position = (String) session.getAttribute("position");
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
    <title>Fitness Shop</title>
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

        .navbar {
            background-color: rgba(253,53,160,255);
            display: flex;
            align-items: center;
            padding: 10px 20px;
            color: white;
        }

        .navbar img.logo {
            height: 70px;
            margin-right: 20px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            padding: 8px 12px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .nav-links a:hover {
            background-color: #d832a2;
        }

        .search-login-cart {
            display: flex;
            align-items: center;
            margin-left: auto;
            gap: 15px;
        }

        .search-box {
            position: relative;
        }

        .search-box input[type="text"] {
            padding: 8px 12px;
            border: none;
            border-radius: 20px;
            width: 200px;
        }

        .icon {
            height: 40px;
            width: 40px;
            cursor: pointer;
        }

        .main-content {
            flex: 1;
            padding: 30px;
            background-color: #ffffff;
            overflow-y: auto;
        }

    </style>
</head>
<body>
    <div class="navbar">
        <img src="images/logo.png" alt="Fitness Logo" class="logo">

        <div class="nav-links">
            <a href="home1.jsp">Home</a>
            <a href="home.jsp">Shop Products</a>
            <a href="#">About Us</a>
        </div>

        <div class="search-login-cart">
            <div class="search-box">
                <input type="text" placeholder="Search...">
            </div>
            <a href="login.jsp"><img src="images/login.png" alt="Login" class="icon"></a>
            <a href="cart.jsp"><img src="images/cart.png" alt="Cart" class="icon"></a>
        </div>
    </div>

    <div class="main-content">
        <!-- Your page content here -->
    </div>

</body>
</html>
