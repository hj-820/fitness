<%-- 
    Document   : manageStaff
    Created on : 20 Apr 2025, 23:03:35
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, da.StaffDA, domain.Staff" %>
<jsp:include page="headerHome.jsp"/>

<%
    // Fetch all staff via DAO
    List<Staff> staffList = new ArrayList<Staff>();
    try {
        StaffDA staffDA = new StaffDA();
        staffList = staffDA.getAllRecords();  // you’ll need to add this method to StaffDA
        staffDA.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


<%
    String role = (String) session.getAttribute("userType"); // Replace with session.getAttribute("role") later if dynamic role
    boolean isManager = role.equalsIgnoreCase("Manager");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Staff</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial,sans-serif; }
        body { background-color: #f4f6f8; display: flex; flex-direction: column; height: 100vh; }
        .main-content { padding: 30px; flex: 1; background: #fff; margin: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; margin-bottom: 20px; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { padding: 12px 15px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #ecf0f1; color: #2c3e50; }
        .action-buttons { display: flex; justify-content: flex-start; gap: 15px; padding-left: 5px; }
        .btn { padding: 10px 20px; background-color: #3498db; color: #fff; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; }
        .btn:hover { background-color: #2980b9; }

        /* modal */
        .modal { display: none; position: fixed; z-index: 100; left:0; top:0; width:100%; height:100%; background: rgba(0,0,0,0.4); }
        .modal-content { background: #fff; margin: 10% auto; padding: 20px; width: 30%; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .modal-content h2 { margin-bottom: 15px; }
        .modal-content input[type="text"] { width:100%; padding:10px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px; }
        .modal-content input[type="submit"] { background:#3498db; color:#fff; border:none; padding:10px 15px; border-radius:6px; cursor:pointer; }
        .modal-content input[type="submit"]:hover { background:#2980b9; }
        .close { float:right; font-size:24px; font-weight:bold; cursor:pointer; color:#aaa; }
        .close:hover { color:#000; }
         .container {
                display: flex;
                flex: 1;
            }

            .sidebar {
                width: 220px;
                background-color: #2c3e50;
                padding: 20px;
                color: #fff;
            }

            .sidebar h1 {
                margin-bottom: 30px;
                font-size: 24px;
                text-align: center;
            }

            .sidebar ul {
                list-style: none;
            }

            .sidebar ul li {
                margin: 20px 0;
            }

            .sidebar ul li a {
                color: #ecf0f1;
                text-decoration: none;
                font-size: 18px;
                display: block;
                padding: 10px;
                border-radius: 5px;
                transition: background 0.3s;
            }

            .sidebar ul li a:hover {
                background-color: #34495e;
            }
    </style>
    <script>
        function openModal() {
            document.getElementById("editModal").style.display = "block";
        }
        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }
        window.onclick = e => {
            const m = document.getElementById("editModal");
            if (e.target === m) closeModal();
        }
    </script>
</head>
<body>
    
            <div class="container">
            <div class="sidebar">
                <h1 style="color:white;"><a href="Manager.jsp" style="color:white; text-decoration:none;"><%= isManager ? "Manager" : "Staff" %> Panel</a></h1>
                <ul>
                    <li><a href="customer.jsp">Customers</a></li>
                    <li><a href="product.jsp">Products</a></li>
                    <% if (isManager) { %>
                    <li><a href="manageStaff.jsp">Staff</a></li>
                    <li><a href="report.jsp">Reports</a></li>
                <% } %>
                </ul>
            </div>

<div class="main-content">
    <h1>Manage Staff</h1>
    <table>
        <tr>
            <th>Staff ID</th><th>Name</th><th>Phone</th><th>Email</th><th>Role</th><th>Salary (RM)</th>
        </tr>
        <% for (Staff s : staffList) { %>
        <tr>
            <td><%= s.getStaffId() %></td>
            <td><%= s.getStaffName() %></td>
            <td><%= s.getPhone() %></td>
            <td><%= s.getEmail() %></td>
            <td><%= s.getPosition() %></td>
            <td><%= String.format("%.2f", s.getSalary()) %></td>
        </tr>
        <% } %>
    </table>

    <div class="action-buttons">
        <a href="addStaff.jsp" class="btn">➕ Add Staff</a>
        <button class="btn" onclick="openModal()">✏️ Edit Staff</button>
    </div>
</div>

<!-- Edit Staff Modal -->
<div id="editModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2>Edit Staff</h2>
    <form action="editStaff.jsp" method="get">
      <label for="staffID">Enter Staff ID:</label>
      <input type="text" id="staffID" name="staffID" required>
      <input type="submit" value="Proceed to Edit">
    </form>
  </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>

