<%-- 
    Document   : addStaff
    Created on : 23 Apr 2025, 23:01:09
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="domain.Staff" %>

<%
    Staff staff = (Staff) request.getAttribute("staff");
    if (staff == null) {
        staff = new Staff();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Staff</title>
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
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
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

        input[type="text"],
        input[type="email"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            background-color: #fff;
        }

        select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23333" height="18" viewBox="0 0 24 24" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
        }

        select:focus, input:focus {
            outline: none;
            border-color: #fd35a0;
            box-shadow: 0 0 3px #fd35a0;
        }

        .submit-btn {
            background-color: rgba(253,53,160,255);
            color: #fff;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
        }

        .submit-btn:hover {
            background-color: #e043a1;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #3498db;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Staff</h2>
    <form action="${pageContext.request.contextPath}/AddStaffServlet" method="post">
        <label for="staffName">Staff Name:</label>
        <input type="text" name="staffName" id="staffName" required
               value="<%= staff.getStaffName() != null ? staff.getStaffName() : "" %>">

        <label for="phone">Phone Number:</label>
        <input type="text" name="phone" id="phone"
               value="<%= staff.getPhone() != null ? staff.getPhone() : "" %>">

        <label for="email">Email Address:</label>
        <input type="email" name="email" id="email" required
               value="<%= staff.getEmail() != null ? staff.getEmail() : "" %>">

        <label for="position">Position:</label>
        <select name="position" id="position" required>
            <option value="" disabled <%= staff.getPosition()==null?"selected":"" %>>Select Position</option>
            <option value="Staff"   <%= "Staff".equalsIgnoreCase(staff.getPosition())?"selected":"" %>>Staff</option>
            <option value="Manager" <%= "Manager".equalsIgnoreCase(staff.getPosition())?"selected":"" %>>Manager</option>
        </select>

        <label for="salary">Salary (RM):</label>
        <input type="number" name="salary" id="salary" step="0.01" min="0"
               value="<%= staff.getSalary()!=0 ? staff.getSalary() : "" %>">

        <input type="submit" class="submit-btn" value="Add Staff">
    </form>
    <a class="back-link" href="manageStaff.jsp">← Back to Staffs</a>
</div>

</body>
</html>

