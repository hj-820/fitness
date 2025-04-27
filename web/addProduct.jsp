<%-- 
    Document   : addProduct
    Created on : 22 Apr 2025, 18:24:53
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="domain.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        product = new Product();
    }

    String priceVal = product.getPrice() != 0.0
        ? String.format("%.2f", product.getPrice())
        : "";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Product</title>
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
        h2 { text-align: center; margin-bottom: 25px; color: #333; }
        label { display: block; margin-bottom: 6px; color: #555; font-weight: bold; }
        input[type="text"], input[type="number"], textarea {
            width: 100%; padding: 10px; margin-bottom: 20px;
            border: 1px solid #ccc; border-radius: 6px; font-size: 14px;
        }
        textarea { resize: vertical; height: 80px; }
        .submit-btn {
            background-color: rgba(253,53,160,255); color: #fff; border: none;
            padding: 12px; width: 100%; border-radius: 6px;
            font-size: 16px; cursor: pointer; font-weight: bold;
        }
        .submit-btn:hover { background-color: #e043a1; }
        .back-link {
            display: block; text-align: center; margin-top: 15px;
            color: #3498db; text-decoration: none;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Add New Product</h2>
    <form action="${pageContext.request.contextPath}/AddProductServlet" method="post">

        <label for="name">Product Name:</label>
        <input type="text" name="name" id="name" required
               value="<%= product.getProductName() != null ? product.getProductName() : "" %>">

        <label for="price">Price (RM):</label>
        <input type="number" name="price" id="price" step="0.01" required
               value="<%= priceVal %>">

        <label for="category">Category:</label>
        <input type="text" name="category" id="category" required
               value="<%= product.getCategory() != null ? product.getCategory() : "" %>">

        <label for="description">Description:</label>
        <textarea name="description" id="description" required><%= 
            product.getDescription() != null ? product.getDescription() : "" 
        %></textarea>

        <label for="img_url">Image URL:</label>
        <input type="text" name="img_url" id="img_url" required
               value="<%= product.getImgUrl() != null ? product.getImgUrl() : "" %>">

        <input type="submit" class="submit-btn" value="Add Product">
    </form>
    <a class="back-link" href="product.jsp">← Back to Products</a>
</div>
</body>
</html>