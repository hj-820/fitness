<%-- 
    Document   : home1
    Created on : 28 Apr 2025, 11:19:42
    Author     : Hong Jie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, da.ProductDA, domain.Product, java.util.*" %>
<%@ include file="headerHome.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Fitness Concept - Home</title>
  <style>
    /* Home1.jsp sections (unchanged) */
    .shipping-banner img,
    .promo-banner img {
      width:100%; height:auto; display:block;
    }
    .promo-banner { margin-top:20px; }

    .categories-section {
      background:#f7f7f7;
      padding:50px 20px;
      text-align:center;
    }
    .categories-section h2 { margin-bottom:40px; }
    .category-container {
      display:flex; flex-wrap:wrap; justify-content:center; gap:20px;
    }
    .category-box {
      position:relative;
      width:250px; height:250px;
      overflow:hidden; border-radius:10px;
    }
    .category-box img {
      width:100%; height:100%; object-fit:cover;
    }
    .category-box .label {
      position:absolute;
      top:50%; left:50%;
      transform:translate(-50%,-50%);
      background:rgba(255, 255, 255, 0.7); 
      padding:20px;
      border-radius:10px;
      text-align:center;
    }

    .trending-section {
      padding:50px 20px;
      padding-bottom:80px;
      flex:1;
    }
    .trending-section h2 { text-align:center; margin-bottom:40px; }
    .trending-grid {
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
      gap:20px; justify-items:center;
    }
    .trending-card {
      background:#fff;
      border-radius:10px;
      overflow:hidden;
      box-shadow:0 2px 8px rgba(0,0,0,0.1);
      width:100%; max-width:240px;
      display:flex; flex-direction:column;
    }
    .trending-card img {
      width:100%; height:180px; object-fit:cover;
    }
    .trending-info {
      padding:15px; text-align:center;
      flex:1;
    }
    .trending-info h3 { margin-bottom:10px; font-size:18px; }
    .trending-info p { color:#888; margin-bottom:15px; }
    .trending-info .btn {
      display:inline-block;
      background:#ff4081; color:#fff;
      padding:8px 16px; border-radius:5px;
      transition:opacity .2s;
    }
    .trending-info .btn:hover { opacity:.8; }
  </style>
</head>
<body>

  <!-- Shipping Image -->
  <div class="shipping-banner">
    <img src="images/shipping.png" alt="Free Shipping">
  </div>

  <!-- Promo Image -->
  <div class="promo-banner">
    <img src="images/promo.jpg" alt="Promotion">
  </div>

  <!-- Categories Section -->
  <section class="categories-section">
    <h2>Shop by Category</h2>
    <div class="category-container">
      <div class="category-box">
        <img src="images/cardio.jpg" alt="Cardio">
        <div class="label">
          <h3>CARDIO</h3>
          <p>Elliptical, Bike</p>
        </div>
      </div>
      <div class="category-box">
        <img src="images/strength.jpg" alt="Strength">
        <div class="label">
          <h3>STRENGTH</h3>
          <p>Gym, Benches, Dumbbells, Plates</p>
        </div>
      </div>
      <div class="category-box">
        <img src="images/accessories.jpg" alt="Accessories">
        <div class="label">
          <h3>ACCESSORIES</h3>
          <p>Gym Balls, Bands, Rehab</p>
        </div>
      </div>
      <div class="category-box">
        <img src="images/treadmill.jpg" alt="Specialty">
        <div class="label">
          <h3>Treadmill</h3>
          <p>Running machines</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Trending Products Section -->
  <section class="trending-section">
    <h2>Trending Now</h2>
    <div class="trending-grid">
    <%
      // fetch all products, shuffle, then render first 4
      List<Product> all = Collections.emptyList();
      try {
        ProductDA dao = new ProductDA();
        all = dao.getAllRecords();
        dao.close();
      } catch (ClassNotFoundException e) {
        e.printStackTrace();
      } catch (SQLException e) {
        e.printStackTrace();
      }
      Collections.shuffle(all);
      for (int i = 0; i < Math.min(4, all.size()); i++) {
        Product p = all.get(i);
    %>
      <div class="trending-card">
        <img src="<%= p.getImgUrl() %>" alt="<%= p.getProductName() %>">
        <div class="trending-info">
          <h3><%= p.getProductName() %></h3>
          <p>RM <%= p.getPrice() %></p>
          <a href="productDetail.jsp?productId=<%= p.getProductId() %>" class="btn">View</a>
        </div>
      </div>
    <% } %>
    </div>
  </section>

  <%@ include file="footer.jsp" %>
</body>
</html>

