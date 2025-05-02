<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Store</title>
    <script>
        // Function to increase the quantity
        function increaseQuantity(productId) {
            const quantityField = document.getElementById('quantity-' + productId);
            let currentQuantity = parseInt(quantityField.textContent);
            quantityField.textContent = currentQuantity + 1;

            // Update the hidden input value with the new quantity
            document.getElementById('quantity-hidden-' + productId).value = currentQuantity + 1;
        }

        // Function to decrease the quantity
        function decreaseQuantity(productId) {
            const quantityField = document.getElementById('quantity-' + productId);
            let currentQuantity = parseInt(quantityField.textContent);
            if (currentQuantity > 0) {
                quantityField.textContent = currentQuantity - 1;
                document.getElementById('quantity-hidden-' + productId).value = currentQuantity - 1;
            }
        }

        // Function to add the current quantity to the cart
        function addToCart(productId) {
            const quantity = document.getElementById('quantity-hidden-' + productId).value;
            const size = document.getElementById('size-' + productId).value;
            const color = document.getElementById('color-' + productId).value;

            const form = document.getElementById('cart-form-' + productId);

            // Log the values to ensure they're correct
            console.log("Adding to cart - ProductId: " + productId + ", Quantity: " + quantity + ", Size: " + size + ", Color: " + color);

            // Update the hidden fields for size, color, and quantity
            document.getElementById('quantity-hidden-' + productId).value = quantity;
            document.getElementById('size-hidden-' + productId).value = size;
            document.getElementById('color-hidden-' + productId).value = color;

            // Submit the form
            form.submit();
        }
    </script>
</head>
<body>
    <h1>Welcome to the Online Store</h1>

    <!-- Product 1 -->
    <div>
        <h2>Product 1</h2>
        <p>Price: $10.00</p>

        <!-- Size Selector -->
        <label for="size-1">Size:</label>
        <select id="size-1" name="size">
            <option value="S">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
        </select>

        <!-- Color Selector -->
        <label for="color-1">Color:</label>
        <select id="color-1" name="color">
            <option value="Red">Red</option>
            <option value="Green">Green</option>
            <option value="Blue">Blue</option>
        </select>

        <!-- Quantity Controls -->
        <button onclick="decreaseQuantity('1')">-</button>
        <span id="quantity-1">0</span>
        <button onclick="increaseQuantity('1')">+</button>

        <!-- Add to Cart Form -->
        <form id="cart-form-1" action="<%= request.getContextPath() %>/cart" method="post">
            <input type="hidden" name="action" value="addToCart">
            <input type="hidden" name="productId" value="1"> <!-- Product ID -->
            <input type="hidden" name="productName" value="Sample Product"> <!-- Product Name -->
            <input type="hidden" name="price" value="10.00"> <!-- Price -->

            <!-- Hidden inputs for size, color, and quantity -->
            <input type="hidden" id="quantity-hidden-1" name="quantity" value="0">
            <input type="hidden" id="size-hidden-1" name="size" value="M">
            <input type="hidden" id="color-hidden-1" name="color" value="Red">

            <button type="button" onclick="addToCart('1')">Add to Cart</button>
        </form>
    </div>

    <!-- Product 2 -->
    <div>
        <h2>Product 2</h2>
        <p>Price: $15.00</p>

        <!-- Size Selector -->
        <label for="size-2">Size:</label>
        <select id="size-2" name="size">
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>
        </select>

        <!-- Color Selector -->
        <label for="color-2">Color:</label>
        <select id="color-2" name="color">
            <option value="Black">Black</option>
            <option value="White">White</option>
            <option value="Blue">Blue</option>
        </select>

        <!-- Quantity Controls -->
        <button onclick="decreaseQuantity('2')">-</button>
        <span id="quantity-2">0</span>
        <button onclick="increaseQuantity('2')">+</button>

        <!-- Add to Cart Form -->
        <form id="cart-form-2" action="<%= request.getContextPath() %>/cart" method="post">
            <input type="hidden" name="action" value="addToCart">
            <input type="hidden" name="productId" value="2"> <!-- Product ID -->
            <input type="hidden" name="productName" value="Sample Product 2"> <!-- Product Name -->
            <input type="hidden" name="price" value="15.00"> <!-- Price -->

            <!-- Hidden inputs for size, color, and quantity -->
            <input type="hidden" id="quantity-hidden-2" name="quantity" value="0">
            <input type="hidden" id="size-hidden-2" name="size" value="M">
            <input type="hidden" id="color-hidden-2" name="color" value="Black">

            <button type="button" onclick="addToCart('2')">Add to Cart</button>
        </form>
    </div>

    <a href="<%= request.getContextPath() %>/cart.jsp">View Cart</a>
</body>
</html>













