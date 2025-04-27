<%-- 
    Document   : editStaff
    Created on : 23 Apr 2025, 20:12:11
    Author     : Hong Jie
--%>

<%@ page import="java.sql.*, da.StaffDA, domain.Staff" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String id = request.getParameter("staffID");
    String name = "", phone = "", email = "", password = "", position = "";
    double salary = 0.0;
    boolean found = false;
    Staff staff = null;

    if (id != null && !id.isEmpty()) {
        try {
            StaffDA staffDA = new StaffDA();
            staff = staffDA.getRecord(id);

            if (staff != null) {
                found = true;
                name = staff.getStaffName();
                phone = staff.getPhone();
                email = staff.getEmail();
                password = staff.getPassword();
                position = staff.getPosition();
                salary = staff.getSalary();
            }
            staffDA.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Staff</title>
 <style>
        .form-container {
            width: 500px;
            margin: 30px auto;
            padding: 20px;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button, .button-link {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            border: none;
        }
        .save-btn {
            background-color: #3498db;
            color: white;
        }
        .save-btn:hover {
            background-color: #2980b9;
        }
        .back-btn {
            background-color: #7f8c8d;
            color: white;
        }
        .back-btn:hover {
            background-color: #636e72;
        }
        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }
        .delete-btn:hover {
            background-color: #c0392b;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            gap: 10px;
        }
    </style>
</head>
<body>

<% if (!found) { %>
    <h2 style="text-align:center;">Staff with ID <%= id %> not found.</h2>
<% } else { %>
    <div class="form-container">
        <form action="EditStaffServlet" method="post">
            <input type="hidden" name="staffID" value="<%= id %>">

            <label>Staff Name</label>
            <input type="text" value="<%= name %>" readonly>

            <label>Password</label>
            <input type="text" name="password" value="<%= password %>" required>

            <label>Contact Number</label>
            <input type="text" name="phone" value="<%= phone %>" pattern="01[0-9]{8,9}" title="Enter a valid Malaysian phone number" required>

            <label>Email</label>
            <input type="email" name="email" value="<%= email %>" required>

            <label>Position</label>
            <input type="text" name="position" value="<%= position %>" required>

            <label>Salary (RM)</label>
            <input type="number" name="salary" value="<%= salary %>" step="0.01" min="0" required>

            <div class="btn-group">
                <button type="submit" name="action" value="update" class="save-btn">💾 Save Changes</button>
                <a href="manageStaff.jsp" class="button-link back-btn">🔙 Back</a>
                <button type="submit" name="action" value="delete" class="delete-btn" onclick="return confirmDelete();">🗑️ Delete Staff</button>
            </div>
        </form>
    </div>
<% } %>

<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this Staff?");
    }
</script>

</body>
</html>


