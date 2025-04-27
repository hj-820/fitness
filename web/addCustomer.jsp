<%-- 
    Document   : addCustomer
    Created on : 21 Apr 2025, 22:41:08
    Author     : Hong Jie
--%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="domain.Customer" %> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"], input[type="email"], input[type="number"] {
            width: 100%; padding: 10px; margin-bottom: 20px;
            border: 1px solid #ccc; border-radius: 6px; font-size: 14px;
        }

        .submit-btn {
            background-color: rgba(253,53,160,255); color: #fff; border: none;
            padding: 12px; width: 100%; border-radius: 6px;
            font-size: 16px; cursor: pointer; font-weight: bold;
        }

        .submit-btn:hover { background-color: #e043a1; }

        .cancel-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 12px; width: 100%; border-radius: 6px;
            font-size: 16px; font-weight: bold;
        }

        .cancel-btn:hover { background-color: #c82333; }

        .back-link {
            display: block; text-align: center; margin-top: 15px;
            color: #3498db; text-decoration: none;
        }

        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add Customer</h2>
    <form action="AddCustomerServlet" method="post">
        
        <%
            Customer cust = (Customer) request.getAttribute("customer");
            if (cust == null) {
                cust = new Customer();
            }
        %>

        <label for="custName">Customer Name:</label>
        <input type="text" name="custName" id="custName" required
               value="<%= cust.getName() != null ? cust.getName() : "" %>">

        <label for="custEmail">Email:</label>
        <input type="email" name="custEmail" id="custEmail" required
               value="<%= cust.getEmail() != null ? cust.getEmail() : "" %>">

        <label for="custPhone">Phone:</label>
        <input type="text" name="custPhone" id="custPhone" required
               value="<%= cust.getPhone() != null ? cust.getPhone() : "" %>">

        <input type="submit" class="submit-btn" value="Add Customer">
    </form>

    <a class="back-link" href="customer.jsp">← Back to Customers</a>
</div>

</body>
</html>
