<%-- 
    Document   : headerHome
    Created on : 28 Apr 2025, 01:07:42
    Author     : Hong Jie
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("userType"); // staff / manager
    String name = (String) session.getAttribute("fullName"); // optional
%>

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

        /* Header container */
        .header-container {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        /* Top Bar */
        .top-bar {
            background-color: rgba(253,53,160,255);
            color: white;
            padding: 15px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            z-index: 1000;
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
            width: 45px;
            height: 45px;
        }

        /* Navigation Bar - now properly under top bar */
        .nav-bar {
            background-color: #FFE3F1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 0;
            width: 100%;
        }

        .nav-bar a {
            color: black;
            text-decoration: none;
            margin: 0 20px;
            font-weight: bold;
            font-size: 16px;
            transition: color 0.3s;
        }

        .nav-bar a:hover {
            text-decoration: underline;
            color: rgba(253,53,160,255);
        }

        /* Dropdown Menu */
        .dropdown {
            position: relative;
            display: inline-block;
            z-index: 1001;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1002;
            right: 0;
            top: 100%;
            border-radius: 4px;
            overflow: hidden;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
        }

        .dropdown-content a:hover {
            background-color: #FFE3F1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Login Popup */
        #loginPopup {
            display: none; 
            position: fixed; 
            top: 55%; 
            left: 50%; 
            transform: translate(-50%, -50%);
            width: 90%; 
            max-width: 800px;
            height: 100%; 
            z-index: 1003;
            overflow: auto;
            

        }

        #loginPopup iframe {
            width: 100%; 
            height: calc(100% - 50px);
            border: none;
        }

        #loginPopup button {
            position: absolute; 
            top: 50px; 
            right: 130px;
            background: #ff6b6b; 
            color: white; 
            border: none; 
            padding: 8px 12px; 
            cursor: pointer; 
            border-radius: 5px;
            z-index: 1004;
        }

        /* Overlay */
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .top-bar {
                flex-direction: column;
                padding: 15px;
            }

            .logo-section {
                margin-bottom: 15px;
            }

            .right-section {
                width: 100%;
                justify-content: space-between;
            }

            .search-bar input {
                width: 180px;
            }

            .nav-bar {
                flex-wrap: wrap;
                padding: 10px 0;
            }

            .nav-bar a {
                margin: 0 10px;
                font-size: 14px;
            }

            #loginPopup {
                width: 95%;
                height: 90%;
            }
        }
    </style>
</head>

<body>
    <div class="header-container">
        <!-- Top Bar -->
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

                <div class="dropdown">
                    <img src="images/logout.png" alt="Login" class="login-icon">
                    <div class="dropdown-content">
                        <% if (role == null) { %>
                            <a href="#" onclick="openPopup()">Login</a>
                        <% } else { %>
                            <% if (role == "customer") { %>
                            <a href="MainDashboard.jsp">Profile</a>
                            <% } else { %>
                            <a href="Manager.jsp">Profile</a>
                            <% } %>
                            <a href="LogoutServlet">Logout</a>
                        <% } %>
                    </div>
                </div>

                <img src="images/cart.png" alt="Cart" class="icon">
            </div>
        </div> <!-- End of top-bar -->

        <!-- Navigation Bar - Now properly under top bar -->
        <div class="nav-bar">
            <a href="home1.jsp">HOME</a>
            <a href="home.jsp">SHOP PRODUCTS</a>
            <a href="aboutUs.jsp">ABOUT US</a>
        </div>
    </div> <!-- End of header-container -->
    
    <!-- Rest of your content -->
    
    <div id="loginPopup">
        <iframe src="fitnessLogin.jsp"></iframe>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="overlay"></div>
    
    <%
        String logoutMessage = request.getParameter("logout");
        if ("success".equals(logoutMessage)) {
    %>
    <script>
        alert("You have successfully logged out.");
    </script>
    <%
        }
    %>
</body>
<script>


    
    function openPopup() {
        document.getElementById('loginPopup').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }
    
    function closePopup() {
        document.getElementById('loginPopup').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }


    window.addEventListener('message', function(e) {
        if (e.data === 'STAFF_LOGIN_SUCCESS') {
            closePopup(); // ✅ first close
            setTimeout(function() {
                window.location.href = 'Manager.jsp'; // ✅ then redirect
            }, 300); // delay to allow popup close to be visible
        } else if (e.data === 'LOGIN_SUCCESS') {
            closePopup();
            setTimeout(function() {
                window.location.href = 'MainDashboard.jsp';
            }, 300);
        }
    });
</script>

</html>
