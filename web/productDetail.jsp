<%-- 
    Document   : productDetail
    Created on : 27 Apr 2025, 22:52:04
    Author     : Hong Jie
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="domain.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page import="da.CommentDA" %>
<%@ page import="domain.Comment" %>
<%@ page import="java.util.List" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDA productDA = new ProductDA();
    Product p = productDA.getRecord(productId);

    // Temporary simulation for Manager access
    session.setAttribute("position", "Manager");

    String position = (String) session.getAttribute("position");
    boolean isManager = position != null && position.equalsIgnoreCase("Manager");

    // Create an instance of CommentDA to fetch customer comments
    CommentDA commentDA = new CommentDA();
    List<Comment> comments = commentDA.getCustomerComments(productId);
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

    /* Bottom Section */
    .bottom-section {
        background: #fff;
        padding: 30px;
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

    .rating {
        font-size: 18px;
        font-weight: 500;
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

    /* Responsive */
    @media (max-width: 768px) {
        .top-section {
            flex-direction: column;
            align-items: center;
        }

        .product-image img {
            width: 100%;
        }
    }
</style>

    <script>
        function toggleReplyForm(commentId) {
            var form = document.getElementById("reply-form-" + commentId);
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
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
                        <div class="quantity-control">
                            <button class="quantity-btn">-</button>
                            <input type="number" class="quantity" value="1" min="1">
                            <button class="quantity-btn">+</button>
                        </div>
                        <button class="add-to-cart-btn">Add to Cart</button>
                    </div>
                </div>
            </div>

            <div class="bottom-section">
                <div class="description">
                    <h3>Description</h3>
                    <p><%= p.getDescription() %></p>
                </div>

                <%
                    double averageRating = 0;
                    if (!comments.isEmpty()) {
                        int totalRating = 0;
                        for (Comment c : comments) {
                            totalRating += c.getRating();
                        }
                        averageRating = (double) totalRating / comments.size();
                    }
                %>

                <div class="rating">
                    <strong>Rating:</strong> <%= String.format("%.1f", averageRating) %>/5
                </div>

                <div class="comments-section">
                    <h3>Customer Comments</h3>
                    <% if (comments.isEmpty()) { %>
                        <p>No comments yet.</p>
                    <% } else { %>
                        <% for (Comment comment : comments) { %>
                            <div class="comment">
                                <p><strong><%= comment.getCustomerName() %></strong> <small><%= comment.getTimestamp() %></small></p>
                                <p><%= comment.getCommentText() != null ? comment.getCommentText() : "No comment text available" %></p>
                                <% if (comment.getReplyText() != null) { %>
                                    <div class="reply">
                                        <strong>Reply:</strong> <%= comment.getReplyText() %>
                                    </div>
                                <% } %>

                                <% if (isManager) { %>
                                    <button type="button" onclick="toggleReplyForm('<%= comment.getCommentId() %>')">Reply</button>
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
</body>
</html>
