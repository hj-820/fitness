<%-- 
    Document   : productDetail
    Created on : 27 Apr 2025, 22:52:04
    Author     : Hong Jie
--%>

<%@ include file="headerHome.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="domain.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page import="da.CommentDA" %>
<%@ page import="da.CustomerDA" %>
<%@ page import="domain.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% if (request.getSession().getAttribute("successMessage") != null) { %>
    <div class="alert alert-success">
        <%= request.getSession().getAttribute("successMessage") %>
    </div>
    <% request.getSession().removeAttribute("successMessage"); %>
<% } %>

<% if (request.getSession().getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <%= request.getSession().getAttribute("errorMessage") %>
    </div>
    <% request.getSession().removeAttribute("errorMessage"); %>
<% } %>

<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDA productDA = new ProductDA();
    Product p = productDA.getRecord(productId);

    String position = (String) session.getAttribute("userType");
    boolean isManager = position != null && position.equalsIgnoreCase("Manager");
    
    String userType = (String) session.getAttribute("userType");
    String email = (String) session.getAttribute("email");
    boolean canAddToCart = email != null && (userType == null || (!userType.equals("manager") && !userType.equals("staff")));

    // Create an instance of CommentDA to fetch customer comments
    CommentDA commentDA = new CommentDA();
    List<Comment> comments = commentDA.getCommentsByProduct(productId);
    
    CustomerDA customerDA = new CustomerDA();
    
    // Calculate average rating and rating distribution
    double averageRating = 0;
    int[] ratingCounts = new int[5]; // For counting ratings 1-5
    int totalRatings = 0;
    
    if (!comments.isEmpty()) {
        int totalRating = 0;
        for (Comment c : comments) {
            int rating = c.getRating();
            if (rating >= 1 && rating <= 5) {
                ratingCounts[rating-1]++;
                totalRating += rating;
                totalRatings++;
            }
        }
        averageRating = totalRatings > 0 ? (double) totalRating / totalRatings : 0;
    }
    
    // Date formatter for timestamp display
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .product-detail-page {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .container {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* Top Section */
        .top-section {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            align-items: flex-start;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.08);
        }

        .product-image img {
            width: 400px;
            height: auto;
            border-radius: 10px;
            object-fit: cover;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.1);
        }

        .product-details {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .product-title {
            font-size: 32px;
            font-weight: bold;
        }

        .price {
            font-size: 24px;
            color: #e74c3c;
            font-weight: bold;
        }

        .quantity-cart-container {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-top: 20px;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }

        .quantity-btn {
            background-color: #eee;
            border: none;
            padding: 10px 15px;
            font-size: 18px;
            cursor: pointer;
        }

        .quantity {
            width: 50px;
            text-align: center;
            font-size: 16px;
            border: none;
            outline: none;
        }

        .add-to-cart-btn {
            background-color: #3498db;
            padding: 12px 25px;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-to-cart-btn:hover {
            background-color: #2980b9;
        }

        /* Rating Section */
        .rating-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 20px 0;
        }

        .average-rating {
            font-size: 24px;
            font-weight: bold;
        }

        .rating-stars {
            display: flex;
            gap: 5px;
        }

        .rating-stars .star {
            color: #ddd;
            font-size: 24px;
        }

        .rating-stars .filled {
            color: #ffcc00;
        }

        .rating-distribution {
            flex-grow: 1;
        }

        .rating-bar {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }

        .rating-bar-label {
            width: 80px;
        }

        .rating-bar-container {
            flex-grow: 1;
            height: 20px;
            background-color: #eee;
            border-radius: 10px;
            overflow: hidden;
        }

        .rating-bar-fill {
            height: 100%;
            background-color: #ffcc00;
        }

        /* Bottom Section */
        .bottom-section {
            background: #fff;
            padding: 30px;
            margin-bottom:150px;
            border-radius: 12px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .description p {
            margin-top: 10px;
            font-size: 16px;
            color: #555;
        }

        .comments-section {
            margin-top: 20px;
        }

        .comment {
            margin-bottom: 20px;
            padding: 20px;
            background: #fafafa;
            border-left: 5px solid #3498db;
            border-radius: 8px;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .comment-rating {
            display: flex;
            gap: 5px;
        }

        .comment-rating .star {
            color: #ffcc00;
        }

        .comment p {
            margin: 5px 0;
        }

        .reply {
            margin-top: 10px;
            padding: 10px;
            background: #e8f0fe;
            border-radius: 5px;
        }

        .reply-section {
            margin-top: 15px;
            background: #f0f0f0;
            padding: 20px;
            border-radius: 8px;
            display: none;
        }

        textarea {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            resize: vertical;
            font-size: 15px;
        }

        .reply-section button {
            margin-top: 10px;
            background-color: #2ecc71;
            border: none;
            padding: 10px 20px;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

        .reply-section button:hover {
            background-color: #27ae60;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }

        .alert-success {
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }

        .alert-error {
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .top-section {
                flex-direction: column;
                align-items: center;
            }

            .product-image img {
                width: 100%;
            }
            
            .rating-section {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>

    <script>
        function toggleReplyForm(commentId) {
            var form = document.getElementById("reply-form-" + commentId);
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
        }
        
        function renderStars(rating, container) {
            container.innerHTML = '';
            for (let i = 1; i <= 5; i++) {
                const star = document.createElement('span');
                star.className = i <= rating ? 'star filled' : 'star';
                star.innerHTML = '★';
                container.appendChild(star);
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            // Render star ratings for comments
            document.querySelectorAll('.comment-rating').forEach(container => {
                const rating = parseInt(container.dataset.rating);
                renderStars(rating, container);
            });
            
            // Render average rating stars
            const avgRating = <%= averageRating %>;
            const avgContainer = document.getElementById('average-rating-stars');
            if (avgContainer) {
                renderStars(Math.round(avgRating), avgContainer);
            }
        });
        
            // Quantity control functions
    function incrementQuantity() {
        const quantityInput = document.getElementById('productQuantity');
        let quantity = parseInt(quantityInput.value);
        if (quantity < 99) { // You can adjust the max value as needed
            quantityInput.value = quantity + 1;
        }
    }

    function decrementQuantity() {
        const quantityInput = document.getElementById('productQuantity');
        let quantity = parseInt(quantityInput.value);
        if (quantity > 1) { // Minimum quantity is 1
            quantityInput.value = quantity - 1;
        }
    }

    // Add to cart function
    function addToCart() {
        const quantity = document.getElementById('productQuantity').value;
        const productId = <%= productId %>;
        
        // Here you can implement your cart addition logic
        // Example using fetch API:
        fetch('CartServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `productId=${productId}&quantity=${quantity}`
        })
        .then(response => {
            if (response.ok) {
                alert('Product added to cart successfully!');
                // You can update the cart count display here if needed
            } else {
                alert('Failed to add product to cart');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while adding to cart');
        });
    }

    </script>
</head>
<body>
    <div class="product-detail-page">
        <div class="container">
            <div class="top-section">
                <div class="product-image">
                    <img src="<%= p.getImgUrl() %>" alt="<%= p.getProductName() %>" />
                </div>

                <div class="product-details">
                    <h1 class="product-title"><%= p.getProductName() %></h1>
                    <p class="price">RM <%= p.getPrice() %></p>
                    <div class="quantity-cart-container">
                        <form action="<%= canAddToCart ? "CartServlet" : "#" %>" method="post" onsubmit="<%= canAddToCart ? "return true;" : "alert('Please log in as a customer to add to cart.'); return false;" %>">
                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                <input type="hidden" name="productName" value="<%= p.getProductName() %>">
                                <input type="hidden" name="price" value="<%= p.getPrice() %>">
                                <input type="hidden" name="image" value="<%= p.getImgUrl() %>">
                        <div class="quantity-control">
                            <button type="button" class="quantity-btn" onclick="decrementQuantity()">-</button>
                            <input type="number" id="productQuantity" name="quantity" class="quantity" value="1" min="1" max="99">
                            <button type="button" class="quantity-btn" onclick="incrementQuantity()">+</button>
                        </div>
                        <button type="submit"
                        class="add-to-cart-btn"
                        <%= canAddToCart ? "" : "onclick='alert(\"Please log in as a customer to add to cart.\"); return false;' title='Login required to add to cart'" %>>
                  Add to Cart
                </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="bottom-section">
                <div class="description">
                    <h3>Description</h3>
                    <p><%= p.getDescription() %></p>
                </div>

                <div class="rating-section">
                    <div class="average-rating">
                        <%= String.format("%.1f", averageRating) %>/5
                        <div id="average-rating-stars" class="rating-stars"></div>
                    </div>
                    
                    <div class="rating-distribution">
                        <% for (int i = 5; i >= 1; i--) { %>
                            <div class="rating-bar">
                                <div class="rating-bar-label"><%= i %> star<%= i != 1 ? "s" : "" %></div>
                                <div class="rating-bar-container">
                                    <div class="rating-bar-fill" style="width: <%= totalRatings > 0 ? (ratingCounts[i-1] * 100 / totalRatings) : 0 %>%;"></div>
                                </div>
                                <div class="rating-count"><%= ratingCounts[i-1] %></div>
                            </div>
                        <% } %>
                    </div>
                </div>

                <div class="comments-section">
                    <h3>Customer Reviews (<%= comments.size() %>)</h3>
                    <% if (comments.isEmpty()) { %>
                        <p>No reviews yet.</p>
                    <% } else { %>
                        <% for (Comment comment : comments) { %>
                            <div class="comment">
                                <div class="comment-header">
                                    <strong><%= customerDA.getNameById(comment.getCustomerId()) %></strong>
                                    <div class="comment-rating" data-rating="<%= comment.getRating() %>"></div>
                                </div>
                                <small><%= dateFormat.format(comment.getTimestampr()) %></small>
                                <p><%= comment.getCommentText() != null ? comment.getCommentText() : "" %></p>
                                <% if (comment.getReplyText() != null) { %>
                                    <div class="reply">
                                        <strong>Fitness Concept:</strong> <%= comment.getReplyText() %>
                                    </div>
                                <% } %>

                                <% if (isManager) { %>
                                    <button type="button" class="reply-section button" onclick="toggleReplyForm('<%= comment.getCommentId() %>')">Reply</button>
                                    <div id="reply-form-<%= comment.getCommentId() %>" class="reply-section">
                                        <form action="ReplyServlet" method="post">
                                            <textarea name="reply" rows="4" placeholder="Write your reply here..."></textarea>
                                            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                            <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                                            <button type="submit">Reply</button>
                                        </form>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
<%@ include file="footer.jsp" %>
</body>
</html>