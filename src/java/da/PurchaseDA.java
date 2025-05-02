/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

/**
 *
 * @author Hong Jie
 */

import domain.Purchase;
import java.sql.*;
import java.util.*;

public class PurchaseDA {
    private Connection conn;

    public PurchaseDA() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            this.conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/Fitness", 
                "nbuser", 
                "nbuser"
            );
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found", e);
        }
    }

    public List<Purchase> getPurchasesByCustomerId(int customerId) throws SQLException {
        List<Purchase> purchases = new ArrayList<>();
        String sql = "SELECT * FROM PURCHASE WHERE CUSTOMERID = ? ORDER BY PURCHASE_DATE DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Purchase purchase = new Purchase();
                    purchase.setPurchaseId(rs.getInt("PURCHASE_ID"));
                    purchase.setAmount(rs.getDouble("AMOUNT"));
                    purchase.setPurchaseDate(rs.getString("PURCHASE_DATE"));
                    purchase.setCustomerId(rs.getInt("CUSTOMERID"));
                    purchase.setProductId(rs.getInt("PRODUCT_ID"));
                    purchase.setQuantity(rs.getInt("QUANTITY"));
                    purchase.setCustomerName(rs.getString("CUSTOMER_NAME"));
                    purchase.setCustomerPhone(rs.getString("CUSTOMER_PHONE"));
                    purchase.setCustomerAddress(rs.getString("CUSTOMER_ADDRESS"));
                    purchases.add(purchase);
                }
            }
        }
        return purchases;
    }

    public boolean addPurchase(Purchase purchase) throws SQLException {
        String sql = "INSERT INTO PURCHASE (AMOUNT, PURCHASE_DATE, CUSTOMERID, PRODUCT_ID, QUANTITY, "
                   + "CUSTOMER_NAME, CUSTOMER_PHONE, CUSTOMER_ADDRESS) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, purchase.getAmount());
            stmt.setString(2, purchase.getPurchaseDate());
            stmt.setInt(3, purchase.getCustomerId());
            stmt.setInt(4, purchase.getProductId());
            stmt.setInt(5, purchase.getQuantity());
            stmt.setString(6, purchase.getCustomerName());
            stmt.setString(7, purchase.getCustomerPhone());
            stmt.setString(8, purchase.getCustomerAddress());

            return stmt.executeUpdate() > 0;
        }
    }

    public Purchase getPurchaseById(int purchaseId) throws SQLException {
        String sql = "SELECT * FROM PURCHASE WHERE PURCHASE_ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, purchaseId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Purchase purchase = new Purchase();
                    purchase.setPurchaseId(rs.getInt("PURCHASE_ID"));
                    purchase.setAmount(rs.getDouble("AMOUNT"));
                    purchase.setPurchaseDate(rs.getString("PURCHASE_DATE"));
                    purchase.setCustomerId(rs.getInt("CUSTOMERID"));
                    purchase.setProductId(rs.getInt("PRODUCT_ID"));
                    purchase.setQuantity(rs.getInt("QUANTITY"));
                    purchase.setCustomerName(rs.getString("CUSTOMER_NAME"));
                    purchase.setCustomerPhone(rs.getString("CUSTOMER_PHONE"));
                    purchase.setCustomerAddress(rs.getString("CUSTOMER_ADDRESS"));
                    return purchase;
                }
                return null;
            }
        }
    }

    public boolean updatePurchase(Purchase purchase) throws SQLException {
        String sql = "UPDATE PURCHASE SET AMOUNT = ?, PURCHASE_DATE = ?, CUSTOMERID = ?, PRODUCT_ID = ?, "
                   + "QUANTITY = ?, CUSTOMER_NAME = ?, CUSTOMER_PHONE = ?, CUSTOMER_ADDRESS = ? "
                   + "WHERE PURCHASE_ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, purchase.getAmount());
            stmt.setString(2, purchase.getPurchaseDate());
            stmt.setInt(3, purchase.getCustomerId());
            stmt.setInt(4, purchase.getProductId());
            stmt.setInt(5, purchase.getQuantity());
            stmt.setString(6, purchase.getCustomerName());
            stmt.setString(7, purchase.getCustomerPhone());
            stmt.setString(8, purchase.getCustomerAddress());
            stmt.setInt(9, purchase.getPurchaseId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deletePurchase(int purchaseId) throws SQLException {
        String sql = "DELETE FROM PURCHASE WHERE PURCHASE_ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, purchaseId);
            return stmt.executeUpdate() > 0;
        }
    }

    public void close() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }
}
