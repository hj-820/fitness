/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
*/
package servlet;

import da.CustomerDA;
import domain.Customer;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve customer details from the form
        String name = request.getParameter("custName");
        String email = request.getParameter("custEmail");
        String phone = request.getParameter("custPhone");

        // Create a new Customer object with the retrieved data
        Customer customer = new Customer();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);

        // Initialize CustomerDA and add the new customer record
        try {
            CustomerDA customerDA = new CustomerDA();
            customerDA.addCustomer(customer);
            customerDA.close();
            
            // Redirect to a success page or confirmation page
            response.sendRedirect("customer.jsp");  // Redirect to a page that shows all customers
        } catch (SQLException | ClassNotFoundException e) {
            // Handle any SQL or ClassNotFound exceptions
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while adding customer.");
        }
    }
}
