<%-- 
    Document   : editCustomer
    Created on : 22 Apr 2025, 00:17:11
    Author     : Hong Jie
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String customerId = request.getParameter("id");
    String name = "", phone = "", email = "";
    boolean customerExists = false;

    if (customerId != null && !customerId.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Fitness", "nbuser", "nbuser");

            String sql = "SELECT c.name, c.phone, c.email FROM customer c WHERE c.id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, customerId);
            rs = ps.executeQuery();

            if (rs.next()) {
                customerExists = true;
                name = rs.getString("name");
                phone = rs.getString("phone");
                email = rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            padding: 30px;
        }
        .container {
            background: #fff;
            border-radius: 10px;
            max-width: 600px;
            margin: auto;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        label {
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .readonly {
            background-color: #eee;
        }
        .button-row {
            display: flex;
            justify-content: space-between;
        }
        button {
            background-color: rgba(253,53,160,255);
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c0398e;
        }
    </style>
</head>
<body>
<div class="container">
    <% if (customerExists) { %>
        <h2>Edit Customer ID: <%= customerId %></h2>
        <form method="post" action="<%= request.getContextPath() %>/EditCustomerServlet" onsubmit="return validateChange()">

            <input type="hidden" name="id" value="<%= customerId %>">
            <input type="hidden" name="action" id="action" value="edit">

            <label>Name:</label>
            <input type="text" name="name" value="<%= name %>" class="readonly" readonly>

            <label>Phone:</label>
            <input type="text" name="phone" id="phone" value="<%= phone %>">

            <label>Email:</label>
            <input type="email" name="email" id="email" value="<%= email %>">

            <div class="button-row">
                <button type="submit">💾 Save Edit</button>
                <button type="button" onclick="submitDelete()">🗑️ Delete Customer</button>
                <button type="button" onclick="window.location.href='customer.jsp'">❌ Cancel</button>
            </div>
        </form>
    <% } else { %>
        <h2>Customer Not Found</h2>
        <p>No customer found with ID: <%= customerId %></p>
        <button onclick="window.location.href='customer.jsp'">🔙 Back</button>
    <% } %>
</div>

<script>
    let originalPhone = "<%= phone %>";
    let originalEmail = "<%= email %>";

    function validateChange() {
        const phone = document.getElementById("phone").value.trim();
        const email = document.getElementById("email").value.trim();

        if (phone === originalPhone && email === originalEmail) {
            alert("No changes detected.");
            return false;
        }
        return true;
    }

    function submitDelete() {
        if (confirm("Are you sure you want to delete this customer?")) {
            document.getElementById("action").value = "delete";
            document.forms[0].submit();
        }
    }
</script>
</body>
</html>


