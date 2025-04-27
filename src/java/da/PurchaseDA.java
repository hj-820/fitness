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
    private static final String JDBC_URL = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER  = "nbuser";
    private static final String DB_PASS  = "nbuser";
    private static final String TABLE    = "PURCHASE";

    private Connection conn;
    private PreparedStatement stmt;

    public PurchaseDA() throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
    }
    
     public List<Purchase> getPurchasesByCustomerId(int customerId) throws SQLException {
        String sql = "SELECT PURCHASE_ID, PRODUCT_NAME, AMOUNT, PURCHASE_DATE "
                   + "FROM PURCHASE WHERE CUSTOMERID = ? ORDER BY PURCHASE_DATE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
          stmt.setInt(1, customerId);
          try (ResultSet rs = stmt.executeQuery()) {
            List<Purchase> list = new ArrayList<>();
            while (rs.next()) {
              Purchase p = new Purchase();
              p.setPurchaseId(rs.getInt("PURCHASE_ID"));
              p.setProductName(rs.getString("PRODUCT_NAME"));
              p.setAmount(rs.getDouble("AMOUNT"));
              p.setPurchaseDate(rs.getDate("PURCHASE_DATE"));
              list.add(p);
            }
            return list;
          }
        }
     }

    // ADD (INSERT)
    public void addRecord(Purchase p) throws SQLException {
        String sql = "INSERT INTO " + TABLE + " (PURCHASE_ID, PRODUCT_NAME, AMOUNT, PURCHASE_DATE) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, p.getPurchaseId());
        stmt.setString(2, p.getProductName());
        stmt.setDouble(3, p.getAmount());
        stmt.setDate(4, new java.sql.Date(p.getPurchaseDate().getTime()));
        stmt.executeUpdate();
        stmt.close();
    }

    // RETRIEVE (SELECT)
    public Purchase getRecord(int purchaseId) throws SQLException {
        String sql = "SELECT * FROM " + TABLE + " WHERE PURCHASE_ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, purchaseId);
        ResultSet rs = stmt.executeQuery();
        Purchase p = null;
        if (rs.next()) {
            p = new Purchase(
                rs.getInt("PURCHASE_ID"),
                rs.getString("PRODUCT_NAME"),
                rs.getDouble("AMOUNT"),
                rs.getDate("PURCHASE_DATE")
            );
        }
        rs.close();
        stmt.close();
        return p;
    }

    // UPDATE
    public void updateRecord(Purchase p) throws SQLException {
        String sql = "UPDATE " + TABLE + " SET PRODUCT_NAME = ?, AMOUNT = ?, PURCHASE_DATE = ? WHERE PURCHASE_ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, p.getProductName());
        stmt.setDouble(2, p.getAmount());
        stmt.setDate(3, new java.sql.Date(p.getPurchaseDate().getTime()));
        stmt.setInt(4, p.getPurchaseId());
        stmt.executeUpdate();
        stmt.close();
    }

    // DELETE
    public void deleteRecord(int purchaseId) throws SQLException {
        String sql = "DELETE FROM " + TABLE + " WHERE PURCHASE_ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, purchaseId);
        stmt.executeUpdate();
        stmt.close();
    }

    // CLEANUP
    public void close() throws SQLException {
        if (conn != null) conn.close();
    }
}


