<%-- 
    Document   : editProduct
    Created on : 23 Apr 2025, 09:05:41
    Author     : Hong Jie
--%>

<%@ page import="domain.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String idParam = request.getParameter("id");
    Product product = null;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            ProductDA productDA = new ProductDA();
            product = productDA.getRecord(id);
            productDA.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
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
        input[type="text"], textarea {
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
            text-align: center;
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
        .btn-group form {
            margin: 0;
        }
    </style>
</head>
<body>
<% if (product == null) { %>
    <h2 style="text-align:center;">Product with ID <%= idParam %> not found.</h2>
<% } else { %>
    <div class="form-container">
        <form action="<%= request.getContextPath() %>/EditProductServlet" method="post">
            <input type="hidden" name="id" value="<%= product.getProductId() %>">

            <label>Product Name</label>
            <input type="text" value="<%= product.getProductName() %>" readonly>

            <label>Category</label>
            <input type="text" value="<%= product.getCategory() %>" readonly>

            <label>Price (RM)</label>
            <input type="text" name="price" value="<%= String.format("%.2f", product.getPrice()) %>" required>

            <label>Description</label>
            <textarea name="description" rows="4"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>

            <label>Image URL</label>
            <input type="text" name="img_url" value="<%= product.getImgUrl() != null ? product.getImgUrl() : "" %>">

            <div class="btn-group">
                <!-- Save/Update Button -->
                <button type="submit" name="action" value="update" class="save-btn">💾 Save Changes</button>

                <a href="product.jsp" class="button-link back-btn">🔙 Back to Products</a>

                <!-- Delete Button -->
                <button type="submit" name="action" value="delete" class="delete-btn" onclick="return confirmDelete();">🗑️ Delete Product</button>
            </div>
        </form>
    </div>
<% } %>

<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this product?");
    }
</script>
</body>
</html>
