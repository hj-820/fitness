<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fitness Hub - Reset Password</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }
        body {
            background-color: transparent;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/gym-bg.jpg');
            background-size: cover;
            background-position: center;
        }
        .forgot-container {
            width: 400px;
            background-color: rgba(255,255,255,0.95);
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
            border: 1px solid rgba(253,53,160,0.3);
        }
        .forgot-header {
            background: linear-gradient(135deg, rgba(253,53,160,1) 0%, rgba(184,58,255,1) 100%);
            padding: 25px;
            color: white;
            text-align: center;
            position: relative;
        }
        .forgot-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
            transform: rotate(30deg);
        }
        .forgot-header h2 {
            font-size: 28px;
            margin-bottom: 5px;
            font-weight: 800;
            position: relative;
            text-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .forgot-body {
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
        .reset-btn {
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
        .reset-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(253,53,160,0.4);
        }
        .back-to-login {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
        }
        .back-to-login a {
            color: rgba(253,53,160,1);
            text-decoration: none;
            font-weight: 600;
        }
        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
        }
        .error-message {
            color: #e74c3c;
            background-color: #fadbd8;
            border-left: 4px solid #e74c3c;
        }
        .success-message {
            color: #27ae60;
            background-color: #d5f5e3;
            border-left: 4px solid #2ecc71;
        }
    </style>
</head>
<body>
<div class="forgot-container">
    <div class="forgot-header">
        <h2>Reset Your Password</h2>
        <p>Please enter your email and new password below</p>
    </div>

    <div class="forgot-body">
        <% if (request.getParameter("error") != null) { %>
            <div class="message error-message">
                <i class="fas fa-exclamation-circle"></i> ${param.error}
            </div>
        <% } %>

        <% if (request.getParameter("success") != null) { %>
            <div class="message success-message">
                <i class="fas fa-check-circle"></i> ${param.success}
            </div>
        <% } %>
        
        

        <form action="${pageContext.request.contextPath}/ResetServlet" method="post" id="forgotForm" onsubmit="return validatePassword();">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter your registered email" required>
            </div>

            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Re-enter New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password" required>
            </div>

            <button type="submit" class="reset-btn">Reset Password</button>
        </form>

        <div class="back-to-login">
            <a href="fitnessLogin.jsp"><i class="fas fa-arrow-left"></i> Back to Login</a>
        </div>
    </div>
</div>

<script>
    function validatePassword() {
        const pass1 = document.getElementById("newPassword").value;
        const pass2 = document.getElementById("confirmPassword").value;

        if (pass1 !== pass2) {
            alert("Passwords do not match.");
            return false;
        }
        return true;
    }
</script>
<% if (request.getAttribute("error") != null) { %>
    <div class="message error-message">
        <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
    </div>
<% } %>

<% if (request.getAttribute("success") != null) { %>
    <div class="message success-message">
        <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
    </div>
<% } %>


</body>
</html>