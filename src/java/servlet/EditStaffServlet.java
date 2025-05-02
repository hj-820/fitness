/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.StaffDA;
import domain.Staff;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/EditStaffServlet")
public class EditStaffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");  // Fix: get the correct "action"
        String staffID = request.getParameter("staffID");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        double salary = Double.parseDouble(request.getParameter("salary"));

        try {
            StaffDA staffDA = new StaffDA();

            if ("update".equals(action)) {
                // First, get the existing record to keep the staffName
                Staff existingStaff = staffDA.getRecord(staffID);
                if (existingStaff != null) {
                    Staff updatedStaff = new Staff(
                        staffID,
                        existingStaff.getStaffName(), // Keep the original staff name (readonly in JSP)
                        phone,
                        email,
                        password,
                        position,
                        salary
                    );
                    staffDA.updateRecord(updatedStaff);
                }
                response.sendRedirect("manageStaff.jsp");

            } else if ("delete".equals(action)) {
                staffDA.deleteRecord(staffID);
                response.sendRedirect("manageStaff.jsp");
            }

            staffDA.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
