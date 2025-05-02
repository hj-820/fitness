/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CustomerDA;
import domain.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get and sanitize parameters
        String email = request.getParameter("email").trim().toLowerCase();
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName").trim();
        String phone = request.getParameter("phone").trim();

        // Validate required fields
        if (email.isEmpty() || password.isEmpty() || fullName.isEmpty()) {
            response.sendRedirect("fitnessRegister.jsp?error=Required fields are missing");
            return;
        }

        // Simple email validation
        if (!email.contains("@") || !email.contains(".")) {
            response.sendRedirect("fitnessRegister.jsp?error=Invalid email format");
            return;
        }

        // Simple password validation (at least 8 characters)
        if (password.length() < 8) {
            response.sendRedirect("fitnessRegister.jsp?error=Password must be at least 8 characters");
            return;
        }

        CustomerDA customerDA = null;
        
        try {
            customerDA = new CustomerDA();

            // Check if email already exists
            if (customerDA.getCustomerByEmail(email) != null) {
                response.sendRedirect("fitnessRegister.jsp?error=Email already registered");
                return;
            }

            // Create and add new customer
            Customer newCustomer = new Customer();
            newCustomer.setName(fullName);
            newCustomer.setEmail(email);
            newCustomer.setPhone(phone);
            
            // Store password directly (not recommended for production)
            newCustomer.setPassword(password);

            customerDA.addCustomer(newCustomer);
            
            // Set success message and redirect
            request.getSession().setAttribute("registrationSuccess", "Registration successful! Please login.");
            response.sendRedirect("fitnessLogin.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fitnessRegister.jsp?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("fitnessRegister.jsp?error=Unexpected error: " + e.getMessage());
        } finally {
            if (customerDA != null) {
                customerDA.close();
            }
        }
    }
}
