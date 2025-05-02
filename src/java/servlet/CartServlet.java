/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CartDA;
import domain.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private final CartDA cartDA = new CartDA();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) get current customerId from session
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("id");
        if (customerId == null) {
            // not logged in
            response.sendRedirect("fitnessLogin.jsp");
            return;
        }

        // 2) pull form params
        String productId   = request.getParameter("productId");
        String productName = request.getParameter("productName");
        double price       = Double.parseDouble(request.getParameter("price"));
        String imgUrl      = request.getParameter("image");    // hidden field
        int    qtyToAdd    = Integer.parseInt(request.getParameter("quantity"));

        // 3) fetch existing items for this user
        int currentQuantity = cartDA.getQuantityByProductIdAndCustomerId(productId,customerId);
        int updateQuantity =0;

        // 4) see if there's already an entry for this product


        if (currentQuantity != 0) {
            // 5a) update quantity
            updateQuantity = currentQuantity + qtyToAdd;
            cartDA.updateQuantityByProductIdAndCustomerId(productId,customerId,updateQuantity);
        } else {
            // 5b) create brand new entry
            CartItem newItem = new CartItem(productId,productName,qtyToAdd,price,customerId,imgUrl);
            cartDA.addCartItem(newItem);
        }

        // 6) forward to cart.jsp
        response.sendRedirect("cart.jsp");
    }
}