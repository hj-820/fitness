<%@page import="da.ProductDA"%>
<%@page import="da.PurchaseDA"%>
<%@page import="domain.Purchase"%>
<%@page import="domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="headerHome.jsp"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Purchase History</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --dark-color: #2c3e50;
            --primary-color: rgba(253,53,160,1);
            --secondary-color: rgba(184,58,255,1);
            --hover-bg: rgba(255, 255, 255, 0.08);
            --active-bg: rgba(255, 255, 255, 0.15);
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f5f5f5;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        .sidebar {
            background-color: #222;
            color: white;
            padding: 20px 0;
            width: 250px;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            position: sticky;
            top: 0;
        }

        .sidebar-header {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-nav {
            margin-top: 30px;
        }

        .nav-item {
            padding: 15px 25px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            color: white;
        }

        .nav-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .nav-item a {
            color: white;
            text-decoration: none;
        }

        .nav-item.active {
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 3px solid var(--primary-color);
        }

        .main-content {
            flex-grow: 1;
            padding: 30px;
        }

        .purchase-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            padding-bottom: 40px;
            width: 100%;
            max-width: none;
            margin: 0 auto;
        }

        .purchase-header {
            margin-bottom: 30px;
            text-align: center;
        }

        .purchase-header h1 {
            color: var(--dark-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
        }

        .purchase-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background-color: white;
        }

        .purchase-card-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .purchase-details {
            margin-bottom: 15px;
        }

        .product-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #eee;
        }

        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
            border-radius: 4px;
        }

        .product-info {
            flex-grow: 1;
        }

        .product-name {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .product-price {
            color: #009966;
        }

        .summary {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin-top: 15px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .grand-total {
            font-weight: bold;
            font-size: 1.2em;
            color: var(--primary-color);
        }

        .comment-box {
            margin-top: 15px;
        }

        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
        }

        .submit-comment {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .submit-comment:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(253,53,160,0.3);
        }

        .customer-info {
            margin-bottom: 15px;
            padding: 15px;
            background-color: #f0f8ff;
            border-radius: 4px;
        }


        .delete-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .delete-btn:hover {
            background-color: #c0392b;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
                .rating-container {
            margin-bottom: 10px;
        }
        
        .rating-stars {
            display: flex;
            direction: rtl; /* Right to left for easier selection */
        }
        
        .rating-stars input {
            display: none;
        }
        
        .rating-stars label {
            color: #ddd;
            font-size: 24px;
            cursor: pointer;
            padding: 0 2px;
        }
        
        .rating-stars input:checked ~ label,
        .rating-stars label:hover,
        .rating-stars label:hover ~ label {
            color: #ffcc00;
        }
        
        .rating-stars input:checked + label,
        .rating-stars input:checked + label ~ label {
            color: #ffcc00 !important;
        }
    </style>
</head>
<body style="margin: 0;">
    <div style="display: flex;">
        <!-- Sidebar Start -->
        <div class="sidebar">
            <div>
                <div class="sidebar-header">
                    <h2>FITNESS CONCEPT</h2>
                    <p>Member Dashboard</p>
                </div>

                <div class="sidebar-nav">
                    <div class="nav-item">
                        <i class="fas fa-user"></i> <a href="profile.jsp">Profile Management</a>
                    </div>
                    <div class="nav-item">
                        <i class="fas fa-shopping-cart"></i> <a href="purchaseHistory.jsp">Purchase History</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="main-content">
            <div class="purchase-container">
                <h1>Your Purchase History</h1>
                
                <%
                    // Get customer ID from session
                    Integer customerId = (Integer) session.getAttribute("id");
                    if (customerId == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }
                    
                    try {
                        // Get purchase history
                        PurchaseDA purchaseDA = new PurchaseDA();
                        List<Purchase> purchases = purchaseDA.getPurchasesByCustomerId(customerId);
                        ProductDA productDA = new ProductDA();
                        
                        if (purchases.isEmpty()) {
                %>
                            <p>You haven't made any purchases yet.</p>
                <%
                        } else {
                            String currentDate = "";
                            List<Purchase> dailyPurchases = new ArrayList<Purchase>();
                            double dailySubtotal = 0;
                            int totalQuantity = 0;
                            
                            for (Purchase purchase : purchases) {
                                String purchaseDate = purchase.getPurchaseDate().split(" ")[0]; // Get just the date part
                                
                                // If new date, process the previous day's purchases
                                if (!purchaseDate.equals(currentDate) && !dailyPurchases.isEmpty()) {
                                    double dailySst = dailySubtotal * 0.06;
                                    double dailyDeliveryFee = dailySubtotal >= 1000 ? 0 : 30;
                                    double dailyGrandTotal = dailySubtotal + dailySst + dailyDeliveryFee;
                                    Purchase firstPurchase = dailyPurchases.get(0);
                %>
                                    <div class="purchase-card">
                                        <div class="purchase-header">
                                            <div>
                                                <strong>Order Date: <%= currentDate %></strong>
                                            </div>
                                            <div>
                                                <strong>Items: <%= dailyPurchases.size() %></strong>
                                            </div>
                                        </div>
                                        
                                        <div class="customer-info">
                                            <h3>Customer Information</h3>
                                            <p><strong>Name:</strong> <%= firstPurchase.getCustomerName() %></p>
                                            <p><strong>Phone:</strong> <%= firstPurchase.getCustomerPhone() %></p>
                                            <p><strong>Address:</strong> <%= firstPurchase.getCustomerAddress() %></p>
                                        </div>
                                        
                                        <div class="purchase-details">
                                            <h3>Products</h3>
                                            <%
                                                for (Purchase p : dailyPurchases) {
                                                    Product product = productDA.getRecord(p.getProductId());
                                                    if (product != null) {
                                            %>
                                            <div class="product-item">
                                                <img src="<%= product.getImgUrl() %>" alt="<%= product.getProductName() %>" class="product-image">
                                                <div class="product-info">
                                                    <div class="product-name"><%= product.getProductName() %></div>
                                                    <div class="product-price">MYR <%= product.getPrice() %></div>
                                                    <div>Quantity: <%= p.getQuantity() %></div>
                                                    <div class="action-buttons">
                                                        <form action="DeletePurchaseServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this purchase?');">
                                                            <input type="hidden" name="purchaseId" value="<%= p.getPurchaseId() %>">
                                                            <button type="submit" class="delete-btn">
                                                                <i class="fas fa-trash-alt"></i> Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <% 
                                                    }
                                                } 
                                            %>
                                        </div>

                                        <div class="summary">
                                            <div class="summary-row">
                                                <span>Subtotal (<%= totalQuantity %> items):</span>
                                                <span>MYR <%= String.format("%.2f", dailySubtotal) %></span>
                                            </div>
                                            <div class="summary-row">
                                                <span>SST (6%):</span>
                                                <span>MYR <%= String.format("%.2f", dailySst) %></span>
                                            </div>
                                            <div class="summary-row">
                                                <span>Delivery Fee:</span>
                                                <span>MYR <%= String.format("%.2f", dailyDeliveryFee) %></span>
                                            </div>
                                            <div class="summary-row grand-total">
                                                <span>Grand Total:</span>
                                                <span>MYR <%= String.format("%.2f", dailyGrandTotal) %></span>
                                            </div>
                                        </div>
                                        
                                        <div class="comment-box">
                                            <h3>Leave a Review</h3>
                                            <%
                                                for (Purchase p : dailyPurchases) {
                                                    Product product = productDA.getRecord(p.getProductId());
                                                    if (product != null) {
                                            %>
                                            <div style="margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
                                                <p><strong><%= product.getProductName() %></strong></p>
                                                <form action="ReviewServlet" method="post">
                                                    <input type="hidden" name="purchaseId" value="<%= p.getPurchaseId() %>">
                                                    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                                    <textarea name="comment" rows="4" placeholder="Share your experience with this product..."></textarea>
                                                    <div class="action-buttons">
                                                        <button type="submit" class="submit-comment">Submit Review</button>
                                                    </div>
                                                </form>
                                            </div>
                                            <%
                                                    }
                                                }
                                            %>
                                        </div>
                                    </div>
                <%
                                    // Reset for new date
                                    dailyPurchases = new ArrayList<Purchase>();
                                    dailySubtotal = 0;
                                    totalQuantity = 0;
                                }
                                
                                // Add current purchase to daily list
                                currentDate = purchaseDate;
                                dailyPurchases.add(purchase);
                                dailySubtotal += purchase.getAmount();
                                totalQuantity += purchase.getQuantity();
                            }
                            
                            // Process the last day's purchases
                            if (!dailyPurchases.isEmpty()) {
                                double dailySst = dailySubtotal * 0.06;
                                double dailyDeliveryFee = dailySubtotal >= 1000 ? 0 : 30;
                                double dailyGrandTotal = dailySubtotal + dailySst + dailyDeliveryFee;
                                Purchase firstPurchase = dailyPurchases.get(0);
                %>
                                <div class="purchase-card">
                                    <div class="purchase-header">
                                        <div>
                                            <strong>Order Date: <%= currentDate %></strong>
                                        </div>
                                        <div>
                                            <strong>Items: <%= dailyPurchases.size() %></strong>
                                        </div>
                                    </div>
                                    
                                    <div class="customer-info">
                                        <h3>Customer Information</h3>
                                        <p><strong>Name:</strong> <%= firstPurchase.getCustomerName() %></p>
                                        <p><strong>Phone:</strong> <%= firstPurchase.getCustomerPhone() %></p>
                                        <p><strong>Address:</strong> <%= firstPurchase.getCustomerAddress() %></p>
                                    </div>
                                    
                                    <div class="purchase-details">
                                        <h3>Products</h3>
                                        <%
                                            for (Purchase p : dailyPurchases) {
                                                Product product = productDA.getRecord(p.getProductId());
                                                if (product != null) {
                                        %>
                                        <div class="product-item">
                                            <img src="<%= product.getImgUrl() %>" alt="<%= product.getProductName() %>" class="product-image">
                                            <div class="product-info">
                                                <div class="product-name"><%= product.getProductName() %></div>
                                                <div class="product-price">MYR <%= product.getPrice() %></div>
                                                <div>Quantity: <%= p.getQuantity() %></div>
                                                <div class="action-buttons">
                                                    <form action="DeletePurchaseServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this purchase?');">
                                                        <input type="hidden" name="purchaseId" value="<%= p.getPurchaseId() %>">
                                                        <button type="submit" class="delete-btn">
                                                            <i class="fas fa-trash-alt"></i> Delete
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <% 
                                                }
                                            } 
                                        %>
                                    </div>

                                    <div class="summary">
                                        <div class="summary-row">
                                            <span>Subtotal (<%= totalQuantity %> items):</span>
                                            <span>MYR <%= String.format("%.2f", dailySubtotal) %></span>
                                        </div>
                                        <div class="summary-row">
                                            <span>SST (6%):</span>
                                            <span>MYR <%= String.format("%.2f", dailySst) %></span>
                                        </div>
                                        <div class="summary-row">
                                            <span>Delivery Fee:</span>
                                            <span>MYR <%= String.format("%.2f", dailyDeliveryFee) %></span>
                                        </div>
                                        <div class="summary-row grand-total">
                                            <span>Grand Total:</span>
                                            <span>MYR <%= String.format("%.2f", dailyGrandTotal) %></span>
                                        </div>
                                    </div>
                                    
                                    <div class="comment-box">
                                        <h3>Leave a Review</h3>
                                        <%
                                            for (Purchase p : dailyPurchases) {
                                                Product product = productDA.getRecord(p.getProductId());
                                                if (product != null) {
                                        %>
                                        <div style="margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
                                            <p><strong><%= product.getProductName() %></strong></p>

                                            <form action="ReviewServlet" method="post" onsubmit="return validateReviewForm(this, <%= p.getPurchaseId() %>)">
                                                <input type="hidden" name="purchaseId" value="<%= p.getPurchaseId() %>">
                                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">

                                                <div class="rating-container">
                                                    <p>Rate this product:</p>
                                                    <div class="rating-stars">
                                                        <input type="radio" id="star5-<%= p.getPurchaseId() %>" name="rating" value="5">
                                                        <label for="star5-<%= p.getPurchaseId() %>" title="5 stars">★</label>
                                                        <input type="radio" id="star4-<%= p.getPurchaseId() %>" name="rating" value="4">
                                                        <label for="star4-<%= p.getPurchaseId() %>" title="4 stars">★</label>
                                                        <input type="radio" id="star3-<%= p.getPurchaseId() %>" name="rating" value="3">
                                                        <label for="star3-<%= p.getPurchaseId() %>" title="3 stars">★</label>
                                                        <input type="radio" id="star2-<%= p.getPurchaseId() %>" name="rating" value="2">
                                                        <label for="star2-<%= p.getPurchaseId() %>" title="2 stars">★</label>
                                                        <input type="radio" id="star1-<%= p.getPurchaseId() %>" name="rating" value="1">
                                                        <label for="star1-<%= p.getPurchaseId() %>" title="1 star">★</label>
                                                    </div>
                                                </div>

                                                <textarea name="comment" rows="4" placeholder="Share your experience with this product... (optional)"></textarea>
                                                <div class="action-buttons">
                                                    <button type="submit" class="submit-comment">Submit Review</button>
                                                </div>
                                            </form>
                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } 
                %>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
    
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this purchase?");
        }
        // Initialize star rating hover effect
        document.addEventListener('DOMContentLoaded', function() {
            const ratingContainers = document.querySelectorAll('.rating-stars');

            ratingContainers.forEach(container => {
                const stars = container.querySelectorAll('label');
                const inputs = container.querySelectorAll('input');

                stars.forEach(star => {
                    star.addEventListener('mouseover', function() {
                        const currentId = this.getAttribute('for');
                        const currentInput = container.querySelector('#' + currentId);
                        const currentValue = parseInt(currentInput.value);

                        stars.forEach(s => {
                            const sId = s.getAttribute('for');
                            const sInput = container.querySelector('#' + sId);
                            if (parseInt(sInput.value) >= currentValue) {
                                s.style.color = '#ffcc00';
                            } else {
                                s.style.color = '#ddd';
                            }
                        });
                    });

                    star.addEventListener('mouseout', function() {
                        const checked = container.querySelector('input:checked');
                        stars.forEach(s => {
                            s.style.color = checked ? 
                                (parseInt(s.previousElementSibling.value) <= parseInt(checked.value) ? '#ffcc00' : '#ddd') 
                                : '#ddd';
                        });
                    });

                    star.addEventListener('click', function() {
                        const currentId = this.getAttribute('for');
                        const currentInput = container.querySelector('#' + currentId);
                        currentInput.checked = true;

                        // Update colors after click
                        const checkedValue = parseInt(currentInput.value);
                        stars.forEach(s => {
                            const sInput = container.querySelector('#' + s.getAttribute('for'));
                            s.style.color = parseInt(sInput.value) <= checkedValue ? '#ffcc00' : '#ddd';
                        });
                    });
                });
            });
        });
        
            // Validate review form before submission
        function validateReviewForm(form, purchaseId) {
            // Find the rating container for this specific form
            const ratingContainer = form.querySelector('.rating-stars');
            const ratingSelected = ratingContainer.querySelector('input[name="rating"]:checked');

            if (!ratingSelected) {
                alert("Please select a star rating before submitting your review.");
                return false;
            }

            return true;
        }

    </script>
</body>
</html>