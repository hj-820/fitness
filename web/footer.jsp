<%-- 
    Document   : footer
    Created on : 22 Apr 2025, 16:00:54
    Author     : Hong Jie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style>
    .footer {
        background-color: #2c3e50;
        bottom:0;
        color: #ecf0f1;
        text-align: center;
        padding: 20px;
        font-size: 14px;
        width: 100%;
        box-shadow: 0 -2px 10px rgba(0,0,0,0.1);
        position :fixed;
    }
</style>
    </head>
    <body>

        <div class="footer">
            &copy; <%= java.time.Year.now() %> Fitness Concept. All rights reserved.
        </div>
    </body>
</html>
