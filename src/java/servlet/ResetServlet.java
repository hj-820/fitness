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

@WebServlet("/ResetServlet")
public class ResetServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate inputs
        if (email == null || email.isEmpty() || 
            newPassword == null || newPassword.isEmpty() || 
            confirmPassword == null || confirmPassword.isEmpty()) {
            response.sendRedirect("forgotpassword.jsp?error=All fields are required");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("forgotpassword.jsp?error=Passwords do not match");
            return;
        }
        
        try {
            CustomerDA customerDA = new CustomerDA();
            Customer customer = customerDA.getCustomerByEmail(email);
            
            if (customer == null) {
                response.sendRedirect("forgotpassword.jsp?error=Email not found in our system");
                return;
            }
            
            // Update the password (note: in production, you should hash the password)
            customerDA.updateCustomerPassword(customer.getCustomerId(), newPassword);
            
            // Redirect with success message
            response.sendRedirect("fitnessLogin.jsp?success=Password has been reset successfully");
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("forgotpassword.jsp?error=Database error occurred. Please try again.");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("forgotpassword.jsp?error=An unexpected error occurred");
        }
    }
}