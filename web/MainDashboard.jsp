
<%@ include file="headerHome.jsp" %>
<%
    if (session.getAttribute("id") == null) {
        response.sendRedirect("fitnessLogin.jsp");
        return;
    }

    String fullName = (String) session.getAttribute("fullName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fitness Hub - Member Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #FF6B6B;
            --secondary-color: #4ECDC4;
            --dark-color: #292F36;
            --light-color: #F7FFF7;
        }
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            background: var(--light-color);
            height: 100vh;
            overflow: hidden; /* Optional: removes scrollbars if you want */
        }


        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            height: 100vh;
        }
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
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        header, footer {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 30px;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-profile {
            display: flex;
            align-items: center;
        }
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: var(--dark-color);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 20px;
            font-weight: bold;
        }
        .logout-btn {
            background-color: white;
            color: var(--primary-color);
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: var(--light-color);
        }
        .content {
            padding: 30px;
            background: white;
            flex: 1;
        }
    </style>
</head>
<body>

<div class="dashboard-container">

    <!-- Sidebar -->
    <div class="sidebar">
        <div>
            <div class="sidebar-header">
                <h2>FITNESS CONCEPT</h2>
                <p>Member Dashboard</p>
            </div>

            <div class="sidebar-nav">
                <div class="nav-item">
                    <i class="fas fa-user"></i> <a><a href="profile.jsp">Profile Management</a>
                </div>
                <div class="nav-item">
                    <i class="fas fa-shopping-cart"></i> <a><a href="purchaseHistory.jsp">Purchase History</a>
                </div>
            </div>
        </div>

    </div>

    <!-- Main Content -->
    <div class="main-content">


        <!-- Content -->
        <div class="content">
            <h1>Welcome back, <%= fullName %>!</h1>
            <p>Select an option from the sidebar to manage your profile or view your purchase history.</p>
        </div>

       
    </div>

</div>
<%@ include file="footer.jsp" %>
</body>
</html>
