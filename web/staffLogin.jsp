<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fitness Hub - Staff Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }
        body {
            background: transparent;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/gym-bg.jpg');
            background-size: cover;
            background-position: center;
            overflow: hidden;
        }
        .login-container {
            width: 400px;
            background-color: rgba(255,255,255,0.95);
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
            border: 1px solid rgba(253,53,160,0.3);
        }
        .login-header {
            background: linear-gradient(135deg, rgba(253,53,160,1) 0%, rgba(184,58,255,1) 100%);
            padding: 8px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .login-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
            transform: rotate(30deg);
        }
        .login-header img {
            height: 70px;
            margin-bottom: 15px;
            position: relative;
            filter: drop-shadow(0 2px 5px rgba(0,0,0,0.2));
        }
        .login-header h2 {
            font-size: 28px;
            margin-bottom: 5px;
            font-weight: 800;
            position: relative;
        }
        .login-header p {
            font-size: 14px;
            opacity: 0.9;
            position: relative;
        }
        .login-body {
            padding: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 14px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: rgba(253,53,160,0.5);
            box-shadow: 0 0 0 3px rgba(253,53,160,0.1);
        }
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .remember-me {
            display: flex;
            align-items: center;
        }
        .remember-me input {
            margin-right: 8px;
            accent-color: rgba(253,53,160,1);
        }
        .forgot-password a {
            color: rgba(253,53,160,1);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
        }
        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, rgba(253,53,160,1) 0%, rgba(184,58,255,1) 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(253,53,160,0.3);
        }
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(253,53,160,0.4);
        }
        .login-btn:active {
            transform: translateY(0);
        }
        .error-message {
            color: #e74c3c;
            background-color: #fadbd8;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
        }
        .success-message {
            color: #27ae60;
            background-color: #d5f5e3;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
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
        .member-login-link {
            text-align: center;
            margin-top: 25px;
            color: #7f8c8d;
            font-size: 14px;
        }
        .member-login-link a {
            color: rgba(253,53,160,1);
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <img src="images/logo.png" alt="Fitness Hub Logo">
            <h2>FITNESS CONCEPT</h2>
            <p>Staff Portal</p>
        </div>
        
        <div class="login-body">
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> ${param.error}
                </div>
            <% } %>
            
            <% if (request.getParameter("logout") != null) { %>
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> You have been logged out successfully
                </div>
            <% } %>
            
            <form method="post" action="LoginServlet" onsubmit="return handleStaffLogin(this);">
                <div class="form-group">
                    <label for="email">Staff Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your staff email" required>
                </div>
                
                <div class="form-group password-container">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <span class="toggle-password" onclick="togglePasswordVisibility()">
                        <i class="fas fa-eye" id="eye-icon"></i>
                    </span>
                </div>
                
                <div class="remember-forgot">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                </div>
                
                <button type="submit" class="login-btn">Staff Login</button>
            </form>
            
            <div class="member-login-link">
                Member? <a href="fitnessLogin.jsp">Member Login</a>
            </div>
        </div>
    </div>

    <script>
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('email').focus();
        });
        

    </script>
</body>
</html>
