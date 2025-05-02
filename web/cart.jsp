<%@ page import="java.util.*, da.CartDA, domain.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="headerHome.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 40px;
        }

        .cart-container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            padding-bottom: 100px;
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }

        .info {
            flex: 2;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .info strong {
            display: block;
            font-size: 16px;
            color: #333;
        }

        .info span {
            color: #666;
            font-size: 14px;
        }

        .price, .quantity, .total, .actions {
            flex: 1;
            text-align: center;
        }

        .btn-action {
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 6px 10px;
            font-size: 14px;
            cursor: pointer;
            margin: 0 3px;
        }

        .btn-action:hover {
            background-color: #2980b9;
        }

        .btn-remove {
            background: none;
            border: none;
            cursor: pointer;
        }

        .btn-remove img {
            width: 20px;
            height: 20px;
        }

        .cart-summary {
            text-align: right;
            margin-top: 30px;
        }

        .cart-summary p {
            font-size: 16px;
            margin: 5px 0;
        }

        .cart-summary strong {
            font-size: 18px;
        }

        .button-group {
            text-align: right;
            margin-top: 20px;
        }

        .button-group button {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            font-size: 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-left: 10px;
        }

        .button-group button:hover {
            background-color: #1e8449;
        }

        .empty-cart {
            text-align: center;
            color: #999;
            font-size: 18px;
            margin-top: 40px;
        }

        img.product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }
    </style>
</head>
<body>
<h1>Your Cart</h1>

<%
    Integer customerId = (Integer) session.getAttribute("id");

    if (customerId == null) {
%>
    <p class="empty-cart">Please log in to view your cart.</p>
    <div class="button-group" style="text-align: center;">
        <a href="<%= request.getContextPath() %>/login.jsp">
            <button>Login</button>
        </a>
    </div>
<%
    } else {
        CartDA cartDA = new CartDA();
        List<CartItem> cartItems = cartDA.getCartItemsByCustomerId(customerId);
        
        if (cartItems.isEmpty()) {
%>
    <p class="empty-cart">Your cart is empty. Start shopping now!</p>
    <div class="button-group" style="text-align: center;">
        <a href="<%= request.getContextPath() %>/home.jsp">
            <button>Continue Shopping</button>
        </a>
    </div>
<%
        } else {
            double subtotal = 0;
%>

<div class="cart-container">
    <% for (CartItem item : cartItems) {
           subtotal += item.getTotalPrice();
    %>
    <div class="cart-item">
        <div class="info">
            <img src="<%= item.getImgUrl() %>" alt="Product Image" class="product-image">
            <div>
                <strong><%= item.getProductName() %></strong>
            </div>
        </div>
        <div class="price">RM <%= String.format("%.2f", item.getPrice()) %></div>
        <div class="quantity">
            <form action="EditCartServlet" method="post" style="display:inline;">
                <input type="hidden" name="action" value="decreaseQuantity">
                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                <button class="btn-action">-</button>
            </form>
            <%= item.getQuantity() %>
            <form action="EditCartServlet" method="post" style="display:inline;">
                <input type="hidden" name="action" value="increaseQuantity">
                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                <button class="btn-action">+</button>
            </form>
        </div>
        <div class="total">RM <%= String.format("%.2f", item.getTotalPrice()) %></div>
        <div class="actions">
            <form action="EditCartServlet" method="post">
                <input type="hidden" name="action" value="removeFromCart">
                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                <button class="btn-remove">
                    <img src="<%= request.getContextPath() %>/images/delete.png" alt="Remove">
                </button>
            </form>
        </div>
    </div>
    <% } %>

    <div class="cart-summary">
        <p>Subtotal: <strong>RM <%= String.format("%.2f", subtotal) %></strong></p>
    </div>

    <div class="button-group">
        <form action="payment.jsp" method="get" style="display:inline;">
            <input type="hidden" name="subtotal" value="<%= subtotal %>">
            <button type="submit">Proceed to Checkout</button>
        </form>
        <a href="<%= request.getContextPath() %>/home.jsp">
            <button style="background-color: #2c3e50;">Continue Shopping</button>
        </a>
    </div>
</div>
<%
        }
    }
%>
<jsp:include page="footer.jsp"/>
</body>
</html>
