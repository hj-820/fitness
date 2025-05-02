/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CommentDA;
import domain.Comment;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReplyServlet")
public class ReplyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is manager/staff
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if (userType == null || (!userType.equalsIgnoreCase("manager") && !userType.equalsIgnoreCase("staff"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only staff/manager can reply to comments");
            return;
        }
        
        // Get parameters from request
        String replyText = request.getParameter("reply");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        
        // Validate input
        if (replyText == null || replyText.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Reply text cannot be empty");
            response.sendRedirect("productDetail.jsp?productId=" + productId);
            return;
        }
        
        try {
            // Update the comment with the reply
            CommentDA commentDA = new CommentDA();
            boolean success = commentDA.addReplyToComment(commentId, replyText);
            
            if (success) {
                // Redirect back to product page with success message
                session.setAttribute("successMessage", "Reply posted successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to post reply");
            }
            
            response.sendRedirect("productDetail.jsp?productId=" + productId);
            
        } catch (SQLException | ClassNotFoundException ex) {
            // Log the error
            ex.printStackTrace();
            // Set error message and redirect
            session.setAttribute("errorMessage", "Database error occurred");
            response.sendRedirect("productDetail.jsp?productId=" + productId);
        }
    }
}