<%-- 
    Document   : report
    Created on : 20 Apr 2025, 23:12:39
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
<%@ page import="java.util.*, java.sql.*, java.text.*" %>

<%-- Define a simple JavaBean-style class inside the JSP --%>
<%! 
    public class Product {
        private String name;
        private int quantity;

        public Product(String name, int quantity) {
            this.name = name;
            this.quantity = quantity;
        }

        public String getName() {
            return name;
        }

        public int getQuantity() {
            return quantity;
        }
    }
%>

<%
    String role = "Manager";
    boolean isManager = "Manager".equalsIgnoreCase(role);

    String JDBC_URL = "jdbc:derby://localhost:1527/Fitness";
    String DB_USER = "nbuser";
    String DB_PASS = "nbuser";

    double dailyRevenue = 0;
    double monthlyRevenue = 0;
    double yearlyRevenue = 0;
    List topProducts = new ArrayList();

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
        Statement stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery("SELECT SUM(amount) FROM purchase WHERE purchase_date = CURRENT_DATE");
        if (rs.next()) dailyRevenue = rs.getDouble(1);
        rs.close();

        rs = stmt.executeQuery("SELECT SUM(amount) FROM purchase WHERE EXTRACT(MONTH FROM purchase_date) = EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM purchase_date) = EXTRACT(YEAR FROM CURRENT_DATE)");
        if (rs.next()) monthlyRevenue = rs.getDouble(1);
        rs.close();

        rs = stmt.executeQuery("SELECT SUM(amount) FROM purchase WHERE EXTRACT(YEAR FROM purchase_date) = EXTRACT(YEAR FROM CURRENT_DATE)");
        if (rs.next()) yearlyRevenue = rs.getDouble(1);
        rs.close();

        rs = stmt.executeQuery("SELECT product_name, COUNT(*) AS quantity_sold FROM purchase GROUP BY product_name ORDER BY quantity_sold DESC");

        int count = 0;
        while (rs.next() && count < 10) {
            String name = rs.getString("product_name");
            int qty = rs.getInt("quantity_sold");
            Product p = new Product(name, qty);
            topProducts.add(p);
            count++;
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sales Report</title>
    <style>
        * { box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background-color: #f4f6f8; margin: 0; }
        .header { background-color: rgba(253,53,160,255); padding: 15px 30px; color: white; display: flex; align-items: center; }
        .header img { height: 100px; margin-right: 20px; }
        .header-text { font-size: 18px; }
        .user-menu { margin-left: auto; position: relative; cursor: pointer; }
        .login-icon { height: 40px; width: 85px; border-radius: 50%; }
        .dropdown { display: none; position: absolute; right: 0; top: 80px; background-color: white; border: 1px solid #ccc; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.2); z-index: 999; }
        .dropdown a { display: block; padding: 10px 15px; text-decoration: none; color: #333; }
        .dropdown a:hover { background-color: #f1f1f1; }
        .container { display: flex; }
        .sidebar { width: 220px; background-color: #2c3e50; padding: 20px; color: #fff; height: 100vh; }
        .sidebar h2 { margin-bottom: 30px; font-size: 24px; text-align: center; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar ul li { margin: 20px 0; }
        .sidebar ul li a { color: #ecf0f1; text-decoration: none; font-size: 18px; display: block; padding: 10px; border-radius: 5px; transition: background 0.3s; }
        .sidebar ul li a:hover { background-color: #34495e; }
        .main-content { flex: 1; padding: 30px; }
        .section { background-color: white; padding: 25px; border-radius: 8px; margin-bottom: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h1, h2 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        table th, table td { padding: 10px 15px; border: 1px solid #ccc; }
        table th { background-color: #ecf0f1; }
        .revenue-amount { font-size: 24px; color: green; font-weight: bold; }
        .no-access { color: red; font-size: 20px; font-weight: bold; text-align: center; margin-top: 50px; }
    </style>
</head>
<body>

    <div class="main-content">
        <% if (!isManager) { %>
            <div class="no-access">You do not have permission to access this page.</div>
        <% } else { %>

            <div class="section">
                <h1>Sales Revenue Overview</h1>
                <p><strong>Today's Revenue:</strong> <span class="revenue-amount">RM <%= new DecimalFormat("###,##0.00").format(dailyRevenue) %></span></p>
                <p><strong>This Month's Revenue:</strong> <span class="revenue-amount">RM <%= new DecimalFormat("###,##0.00").format(monthlyRevenue) %></span></p>
                <p><strong>This Year's Revenue:</strong> <span class="revenue-amount">RM <%= new DecimalFormat("###,##0.00").format(yearlyRevenue) %></span></p>
            </div>

            <div class="section">
                <h2>Top 10 Best-Selling Products</h2>
                <table>
                    <tr>
                        <th>Rank</th>
                        <th>Product Name</th>
                        <th>Quantity Sold</th>
                    </tr>
                    <%
                        int rank = 1;
                        for (int i = 0; i < topProducts.size(); i++) {
                            Product p = (Product) topProducts.get(i);
                    %>
                    <tr>
                        <td><%= rank++ %></td>
                        <td><%= p.getName() %></td>
                        <td><%= p.getQuantity() %></td>
                    </tr>
                    <% } %>
                </table>
            </div>

        <% } %>
    </div>

    <script>
        function toggleDropdown() {
            var dropdown = document.getElementById("userDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }
    </script>
    <jsp:include page="footer.jsp"/>
</body>
</html>