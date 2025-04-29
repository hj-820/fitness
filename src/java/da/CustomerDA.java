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

    public CustomerDA() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("JDBC Driver not found", ex);
        }
    }

    /**
     * Retrieve all customers (without passwords for security)
     */
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT ID, NAME, EMAIL, PHONE FROM " + TABLE;
        
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        }
        return customers;
    }

    /**
     * Get customer by email with password (for authentication)
     */
    public Customer getCustomerByEmail(String email) throws SQLException {
        
        String sql = "SELECT ID, NAME, EMAIL, PHONE, PASSWORD FROM " + TABLE + " WHERE EMAIL = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        }
        return null;
    }

    /**
     * Get customer by ID (without password for security)
     */
    public Customer getCustomerById(int id) throws SQLException {
        String sql = "SELECT ID, NAME, EMAIL, PHONE FROM " + TABLE + " WHERE ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        }
        return null;
    }

    /**
     * Add a new customer with password
     */
    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO " + TABLE + " (NAME, EMAIL, PHONE, PASSWORD) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getPassword());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating customer failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    customer.setCustomerId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating customer failed, no ID obtained.");
                }
            }
        }
    }

    /**
     * Update customer basic info (without password)
     */
    public void updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE " + TABLE + " SET NAME = ?, EMAIL = ?, PHONE = ? WHERE ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setInt(4, customer.getCustomerId());
            
            stmt.executeUpdate();
        }
    }

    /**
     * Update customer password
     */
    public void updateCustomerPassword(int customerId, String newPassword) throws SQLException {
        String sql = "UPDATE " + TABLE + " SET PASSWORD = ? WHERE ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, customerId);
            
            stmt.executeUpdate();
        }
    }

    /**
     * Delete a customer by ID
     */
    public void deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM " + TABLE + " WHERE ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    /**
     * Helper method to map ResultSet to Customer object
     */
    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("ID"));
        customer.setName(rs.getString("NAME"));
        customer.setEmail(rs.getString("EMAIL"));
        customer.setPhone(rs.getString("PHONE"));
        
        try {
            // Password might not be selected in all queries
            customer.setPassword(rs.getString("PASSWORD"));
        } catch (SQLException e) {
            // Password column not selected - this is normal for some queries
        }
        
        
        return customer;
    }

    /**
     * Clean up resources
     */
    public void close() {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}