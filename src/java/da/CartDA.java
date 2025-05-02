/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;
import domain.CartItem;
import java.sql.*;
import java.util.ArrayList;

public class CartDA {
    
    private final String dbURL = "jdbc:derby://localhost:1527/Fitness"; // Replace with your DB
    private final String dbUser = "nbuser"; // Replace with DB user
    private final String dbPass = "nbuser"; // Replace with DB password

    public CartDA() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Add cart item
    public void addCartItem(CartItem item) {
        String sql = "INSERT INTO ORDER_ITEMS (PRODUCT_ID, PRODUCT_NAME, QUANTITY, PRICE, CUSTOMER_ID, IMG_URL) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Remove the itemId from the insert statement since it's auto-incremented
            stmt.setString(1, item.getProductId());
            stmt.setString(2, item.getProductName());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getCustomerId());
            stmt.setString(6, item.getImgUrl());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get all cart items by customer ID
    public ArrayList<CartItem> getCartItemsByCustomerId(int customerId) {
        ArrayList<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM ORDER_ITEMS WHERE CUSTOMER_ID = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String itemId = rs.getString("ITEM_ID");
                String productId = rs.getString("PRODUCT_ID");
                String productName = rs.getString("PRODUCT_NAME");
                int quantity = rs.getInt("QUANTITY");
                double price = rs.getDouble("PRICE");
                String imgUrl = rs.getString("IMG_URL");

                CartItem item = new CartItem(productId, productName, quantity, price, customerId, imgUrl);
                cartItems.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }
    
    public int getQuantityByProductIdAndCustomerId(String productId, int customerId) {
        int quantity = 0;
        String sql = "SELECT QUANTITY FROM ORDER_ITEMS WHERE PRODUCT_ID = ? AND CUSTOMER_ID = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, productId);
            stmt.setInt(2, customerId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                quantity = rs.getInt("QUANTITY");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return quantity;
    }
    
    

    // Update cart item by item ID
    public void updateCartItem(CartItem item) {
        String sql = "UPDATE ORDER_ITEMS SET PRODUCT_ID = ?, PRODUCT_NAME = ?, QUANTITY = ?, PRICE = ?, CUSTOMER_ID = ?, IMG_URL = ? WHERE ITEM_ID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getProductId());
            stmt.setString(2, item.getProductName());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getCustomerId());
            stmt.setString(7, item.getImgUrl());
            stmt.setString(8, item.getItemId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateQuantityByProductIdAndCustomerId(String productId, int customerId, int newQuantity) {
        String sql = "UPDATE ORDER_ITEMS SET QUANTITY = ? WHERE PRODUCT_ID = ? AND CUSTOMER_ID = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, newQuantity);
            stmt.setString(2, productId);
            stmt.setInt(3, customerId);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete cart item by item ID
    public void deleteCartItem(String itemId) {
        String sql = "DELETE FROM ORDER_ITEMS WHERE ITEM_ID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, itemId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteCartItemByProductIdAndCustomerId(String productId, int customerId) {
        String sql = "DELETE FROM ORDER_ITEMS WHERE PRODUCT_ID = ? AND CUSTOMER_ID = ?";
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, productId);
            stmt.setInt(2, customerId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void clearCartByCustomerId(int customerId) {
        String sql = "DELETE FROM ORDER_ITEMS WHERE CUSTOMER_ID = ?";
        try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Fitness", "nbuser", "nbuser");
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
