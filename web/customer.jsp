<%-- 
    Document   : customer
    Created on : 11 Apr 2025, 21:14:02
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, da.CustomerDA, da.PurchaseDA, domain.Customer, domain.Purchase,da.ProductDA,domain.Product" %>
<jsp:include page="headerHome.jsp"/>

<%
  CustomerDA customerDA = new CustomerDA();
  PurchaseDA purchaseDA = new PurchaseDA(); 
  List<Customer> customers = customerDA.getAllCustomers();
%>

<%
    String role = (String) session.getAttribute("userType"); // Replace with session.getAttribute("role") later if dynamic role
    boolean isManager = role.equalsIgnoreCase("Manager");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f4f6f8;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        .header {
            background-color: rgba(253,53,160,255);
            padding: 15px 30px;
            color: white;
            display: flex;
            align-items: center;
        }

        .header img {
            height: 100px;
            margin-right: 20px;
        }

        .header-text {
            font-size: 18px;
        }

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
        




        .main-content {
            padding: 30px;
            padding-bottom:70px;
            flex: 1;
            background-color: #fff;
            margin: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        table th, table td {
            padding: 12px 15px;
            border: 1px solid #ccc;
            text-align: left;
        }

        table th {
            background-color: #ecf0f1;
            color: #2c3e50;
        }

        .purchase-history {
            margin-top: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-left: 4px solid rgba(253,53,160,255);
            border-radius: 6px;
        }
        
        .modal {
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 30px;
            border: 1px solid #888;
            width: 40%;
            border-radius: 10px;
            position: relative;
        }

        .close {
            color: #aaa;
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }
        
        .add-button {
            padding: 10px 20px;
            background-color: #2ecc71;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }

        .add-button:hover {
            background-color: #27ae60;
        }

        .edit-button {
            padding: 10px 15px;
            background-color: #34495e;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .edit-button:hover {
            background-color: #2c3e50;
        }
        
        .purchase-history {
            list-style: disc inside;
            margin: 0;
            padding: 0;
        }
        
        .purchase-history li {
            margin-bottom: 4px;
        }
        
        .action-buttons {
            margin-top: 20px;
        }
    </style>
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
        <h1>Customer Records</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Purchase History</th>
            </tr>
            <% for (Customer c : customers) {
                List<Purchase> history = purchaseDA.getPurchasesByCustomerId(c.getCustomerId());
            %>
            <tr>
                <td><%= c.getCustomerId() %></td>
                <td><%= c.getName() %></td>
                <td><%= c.getPhone() %></td>
                <td><%= c.getEmail() %></td>
                <td>
                    <% if (history.isEmpty()) { %>
                        <em>No purchases</em>
                    <% } else { %>
                        <ul class="purchase-history">
                            <% for (Purchase p : history) { 
                            ProductDA productDA = new ProductDA();
                            Product product = productDA.getRecord(p.getProductId());
                            %>
                                <li>
                                    <strong><%= product.getProductName() %></strong>
                                    &mdash; RM <%= String.format("%.2f", p.getAmount()) %>
                                    (<%= p.getPurchaseDate() %>)
                                </li>
                            <% } %>
                        </ul>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>

        <div class="action-buttons">
            <% if (isManager) { %>
                <form action="addCustomer.jsp" method="get" style="display:inline;">
                    <button type="submit" class="add-button">➕ Add Customer</button>
                </form>

            <button class="edit-button" onclick="openEditModal()">✏️ Edit Customer</button>
            
            <% } %>
        </div>

        <!-- Edit Customer Modal -->
        <div id="editModal" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close" onclick="closeEditModal()">&times;</span>
                <h2>Edit Customer</h2>
                <form action="editCustomer.jsp" method="get">
                    <label for="editId">Enter Customer ID:</label><br>
                    <input type="text" id="editId" name="id" required><br><br>
                    <button type="submit" class="edit-button">Find Customer</button>
                </form>
            </div>
        </div>
        
    </div>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById("userDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }

        function openEditModal() {
            document.getElementById("editModal").style.display = "block";
        }

        function closeEditModal() {
            document.getElementById("editModal").style.display = "none";
        }
        
        function openDeleteModal() {
            document.getElementById("deleteModal").style.display = "block";
        }

        function closeDeleteModal() {
            document.getElementById("deleteModal").style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target.classList.contains("modal")) {
                closeEditModal();
                closeDeleteModal();
            }
        }
    </script>

    <% 
        String success = request.getParameter("success");
        if ("true".equals(success)) {
    %>
    <script>
        alert("✅ Customer added successfully!");
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.pathname);
        }
    </script>
    <% } %>

    <% 
        String msg = request.getParameter("msg");
        if (msg != null) {
    %>
    <script>alert("<%= msg %>");</script>
    <% } %>

    <jsp:include page="footer.jsp"/>
</body>
</html>