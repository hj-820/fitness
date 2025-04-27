/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

/**
 *
 * @author Hong Jie
 */

import domain.Customer;
import java.sql.*;
import java.util.*;

public class CustomerDA {
    private static final String JDBC_URL = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER  = "nbuser";
    private static final String DB_PASS  = "nbuser";
    private static final String TABLE    = "CUSTOMER";

    private Connection conn;
    private PreparedStatement stmt;

    public CustomerDA() throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
    }

    /**
     * Retrieve all customers (only basic customer info)
     */
    public List<Customer> getAllCustomer() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT ID, NAME, EMAIL, PHONE FROM " + TABLE;
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("ID"));
                c.setName(rs.getString("NAME"));
                c.setEmail(rs.getString("EMAIL"));
                c.setPhone(rs.getString("PHONE"));
                customers.add(c);
            }
        }
        return customers;
    }

    /**
     * Retrieve a single customer by ID
     */
    public Customer getRecord(int id) throws SQLException {
        String sql = "SELECT ID, NAME, EMAIL, PHONE FROM " + TABLE + " WHERE ID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setCustomerId(rs.getInt("ID"));
                    c.setName(rs.getString("NAME"));
                    c.setEmail(rs.getString("EMAIL"));
                    c.setPhone(rs.getString("PHONE"));
                    return c;
                }
            }
        }
        return null;
    }

    /**
     * Add a new customer
     */
    public void addRecord(Customer c) throws SQLException {
        String sql = "INSERT INTO " + TABLE + " (NAME, EMAIL, PHONE) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getName());  
            stmt.setString(2, c.getEmail()); 
            stmt.setString(3, c.getPhone()); 

            stmt.executeUpdate();
        }
    }

    /**
     * Update an existing customer
     */
    public void updateRecord(Customer c) throws SQLException {
        String sql = "UPDATE " + TABLE + " SET NAME = ?, EMAIL = ?, PHONE = ? WHERE ID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getName());
            stmt.setString(2, c.getEmail());
            stmt.setString(3, c.getPhone());
            stmt.setInt(4, c.getCustomerId());
            stmt.executeUpdate();
        }
    }

    /**
     * Delete a customer by ID
     */
    public void deleteRecord(int id) throws SQLException {
        String sql = "DELETE FROM " + TABLE + " WHERE ID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    /**
     * Clean up connection
     */
    public void close() throws SQLException {
        if (conn != null) conn.close();
    }
}


