package domain;

import java.sql.Timestamp;

public class Comment {
    private int commentId;
    private int productId;
    private int customerId;
    private String commentText;
    private Timestamp timestampr; // Changed from timestamp
    private String replyText;
    private int rating;

    // Getters and Setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public Timestamp getTimestampr() {
        return timestampr;
    }

    public void setTimestampr(Timestamp timestampr) {
        this.timestampr = timestampr;
    }

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}