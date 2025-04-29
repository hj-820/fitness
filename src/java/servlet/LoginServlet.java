/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.CustomerDA;
import da.StaffDA;
import domain.Customer;
import domain.Staff;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    response.setContentType("text/plain"); // Always respond with plain text

    try {
        CustomerDA customerDA = new CustomerDA();
        StaffDA staffDA = new StaffDA();

        // Try logging in as customer
        Customer customer = customerDA.getCustomerByEmail(email);
        if (customer != null && customer.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("id", customer.getCustomerId());
            session.setAttribute("fullName", customer.getName());
            session.setAttribute("email", customer.getEmail());
            session.setAttribute("userType", "customer");

            response.setContentType("text/html");
            response.getWriter().write("<script>window.parent.postMessage('LOGIN_SUCCESS', '*');</script>");

        } else {
            // Try logging in as staff
            boolean staffLoginSuccess = false;
            for (Staff staff : staffDA.getAllRecords()) {
                if (staff.getEmail().equals(email) && staff.getPassword().equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("id", staff.getStaffId());
                    session.setAttribute("fullName", staff.getStaffName());
                    session.setAttribute("email", staff.getEmail());
                    session.setAttribute("phone", staff.getPhone());

                    String role = staff.getPosition().equalsIgnoreCase("manager") ? "manager" : "staff";
                    session.setAttribute("userType", role);

                    response.setContentType("text/html");
                    response.getWriter().write("<script>window.parent.postMessage('STAFF_LOGIN_SUCCESS', '*');</script>");
                    staffLoginSuccess = true;
                    break;
                }
            }

            if (!staffLoginSuccess) {
                response.getWriter().write("LOGIN_FAILED");
            }
        }

        customerDA.close();
        staffDA.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("DATABASE_ERROR");
    }
}
}