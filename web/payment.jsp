<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .payment-container {
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input:focus {
            border-color: #3498db;
            outline: none;
        }

        .method-toggle {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .toggle-button {
            flex: 1;
            padding: 12px;
            border: 1px solid #ccc;
            margin-right: 10px;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: 0.3s ease;
        }

        .toggle-button:last-child {
            margin-right: 0;
        }

        .toggle-button img {
            width: 20px;
            height: 20px;
        }

        .toggle-button.active {
            border: 2px solid #3498db;
            background-color: #ecf7ff;
        }

        .summary p {
            margin: 6px 0;
        }

        button {
            background-color: #27ae60;
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #1e8449;
        }

        .cancel-button {
            background-color: #e74c3c;
            margin-top: 10px;
            text-align: center;
        }

        .cancel-button:hover {
            background-color: #c0392b;
        }

        #cardInfo {
            display: block;
        }
    </style>
</head>
<body>

<%
    String subtotal = request.getParameter("subtotal");
    double deliveryFee = 25.00;
    
    // If subtotal is greater than 1000, waive the delivery fee
    if (Double.parseDouble(subtotal) > 1000) {
        deliveryFee = 0.00;
    }

    double sst = 0.06 * Double.parseDouble(subtotal);
    double grandTotal = Double.parseDouble(subtotal) + deliveryFee + sst;

    String name = (String) session.getAttribute("fullName");
    String phone = (String) session.getAttribute("phone");
%>

<div class="payment-container">
    <h1>Payment Information</h1>
    <form action="confirmation.jsp" method="post">
        
        <div class="form-group">
            <input type="text" name="name" maxlength="25" placeholder="Full Name (Max 25 characters)" value="<%= name != null ? name : "" %>" required>
        </div>

        <div class="form-group">
            <input type="tel" name="phone" placeholder="Phone Number (e.g., +1234567890)" value="<%= phone != null ? phone : "" %>" required>
        </div>

        <div class="form-group">
            <input type="text" name="address" placeholder="Shipping Address" required>
        </div>

        <div class="method-toggle">
            <div class="toggle-button active" data-method="creditCard">
                <img src="images/credit_card.png" alt="Card"> Credit Card
            </div>
            <div class="toggle-button" data-method="cod">
                <img src="images/cash.png" alt="COD"> Cash on Delivery
            </div>
        </div>

        <input type="hidden" name="paymentMethod" id="paymentMethodInput" value="creditCard">

        <div id="cardInfo">
            <div class="form-group">
                <input type="text" name="cardNumber" pattern="\d{4}-\d{4}-\d{4}-\d{4}" maxlength="19" placeholder="Card Number e.g. 0000-0000-0000-0000">
            </div>

            <div class="form-group">
                <input type="text" name="expDate" pattern="^(0[1-9]|1[0-2])\/\d{2}$" maxlength="5" placeholder="Expiration Date (MM/YY)">
            </div>

            <div class="form-group">
                <input type="text" name="cvv" pattern="\d{3}" maxlength="3" placeholder="CVV (3 digits)">
            </div>
        </div>

        <div class="summary">
            <p>Subtotal: RM <%= subtotal %></p>
            <p>Delivery Fee: RM <%= deliveryFee %>
                <% if(deliveryFee == 0) { %>
                    <span> (You got free shipping!)</span>
                <% } %>
            </p>
            <p>SST (6%): RM <%= String.format("%.2f", sst) %></p>
            <p><strong>Grand Total: RM <%= String.format("%.2f", grandTotal) %></strong></p>
        </div>

        
        <input type="hidden" name="subtotal" value="<%= subtotal %>">
        <input type="hidden" name="deliveryFee" value="<%= deliveryFee %>">
        <input type="hidden" name="grandTotal" value="<%= grandTotal %>">

        <button type="submit">Proceed to Payment</button>
        <button type="button" class="cancel-button" onclick="location.href='cart.jsp'">Cancel and Return to Cart</button>
    </form>
</div>

<script>
    const buttons = document.querySelectorAll('.toggle-button');
    const cardInfo = document.getElementById('cardInfo');
    const paymentMethodInput = document.getElementById('paymentMethodInput');

    buttons.forEach(button => {
        button.addEventListener('click', function () {
            buttons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            const method = this.dataset.method;
            paymentMethodInput.value = method;

            cardInfo.style.display = method === 'creditCard' ? 'block' : 'none';
        });
    });
</script>

</body>
</html>
