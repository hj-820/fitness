/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;


import da.PurchaseDA;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeletePurchaseServlet")
public class DeletePurchaseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Validate user session
        Integer customerId = (Integer) session.getAttribute("id");
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get purchase ID from request
        String purchaseIdParam = request.getParameter("purchaseId");
        if (purchaseIdParam == null || purchaseIdParam.isEmpty()) {
            session.setAttribute("error", "Invalid purchase ID");
            response.sendRedirect("purchaseHistory.jsp");
            return;
        }
        
        try {
            int purchaseId = Integer.parseInt(purchaseIdParam);
            PurchaseDA purchaseDA = new PurchaseDA();
            
            // Verify the purchase belongs to the current customer
            boolean purchaseBelongsToCustomer = purchaseDA.getPurchasesByCustomerId(customerId)
                .stream()
                .anyMatch(p -> p.getPurchaseId() == purchaseId);
            
            if (!purchaseBelongsToCustomer) {
                session.setAttribute("error", "You can only delete your own purchases");
                response.sendRedirect("purchaseHistory.jsp");
                return;
            }
            
            // Delete the purchase record
            boolean deleted = purchaseDA.deletePurchase(purchaseId);
            
            // Close DA connection
            purchaseDA.close();
            
            if (deleted) {
                session.setAttribute("success", "Purchase deleted successfully");
            } else {
                session.setAttribute("error", "Failed to delete purchase");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid purchase ID format");
        } catch (SQLException ex) {
            session.setAttribute("error", "Database error: " + ex.getMessage());
        } catch (Exception ex) {
            session.setAttribute("error", "Error deleting purchase: " + ex.getMessage());
        }
        
        response.sendRedirect("purchaseHistory.jsp");
    }
}