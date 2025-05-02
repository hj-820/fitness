/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CartDA;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EditCartServlet")
public class EditCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String productId = request.getParameter("productId");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = (Integer) session.getAttribute("id");
        CartDA cartDA = new CartDA();

        switch (action) {
            case "increaseQuantity": {
                int currentQty = cartDA.getQuantityByProductIdAndCustomerId(productId, customerId);
                cartDA.updateQuantityByProductIdAndCustomerId(productId, customerId, currentQty + 1);
                break;
            }
            case "decreaseQuantity": {
                int currentQty = cartDA.getQuantityByProductIdAndCustomerId(productId, customerId);
                if (currentQty > 1) {
                    cartDA.updateQuantityByProductIdAndCustomerId(productId, customerId, currentQty - 1);
                } else {
                    // If quantity is 1 and user clicks '-', delete the item
                    cartDA.deleteCartItemByProductIdAndCustomerId(productId, customerId);
                }
                break;
            }
            case "removeFromCart": {
                cartDA.deleteCartItemByProductIdAndCustomerId(productId, customerId);
                break;
            }
            default:
                break;
        }

        response.sendRedirect("cart.jsp");
    }
}