/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

/**
 *
 * @author Hong Jie
 */

import domain.Product;
import java.sql.*;
import java.util.*;

public class ProductDA {
    private static final String JDBC_URL  = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER   = "nbuser";
    private static final String DB_PASS   = "nbuser";
    private static final String TABLE     = "PRODUCTS";

    private Connection conn;
    private PreparedStatement stmt;

    public ProductDA() throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
    }
    
    public List<Product> getAllRecords() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE;
        stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Product p = new Product(
                rs.getInt("ID"),
                rs.getString("NAME"),
                rs.getDouble("PRICE"),
                rs.getString("CATEGORY"),
                rs.getString("DESCRIPTION"),
                rs.getString("IMG_URL")
            );
            products.add(p);
        }
        rs.close();
        return products;
    }

    public void addRecord(Product p) throws SQLException {
        String sql = "INSERT INTO " + TABLE + " (NAME, PRICE, CATEGORY, DESCRIPTION, IMG_URL) VALUES (?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, p.getProductName());
        stmt.setDouble(2, p.getPrice());
        stmt.setString(3, p.getCategory());
        stmt.setString(4, p.getDescription());
        stmt.setString(5, p.getImgUrl());
        stmt.executeUpdate();
    }

    public Product getRecord(int id) throws SQLException {
        String sql = "SELECT * FROM " + TABLE + " WHERE ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        Product p = null;
        if (rs.next()) {
            p = new Product(
                rs.getInt   ("ID"),
                rs.getString("NAME"),
                rs.getDouble("PRICE"),
                rs.getString("CATEGORY"),
                rs.getString("DESCRIPTION"),
                rs.getString("IMG_URL")
            );
        }
        rs.close();
        return p;
    }

    public void updateRecord(Product p) throws SQLException {
        String sql = "UPDATE " + TABLE + " SET NAME = ?, PRICE = ?, CATEGORY = ?, DESCRIPTION = ?, IMG_URL = ? WHERE ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, p.getProductName());
        stmt.setDouble(2, p.getPrice());
        stmt.setString(3, p.getCategory());
        stmt.setString(4, p.getDescription());
        stmt.setString(5, p.getImgUrl());
        stmt.setInt   (6, p.getProductId());
        stmt.executeUpdate();
    }

    public void deleteRecord(int id) throws SQLException {
        String sql = "DELETE FROM " + TABLE + " WHERE ID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public void close() throws SQLException {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
}

