/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.ProductDA;
import domain.Product;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get search query from request
        String searchQuery = request.getParameter("searchQuery");
        
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }
        
        try {
            ProductDA productDA = new ProductDA();
            
            // Search for products by name (case-insensitive)
            List<Product> products = productDA.searchProductsByName(searchQuery);
            
            if (products.isEmpty()) {
                // No products found - show alert and redirect back
                response.getWriter().println("<script>alert('No products found matching: " + searchQuery + "'); window.location.href='home.jsp';</script>");
            } else if (products.size() == 1) {
                // Single product found - redirect to product detail page
                response.sendRedirect("productDetail.jsp?productId=" + products.get(0).getProductId());
            } 
            
            productDA.close();
            
        } catch (SQLException | ClassNotFoundException ex) {
            // Handle database errors
            response.sendRedirect("error.jsp?message=Database error: " + ex.getMessage());
        }
    }
}