/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.ProductDA;
import domain.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (idParam == null || idParam.isEmpty()) {
                out.println("<script>alert('Invalid Product ID.'); window.history.back();</script>");
                return;
            }

            int id = Integer.parseInt(idParam);

            ProductDA productDA = new ProductDA();

            if ("update".equals(action)) {
                String priceStr = request.getParameter("price");
                String description = request.getParameter("description");
                String imgUrl = request.getParameter("img_url");

                double price;
                try {
                    price = Double.parseDouble(priceStr);
                } catch (NumberFormatException e) {
                    out.println("<script>alert('Invalid price format.'); window.history.back();</script>");
                    productDA.close();
                    return;
                }

                // Get the existing product
                Product product = productDA.getRecord(id);
                if (product == null) {
                    out.println("<script>alert('Product not found.'); window.location='product.jsp';</script>");
                    productDA.close();
                    return;
                }

                // Update product fields
                product.setPrice(price);
                product.setDescription(description);
                product.setImgUrl(imgUrl);

                // Save update
                productDA.updateRecord(product);
                productDA.close();

                out.println("<script>alert('Product updated successfully.'); window.location='product.jsp';</script>");

            } else if ("delete".equals(action)) {
                // Delete product
                productDA.deleteRecord(id);
                productDA.close();

                out.println("<script>alert('Product deleted successfully.'); window.location='product.jsp';</script>");
            } else {
                out.println("<script>alert('Invalid action.'); window.history.back();</script>");
                productDA.close();
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format.");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
