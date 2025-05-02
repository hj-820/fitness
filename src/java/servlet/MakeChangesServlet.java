/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.StaffDA;
import domain.Staff;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/MakeChangesServlet")
public class MakeChangesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get current staff ID from session
        String staffId = (String) session.getAttribute("id");
        if (staffId == null) {
            response.sendRedirect("staffLogin.jsp");
            return;
        }
        
        // Get form parameters
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        
        try {
            StaffDA staffDA = new StaffDA();
            
            // Get the current staff record
            Staff staff = staffDA.getRecord(staffId);
            if (staff == null) {
                session.setAttribute("error", "Staff record not found");
                response.sendRedirect("Manager.jsp");
                return;
            }
            
            // Update the fields that can be changed
            staff.setPhone(phone);
            staff.setEmail(email);
            
            // Update the record in database
            staffDA.updateRecord(staff);
            
            // Update session attributes
            session.setAttribute("phone", phone);
            session.setAttribute("email", email);
            
            // Close DA connection
            staffDA.close();
            
            // Redirect with success message
            response.sendRedirect("Manager.jsp?updated=true");
            
        } catch (SQLException ex) {
            // Handle database errors
            session.setAttribute("error", "Database error: " + ex.getMessage());
            response.sendRedirect("Manager.jsp");
        } catch (Exception ex) {
            // Handle other errors
            session.setAttribute("error", "Error updating profile: " + ex.getMessage());
            response.sendRedirect("Manager.jsp");
        }
    }
}