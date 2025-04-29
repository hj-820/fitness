/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CustomerDA;
import domain.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hong Jie
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            CustomerDA customerDA = new CustomerDA();
            
            // Check customer login (using plain text password for now - see note below)
            Customer customer = customerDA.getCustomerByEmail(email);
            
            if (customer != null && customer.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("id", customer.getCustomerId());
                session.setAttribute("fullName", customer.getName());
                session.setAttribute("email", customer.getEmail());
                session.setAttribute("userType", "customer");
                
                
                response.sendRedirect("MainDashboard.jsp");
            } else {
                response.sendRedirect("fitnessLogin.jsp?error=Invalid email or password");
            }
            
            customerDA.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("fitnessLogin.jsp?error=Database error occurred");
        }
    }
}

