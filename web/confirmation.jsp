<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.CartItem" %>
<%@ page import="da.CartDA" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .confirmation-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 2.2rem;
            font-weight: 600;
        }

        h2 {
            color: #34495e;
            border-bottom: 2px solid #f1f3f6;
            padding-bottom: 8px;
            margin-top: 25px;
            font-size: 1.4rem;
        }

        .order-details {
            font-size: 16px;
            line-height: 1.6;
            color: #4a5568;
        }

        .order-details p {
            margin: 12px 0;
            padding: 8px 0;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px dashed #e2e8f0;
        }

        .thank-you-message {
            text-align: center;
            font-size: 1.1rem;
            margin: 40px 0 30px;
            color: #3498db;
            font-weight: 500;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-top: 40px;
        }

        .button-group form {
            display: flex;
            justify-content: center;
        }

        .button-group button {
            padding: 14px 28px;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .button-group button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .button-group button:active {
            transform: translateY(0);
        }

        .confirm-button {
            background-color: #27ae60;
            color: white;
        }

        .confirm-button:hover {
            background-color: #219653;
        }

        .cancel-button {
            background-color: #e74c3c;
            color: white;
        }

        .cancel-button:hover {
            background-color: #c0392b;
        }

        .payment-method {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .total-section {
            background-color: #f1f8fe;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .total-section p {
            font-weight: 600;
        }

        .grand-total {
            font-size: 1.2rem;
            color: #2c3e50;
        }

        @media (max-width: 600px) {
            .confirmation-container {
                padding: 25px;
            }

            h1 {
                font-size: 1.8rem;
            }

            .button-group button {
                padding: 12px 20px;
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<%
    // Ensure session and customer ID are valid
    Integer customerId = (Integer) session.getAttribute("id");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String subtotal = request.getParameter("subtotal");
    String deliveryFee = request.getParameter("deliveryFee");
    String grandTotal = request.getParameter("grandTotal");
    String paymentMethod = request.getParameter("paymentMethod");
    
    if (customerId != null) {
        CartDA cartDA = new CartDA();
        ArrayList<CartItem> cartItems = cartDA.getCartItemsByCustomerId(customerId);
%>

    <div class="confirmation-container">
        <h1>Confirm Your Order</h1>

    <div class="order-details">
        <h2>Customer Information:</h2>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
        <p><strong>Address:</strong> <%= address %></p>

        <h2>Order Summary:</h2>
        <%
                    for (CartItem item : cartItems) {
                %>
                    <strong>Product:</strong> <%= item.getProductName() %> |
                        <strong>Quantity:</strong> <%= item.getQuantity() %>
                <%
                    }
                %>
        <p><strong>Subtotal:</strong> RM <%= subtotal %></p>
        <p><strong>Delivery Fee:</strong> RM <%= deliveryFee %></p>
        <p><strong>Grand Total:</strong> RM <%= grandTotal %></p>
        <p><strong>Payment Method:</strong> <%= paymentMethod.equals("creditCard") ? "Credit Card" : "Cash on Delivery" %></p>
    </div>
           
        </div>

        <div class="thank-you-message">
            <p>We appreciate your business! Please confirm your order or cancel to make changes.</p>
        </div>

        <div class="button-group">
            <form action="AddPurchaseServlet" method="post">
                <input type="hidden" name="name" value="<%= name %>">
                <input type="hidden" name="phone" value="<%= phone %>">
                <input type="hidden" name="address" value="<%= address %>">
                <input type="hidden" name="subtotal" value="<%= subtotal %>">
                <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">
                <button type="submit">Confirm Order</button>
            </form>
            <form action="payment.jsp" method="post">
                <input type="hidden" name="subtotal" value="<%= subtotal %>">
                <button type="submit" class="cancel-button">Cancel and Go Back to Payment</button>
            </form>
        </div>
    </div>

<%
    } else {
        response.sendRedirect("payment.jsp");
    }
%>

</body>
</html>