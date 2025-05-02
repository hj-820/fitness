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

    private Connection conn;

    public CommentDA() throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
    }

    // Method to get all comments for a specific product
    public List<Comment> getCommentsByProduct(int productId) throws SQLException {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM " + COMMENT_TABLE + " WHERE PRODUCT_ID = ? ORDER BY TIMESTAMP DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setCommentId(rs.getInt("COMMENT_ID"));
                    comment.setProductId(rs.getInt("PRODUCT_ID"));
                    comment.setCustomerId(rs.getInt("CUSTOMER_ID"));
                    comment.setCommentText(rs.getString("COMMENT_TEXT"));
                    comment.setTimestampr(rs.getTimestamp("TIMESTAMP"));
                    comment.setReplyText(rs.getString("REPLY_TEXT"));
                    comment.setRating(rs.getInt("RATING"));
                    comments.add(comment);
                }
            }
        }
        return comments;
    }

    // Method to add a new comment using individual parameters
    public void addComment(int productId, int customerId, String commentText, int rating) {
        String sql = "INSERT INTO " + COMMENT_TABLE +
                     " (PRODUCT_ID, CUSTOMER_ID, COMMENT_TEXT, RATING, TIMESTAMP) " +
                     "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, customerId);
            stmt.setString(3, commentText);
            stmt.setInt(4, rating);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to add a new comment using Comment object
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO COMMENTS (PRODUCT_ID, CUSTOMER_ID, COMMENT_TEXT, RATING, TIMESTAMP) " +
                     "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, comment.getProductId());
            stmt.setInt(2, comment.getCustomerId());
            stmt.setString(3, comment.getCommentText());
            stmt.setInt(4, comment.getRating());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to update a reply to an existing comment
    public boolean addReplyToComment(int commentId, String replyText) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE COMMENTS SET REPLY_TEXT = ? WHERE COMMENT_ID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, replyText);
            stmt.setInt(2, commentId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

}

