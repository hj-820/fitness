<%-- 
    Document   : headerHome
    Created on : 28 Apr 2025, 01:07:42
    Author     : Hong Jie
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fitness Concept</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f4f6f8;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Black Top Bar */
        .top-bar {
            background-color: rgba(253,53,160,255);
            color: white;
            padding: 15px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo-section {
            display: flex;
            align-items: center;
        }

        .logo-section img {
            height: 80px;
            margin-right: 20px;
        }

        .logo-text {
            border-left: 1px solid white;
            padding-left: 20px;
            font-size: 18px;
        }

        .logo-text strong {
            display: block;
            font-size: 20px;
        }

        .right-section {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 6px;
            overflow: hidden;
        }

        .search-bar input {
            border: none;
            padding: 10px;
            outline: none;
            width: 250px;
        }

        .search-bar button {
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 8px;
        }

        .icon {
            width: 28px;
            height: 28px;
            cursor: pointer;
        }

        .login-icon {
            width: 45px; /* Bigger login icon */
            height: 45px;
        }

        /* Orange Navigation Menu */
        .nav-bar {
            background-color: #FFE3F1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 0;
        }

        .nav-bar a {
            color: black;
            text-decoration: none;
            margin: 0 20px;
            font-weight: bold;
            font-size: 16px;
        }

        .nav-bar a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="top-bar">
        <div class="logo-section">
            <img src="images/logo.png" alt="Fitness Logo">
            <div class="logo-text">
                <strong>The Largest</strong>
                Fitness Specialist Chain Store<br>
                since 2025
            </div>
        </div>

        <div class="right-section">
            <div class="search-bar">
                <input type="text" placeholder="Search entire store here...">
                <button><img src="https://static-00.iconduck.com/assets.00/search-icon-2048x2048-cmujl7en.png" alt="Search" class="icon"></button>
            </div>
            <img src="images/logout.png" alt="Login" class="login-icon">
            <img src="images/cart.png" alt="Cart" class="icon">
        </div>
    </div>

    <div class="nav-bar">
        <a href="home1.jsp">HOME</a>
        <a href="home.jsp">SHOP PRODUCTS</a>
        <a href="aboutUs.jsp">ABOUT US</a>
    </div>
    
    <div id="loginPopup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
     width: 80%; height: 80%; background: transparent;  z-index: 1000;  overflow: hidden;">
    <iframe src="fitnessLogin.jsp" style="width: 100%; height: 100%; border: none;"></iframe>
    <button onclick="closePopup()" style="position: absolute; top: 10px; right: 300px; background: #ff6b6b; color: white; border: none; padding: 8px 12px; cursor: pointer; border-radius: 5px;">Close</button>
</div>

<!-- Background overlay -->
<div id="overlay" style="display: none; position: fixed; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.5); z-index: 999;"></div>

</body>
<script>
    const loginIcon = document.querySelector('.login-icon');
    const popup = document.getElementById('loginPopup');
    const overlay = document.getElementById('overlay');

    loginIcon.addEventListener('click', function() {
        popup.style.display = 'block';
        overlay.style.display = 'block';
    });

    function closePopup() {
        popup.style.display = 'none';
        overlay.style.display = 'none';
    }
</script>

</html>
