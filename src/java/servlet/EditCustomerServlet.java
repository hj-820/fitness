/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CustomerDA;
import domain.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/EditCustomerServlet")
public class EditCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);

        CustomerDA customerDA = null;
        try {
            customerDA = new CustomerDA();

            if ("edit".equalsIgnoreCase(action)) {
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");

                // Create Customer object and update
                Customer customer = new Customer();
                customer.setCustomerId(id);
                customer.setName(name);
                customer.setPhone(phone);
                customer.setEmail(email);

                customerDA.updateCustomer(customer);

            } else if ("delete".equalsIgnoreCase(action)) {
                customerDA.deleteCustomer(id);
            }

            response.sendRedirect("customer.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (customerDA != null) {
                    customerDA.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
