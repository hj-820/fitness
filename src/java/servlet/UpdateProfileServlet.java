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
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String fullName = (String) session.getAttribute("fullName"); // Used to identify the customer

        if (fullName == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        try {
            CustomerDA customerDA = new CustomerDA();
            Customer customer = customerDA.getCustomerByName(fullName); // You must implement this method

            if (customer == null) {
                response.sendRedirect("profile.jsp?error=Customer not found");
                return;
            }

            // Validate current password
            if (!currentPassword.equals(customer.getPassword())) {
                response.sendRedirect("profile.jsp?error=Current password is incorrect");
                return;
            }

            // If new password is provided, validate it
            String updatedPassword = currentPassword; // default to current
            if (newPassword != null && !newPassword.isEmpty()) {
                if (newPassword.length() < 8) {
                    response.sendRedirect("profile.jsp?error=New password must be at least 8 characters");
                    return;
                }
                updatedPassword = newPassword;
            }

            customerDA.updateCustomerPass(fullName, phone, email, updatedPassword);

            // Optionally update session info (except password)
            session.setAttribute("phone", phone);
            session.setAttribute("email", email);

            response.sendRedirect("profile.jsp?success=Profile updated successfully");

        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("profile.jsp?error=Database error occurred");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("profile.jsp?error=An unexpected error occurred");
        }
    }
}

