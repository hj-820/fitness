/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CommentDA;
import da.PurchaseDA;
import domain.Comment;
import domain.Purchase;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer customerId = (Integer) session.getAttribute("id");
        if (customerId == null) {
            response.sendRedirect("fitnessLogin.jsp");
            return;
        }

        String purchaseIdStr = request.getParameter("purchaseId");
        String productIdStr = request.getParameter("productId");
        String commentText = request.getParameter("comment");
        String ratingStr = request.getParameter("rating"); // Changed from rating-{purchaseId}

        try {
            if (purchaseIdStr == null || productIdStr == null || ratingStr == null) {
                session.setAttribute("error", "Missing required fields");
                response.sendRedirect("purchaseHistory.jsp");
                return;
            }

            int purchaseId = Integer.parseInt(purchaseIdStr);
            int productId = Integer.parseInt(productIdStr);
            int rating = Integer.parseInt(ratingStr);

            PurchaseDA purchaseDA = new PurchaseDA();
            Purchase purchase = purchaseDA.getPurchaseById(purchaseId);

            if (purchase == null || purchase.getCustomerId() != customerId) {
                session.setAttribute("error", "Invalid purchase");
                response.sendRedirect("purchaseHistory.jsp");
                return;
            }

            // Build comment
            Comment comment = new Comment();
            comment.setProductId(productId);
            comment.setCustomerId(customerId);
            comment.setCommentText(commentText != null ? commentText : "");
            comment.setTimestampr(new Timestamp(new Date().getTime()));
            comment.setReplyText(null);
            comment.setRating(rating);

            // Save comment
            CommentDA commentDA = new CommentDA();
            boolean success = commentDA.addComment(comment);

            if (success) {
                session.setAttribute("success", "Thank you for your review!");
            } else {
                session.setAttribute("error", "Failed to submit review");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid input format");
        } catch (SQLException | ClassNotFoundException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "Error submitting review: " + e.getMessage());
        }

        response.sendRedirect("purchaseHistory.jsp");
    }
}