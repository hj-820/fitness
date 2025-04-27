/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

/**
 *
 * @author Hong Jie
 */

import domain.Staff;
import java.sql.*;
import java.util.*;

public class StaffDA {
    private static final String JDBC_URL  = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER   = "nbuser";
    private static final String DB_PASS   = "nbuser";
    private static final String TABLE     = "STAFF";

    private Connection conn;
    private PreparedStatement stmt;

    public StaffDA() throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
    }
    
    public List<Staff> getAllRecords() throws SQLException {
    List<Staff> list = new ArrayList<>();
    String sql = "SELECT * FROM " + TABLE + " ORDER BY STAFFID";
    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(new Staff(
                rs.getString("STAFFID"),
                rs.getString("NAME"),
                rs.getString("PHONE"),
                rs.getString("EMAIL"),
                rs.getString("PASSWORD"),
                rs.getString("POSITION"),
                rs.getDouble("SALARY")
            ));
        }
    }
    return list;
}


    public void addRecord(Staff s) throws SQLException {
        String sql = "INSERT INTO " + TABLE + " (STAFFID, NAME, PHONE, EMAIL, PASSWORD, POSITION, SALARY) VALUES (?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, s.getStaffId());
        stmt.setString(2, s.getStaffName());
        stmt.setString(3, s.getPhone());
        stmt.setString(4, s.getEmail());
        stmt.setString(5, s.getPassword());
        stmt.setString(6, s.getPosition());
        stmt.setDouble(7, s.getSalary());
        stmt.executeUpdate();
    }

    public Staff getRecord(String id) throws SQLException {
        String sql = "SELECT * FROM " + TABLE + " WHERE STAFFID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        ResultSet rs = stmt.executeQuery();
        Staff s = null;
        if (rs.next()) {
            s = new Staff(
                rs.getString("STAFFID"),
                rs.getString("NAME"),
                rs.getString("PHONE"),
                rs.getString("EMAIL"),
                rs.getString("PASSWORD"),
                rs.getString("POSITION"),
                rs.getDouble("SALARY")
            );
        }
        rs.close();
        return s;
    }

    public void updateRecord(Staff s) throws SQLException {
        String sql = "UPDATE " + TABLE + " SET NAME = ?, PHONE = ?, EMAIL = ?, PASSWORD = ?, POSITION = ?, SALARY = ? WHERE STAFFID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, s.getStaffName());
        stmt.setString(2, s.getPhone());
        stmt.setString(3, s.getEmail());
        stmt.setString(4, s.getPassword());
        stmt.setString(5, s.getPosition());
        stmt.setDouble(6, s.getSalary());
        stmt.setString(7, s.getStaffId());
        stmt.executeUpdate();
    }

    public void deleteRecord(String id) throws SQLException {
        String sql = "DELETE FROM " + TABLE + " WHERE STAFFID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        stmt.executeUpdate();
    }

    public void close() throws SQLException {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
}

