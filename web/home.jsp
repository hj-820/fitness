<%-- 
    Document   : Product
    Created on : 22 Apr 2025, 10:37:36 am
    Author     : gary_
--%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="domain.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Gym Product Page</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f4f8;
      color: #333;
    }

    html {
      scroll-behavior: smooth;
    }

    header {
      background-color: #000;
      color: white;
      padding: 20px 40px;
      display: flex;
      align-items: center;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    }

    .logo {
      font-size: 28px;
      font-weight: bold;
      color: #FD35A0;
      display: flex;
      align-items: center;
    }

    .logo img {
      height: 45px;
      margin-right: 10px;
    }

    nav {
      background: linear-gradient(to right, #fd35a0, #ff6ec4);
      padding: 12px 40px;
      font-weight: bold;
      display: flex;
      justify-content: center;
      gap: 30px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    nav a {
      color: white;
      text-decoration: none;
      font-size: 16px;
      transition: all 0.3s ease;
    }

    nav a:hover {
      color: #ffd6ec;
      text-shadow: 0 0 8px rgba(255,255,255,0.6);
    }

    .container {
      display: flex;
      padding: 40px;
      gap: 40px;
    }

    .sidebar {
      width: 20%;
      background-color: white;
      padding: 25px;
      border-radius: 16px;
      box-shadow: 0 0 15px rgba(0,0,0,0.05);
      position: sticky;
      top: 100px;
      height: fit-content;
    }

    .sidebar h3 {
      font-size: 20px;
      margin-bottom: 20px;
      color: #FD35A0;
      border-bottom: 2px solid #fd35a077;
      padding-bottom: 8px;
    }

    .sidebar ul {
      list-style-type: none;
      padding-left: 0;
    }

    .sidebar li {
      margin-bottom: 12px;
    }

    .sidebar a {
      color: #333;
      text-decoration: none;
      font-size: 15px;
      transition: color 0.3s ease;
    }

    .sidebar a:hover {
      color: #FD35A0;
    }

    .products {
      width: 80%;
    }

    /* Category section to start neatly */
    .category-section {
      margin-bottom: 80px;
    }

    /* New styling to align category title with products */
    .category-header {
      margin-bottom: 20px;
      font-size: 28px;
      font-weight: bold;
      color: #FD35A0;
      text-align: left;
      border-bottom: 3px solid #FD35A0;
      padding-bottom: 8px;
    }

    /* New cleaner grid: aligned left, consistent gaps */
    .product-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 25px;
    }

    /* Make all product cards same size for consistency */
    .product-card {
      background-color: white;
      width: 250px; /* Fixed width for nice alignment */
      padding: 18px;
      border-radius: 20px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .product-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    }

    .product-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      border-radius: 12px;
    }

    /* Product details centered nicely */
    .product-details {
      text-align: center;
      margin-top: 10px;
    }

    .product-name {
      font-size: 18px;
      font-weight: 600;
      margin: 10px 0 6px;
      display: block;
      color: #333;
      text-decoration: none;
      transition: color 0.3s;
    }

    .product-name:hover {
      color: #FD35A0;
    }

    .price {
      color: #009966;
      font-size: 17px;
      font-weight: bold;
    }

    .cart-btn {
      background-color: #FD35A0;
      color: white;
      padding: 8px 16px;
      font-size: 1rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
      width: 100%;
      margin-top: 12px;
    }

    .cart-btn:hover {
      background-color: #e1288b;
    }
</style>

      </style>
</head>
<body>

<header>
  <div class="logo">
    <img src="images/logo.png" alt="Gym Store Logo" style="height: 40px;">
  </div>
</header>

<nav>
  <a href="#cardio">Cardio</a>
  <a href="#strength">Strength</a>
  <a href="#accessories">Accessories</a>
</nav>

<div class="container">
  <div class="sidebar">
    <h3>Categories</h3>
    <ul>
      <li><a href="#cardio">Cardio</a></li>
      <li><a href="#strength">Strength</a></li>
      <li><a href="#accessories">Accessories</a></li>
    </ul>
  </div>

  <div class="products">
    <!-- Loop through products and display by category -->
    <%
      ProductDA productDA = new ProductDA();
      List<Product> products = productDA.getAllRecords();
      
      String currentCategory = ""; // To track the current category
      for (Product product : products) {
        String category = product.getCategory();
        
        // If the category changes, display a new category header
        if (!category.equals(currentCategory)) {
          currentCategory = category;
    %>
        <!-- Category Header -->
        <div id="<%= category.toLowerCase() %>" class="category-section">
          <div class="category-header"><%= category %></div>
          <div class="product-grid">
    <% 
        } // End category check
        
    %>
        <!-- Product Card with clickable product name -->
        <form action="productDetail.jsp" method="get">
            <input type="hidden" name="productId" value="<%= product.getProductId() %>">
            <div class="product-card">
              <img src="<%= product.getImgUrl() %>" alt="<%= product.getProductName() %>" class="product-image">
              <div class="product-details">
                <a href="productDetail.jsp?productId=<%= product.getProductId() %>" class="product-name"><%= product.getProductName() %></a>
                <div class="price">MYR <%= product.getPrice() %></div>
                <button type="submit" class="cart-btn">Add to Cart</button>
              </div>
            </div>
          </form>

    <% 
      } // End product loop

      // Close the last opened category section if any
      if (!currentCategory.isEmpty()) {
    %>
      </div> <!-- End product-grid -->
    </div> <!-- End category-section -->
    <% } %>

  </div>
</div>

</body>
</html>