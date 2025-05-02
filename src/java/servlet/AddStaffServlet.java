/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import da.StaffDA;
import domain.Staff;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddStaffServlet")
public class AddStaffServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String staffName = request.getParameter("staffName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        String salaryStr = request.getParameter("salary");
        double salary = 0;
        String password = "password123"; // Default password
        String nextID = "S001"; // Default if no staff exists yet

        try {
            salary = Double.parseDouble(salaryStr);

            StaffDA staffDA = new StaffDA();

            // Check if email already exists
            List<Staff> staffList = staffDA.getAllRecords();
            for (Staff s : staffList) {
                if (s.getEmail().equalsIgnoreCase(email)) {
                    response.getWriter().println("<h3>Error: Email already exists. Please use a different email.</h3>");
                    staffDA.close();
                    return;
                }
            }

            // Generate next staffID
            if (!staffList.isEmpty()) {
                Staff lastStaff = staffList.get(staffList.size() - 1); // Already ordered by STAFFID
                String lastID = lastStaff.getStaffId(); // e.g., S009
                int num = Integer.parseInt(lastID.substring(1)); // get 9
                nextID = String.format("S%03d", num + 1); // e.g., S010
            }

            // Create new Staff object
            Staff newStaff = new Staff();
            newStaff.setStaffId(nextID);
            newStaff.setStaffName(staffName);
            newStaff.setPhone(phone);
            newStaff.setEmail(email);
            newStaff.setPassword(password);
            newStaff.setPosition(position);
            newStaff.setSalary(salary);

            // Insert using StaffDA
            staffDA.addRecord(newStaff);
            staffDA.close();

            response.sendRedirect("manageStaff.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
