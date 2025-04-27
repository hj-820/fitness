/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.ProductDA;
import domain.Product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/Fitness";
    private static final String DB_USER = "nbuser";
    private static final String DB_PASS = "nbuser";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String imgUrl = request.getParameter("img_url");

        try {
            double price = Double.parseDouble(priceStr);
            Product product = new Product(0, name, price, category, description, imgUrl); // ID is set to 0

            ProductDA productDA = new ProductDA();
            productDA.addRecord(product);
            productDA.close();

            response.sendRedirect("product.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}

