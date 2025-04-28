/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

/**
 *
 * @author Hong Jie
 */

import domain.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDA {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER  = "nbuser";
    private static final String DB_PASS  = "nbuser";
    private static final String COMMENT_TABLE = "COMMENTS";
    private static final String CUSTOMER_TABLE = "CUSTOMER";

    private Connection conn;
    
    public CommentDA() throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
    }

    // Method to get all comments for a product
    public List<Comment> getCustomerComments(int productId) throws SQLException {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.COMMENT_ID, c.COMMENT_TEXT, c.REPLY_TEXT, c.TIMESTAMP, c.RATING, cu.NAME, cu.EMAIL "
                   + "FROM " + COMMENT_TABLE + " c "
                   + "JOIN " + CUSTOMER_TABLE + " cu ON c.CUSTOMER_ID = cu.ID "
                   + "WHERE c.PRODUCT_ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setCommentId(rs.getInt("COMMENT_ID"));
                    comment.setCommentText(rs.getString("COMMENT_TEXT"));
                    comment.setReplyText(rs.getString("REPLY_TEXT"));
                    comment.setTimestamp(rs.getTimestamp("TIMESTAMP"));
                    comment.setRating(rs.getInt("RATING")); // <<< Added rating here
                    comment.setCustomerName(rs.getString("NAME"));
                    comment.setCustomerEmail(rs.getString("EMAIL"));
                    comments.add(comment);
                }
            }
        }
        return comments;
    }

    // Method to add a new comment
    public void addComment(int productId, int customerId, String commentText, int rating) {
        String sql = "INSERT INTO " + COMMENT_TABLE + " (PRODUCT_ID, CUSTOMER_ID, COMMENT_TEXT, RATING, TIMESTAMP) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, customerId);
            stmt.setString(3, commentText);
            stmt.setInt(4, rating); // <<< Insert rating
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to add a reply to a comment
    public void addReply(int commentId, String replyText) {
        String sql = "UPDATE " + COMMENT_TABLE + " SET REPLY_TEXT = ? WHERE COMMENT_ID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, replyText);
            stmt.setInt(2, commentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
