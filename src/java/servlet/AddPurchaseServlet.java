/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.PurchaseDA;
import domain.Purchase;
import da.CartDA;
import domain.CartItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/AddPurchaseServlet")
public class AddPurchaseServlet extends HttpServlet {
    private static final String JDBC_URL  = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER   = "nbuser";
    private static final String DB_PASS   = "nbuser";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer customerId = (session != null) ? (Integer)session.getAttribute("id") : null;

        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            return;
        }

        // Read form fields
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String method = request.getParameter("paymentMethod");
        String subtotalStr = request.getParameter("subtotal");
        double subtotal = Double.parseDouble(subtotalStr);

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
            CartDA cartDA = new CartDA();
            List<CartItem> cartItems = cartDA.getCartItemsByCustomerId(customerId);

            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/home.jsp");
                return;
            }

            PurchaseDA purchaseDA = new PurchaseDA();
            String today = java.time.LocalDate.now().toString();

            for (CartItem ci : cartItems) {
                Purchase p = new Purchase();
                p.setAmount(ci.getTotalPrice());
                p.setPurchaseDate(today);
                p.setCustomerId(customerId);
                p.setProductId(Integer.parseInt(ci.getProductId()));
                p.setQuantity(ci.getQuantity());
                p.setCustomerName(name);
                p.setCustomerPhone(phone);
                p.setCustomerAddress(address);
                purchaseDA.addPurchase(p);
            }

            // Clear cart records from ORDER_ITEMS
            cartDA.clearCartByCustomerId(customerId);

        } catch (Exception e) {
            throw new ServletException("Error during purchase confirmation", e);
        }

        // Notify user and redirect
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write(
            "<script>alert('Purchase successful!'); window.location='" + request.getContextPath() + "/purchaseHistory.jsp';</script>"
        );
    }
}