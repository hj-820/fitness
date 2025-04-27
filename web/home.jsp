<%-- 
    Document   : Product
    Created on : 22 Apr 2025, 10:37:36 am
    Author     : gary_
--%>
<%@ page import="java.sql.*" %>
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
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}

.category-title {
  grid-column: span 3;
  font-size: 26px;
  font-weight: bold;
  color: #FD35A0;
  margin-top: 60px;
  border-bottom: 2px solid #FD35A0;
  padding-bottom: 5px;
}

.product-card {
  background-color: white;
  padding: 20px;
  border-radius: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.product-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.product-card img {
  width: 100%;
  height: 200px;
  object-fit: contain;
  border-radius: 12px;
}

.product-name {
  font-size: 17px;
  font-weight: 600;
  margin: 12px 0 5px;
}

.price {
  color: #009966;
  font-size: 18px;
  font-weight: bold;
}

.rating {
  color: #fbc02d;
  font-size: 15px;
  margin: 5px 0;
}

.comment-box {
  margin-top: 12px;
  display: flex;
  gap: 5px;
  align-items: center;
}

.comment-box input {
  padding: 8px 12px;
  width: 70%;
  border: 1px solid #ddd;
  border-radius: 8px;
  outline: none;
  transition: border-color 0.3s ease;
}

.comment-box input:focus {
  border-color: #FD35A0;
}

.comment-box button {
  padding: 8px 12px;
  background-color: #FD35A0;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.comment-box button:hover {
  background-color: #e22e91;
}




.stars {
  display: flex;
  gap: 3px;
  margin: 5px 0;
}

.star {
  font-size: 18px;
  color: #ccc;
  cursor: pointer;
  transition: color 0.3s ease;
}

.star.filled {
  color: #fbc02d;
}

.comment-list {
  list-style-type: disc;
  padding-left: 20px;
  margin-top: 10px;
  font-size: 14px;
  color: #555;
}




.quantity-control {
  margin-top: 15px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.quantity-control button {
  background-color: #fd35a0;
  color: white;
  border: none;
  font-size: 20px;
  width: 35px;
  height: 35px;
  border-radius: 50%;
  cursor: pointer;
  transition: background 0.3s;
}

.quantity-control button:hover {
  background-color: #e02485;
}

.quantity {
  font-size: 18px;
  font-weight: bold;
}


.cart-btn {
  background-color: #FD35A0;
  color: white;
  padding: 8px 16px;
  font-size: 1rem;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.cart-btn:hover {
  background-color: #e1288b;
}

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
    <!-- Loop through the products dynamically -->
    <c:forEach var="product" items="${products}">
      <div class="product-card">
        <div class="product-content">
          <img src="${product.imagePath}" alt="${product.name}" class="product-image">
          
          <div class="product-details">
            <div class="product-name">${product.name}</div>
            <div class="price">MYR ${product.price}</div>

            <!-- ⭐ Rating (optional: you can add logic for real rating) -->
            <div class="rating">
              <div class="stars">
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
              </div>
              <span>0.0 / 5</span>
            </div>

            <!-- 🛒 Add to Cart Button -->
            <div class="add-to-cart">
              <button class="cart-btn">Add to Cart</button>
            </div>
          </div>
        </div>

        <!-- 💬 Comment section -->
        <div class="comment-box">
          <input type="text" placeholder="Leave a comment..." />
          <button>Post</button>
        </div>
        <ul class="comment-list"></ul>
      </div>
    </c:forEach>
  </div>
</div>

</body>
</html>