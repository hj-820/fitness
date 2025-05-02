<%-- 
    Document   : product
    Created on : 20 Apr 2025, 22:58:54
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="domain.Product" %>
<%@ page import="da.ProductDA" %>
<%
    // Simulate user role (replace with session in real app)
    String role = (String) session.getAttribute("userType");
    boolean isManager = role.equalsIgnoreCase("Manager");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Management</title>
    <!-- your existing <style> here -->
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

        .add-product-btn {
            background-color: rgba(253,53,160,255);
            color: white;
            padding: 10px 15px;
            border-radius: 6px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .add-product-btn:hover {
            background-color: #e043a1;
        }

        .add-link:hover {
            background-color: #e043a1;
        }

        .edit-link {
            background-color: #3498db;
            color: white;
        }

        .edit-link:hover {
            background-color: #2980b9;
        }
        
        .edit-link {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s;
            display: inline-block;
            text-decoration: none;
        }

        .edit-link:hover {
            background-color: #2980b9;
        }
        .modal {
    display: none; 
    position: fixed; 
    z-index: 999; 
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
    padding: 20px;
    border: 1px solid #888;
    width: 400px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    text-align: center;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover {
    color: black;
}

.modal-content input[type="text"] {
    width: 80%;
    padding: 10px;
    margin-top: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

    </style>
</head>
<body>
<jsp:include page="headerHome.jsp" />


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
<div class="main-content"style="padding-bottom:70px;">
    <h1>Product Records</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Price (RM)</th>
            <th>Description</th>
            <th>Category</th>
            <th>Image</th>
        </tr>

        <%
            ProductDA productDA = null;
            List<Product> productList = new ArrayList<Product>();

            try {
                productDA = new ProductDA();
                // You need to add a method to fetch all products (I'll show below)
                productList = productDA.getAllRecords();

                for (Product p : productList) {
        %>
        <tr>
            <td><%= p.getProductId() %></td>
            <td><%= p.getProductName() %></td>
            <td><%= String.format("%.2f", p.getPrice()) %></td>
            <td><%= p.getDescription() %></td>
            <td><%= p.getCategory() %></td>
            <td>
                <% if (p.getImgUrl() != null && !p.getImgUrl().isEmpty()) { %>
                    <a href="<%= p.getImgUrl() %>" target="_blank">
                        <img src="<%= p.getImgUrl() %>" alt="Product Image" style="height: 60px; border-radius: 4px;">
                    </a>
                <% } else { %>
                    N/A
                <% } %>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error loading products: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <div style="display: flex; gap: 15px;">
        <a href="addProduct.jsp" class="action-link add-product-btn">➕ Add New Product</a>
        <button onclick="openModal()" class="edit-link">✏️ Edit Product</button>
    </div>
</div>

<!-- Edit Modal (same as your existing modal) -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Edit Product</h2>
        <form action="editProduct.jsp" method="get" onsubmit="return confirmEdit()">
            <label for="productId">Enter Product ID:</label><br>
            <input type="text" name="id" id="productId" required>
            <br><br>
            <button type="submit" class="edit-link">✏️ Edit Product</button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
        function toggleDropdown() {
            var dropdown = document.getElementById("userDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }
        function openModal() {
            document.getElementById("editModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }

        function confirmEdit() {
            const input = document.getElementById("productId").value;
            if (isNaN(input) || input.trim() === "") {
                alert("Please enter a valid Product ID.");
                return false;
            }
            return true;
        }

        // Close modal when clicking outside the content
        window.onclick = function(event) {
            const modal = document.getElementById("editModal");
            if (event.target === modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>
</html>

