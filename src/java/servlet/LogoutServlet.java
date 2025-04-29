/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processLogout(request, response);
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            logLogoutActivity(session); // Optional: log activity
            

            session.invalidate(); // Clear and invalidate session

            // Prevent caching
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        }

        response.sendRedirect("home1.jsp?logout=success");
    }

    private void logLogoutActivity(HttpSession session) {
        try {
            String userType = (String) session.getAttribute("userType");
            String userId = (String) session.getAttribute("id");
            String userName = (String) session.getAttribute("fullName");

            if (userType != null && userId != null) {
                // Example: Logging to server logs (you can log to DB if needed)
                getServletContext().log("User logged out - Type: " + userType + ", ID: " + userId + ", Name: " + userName);
            }
        } catch (Exception e) {
            getServletContext().log("Error logging logout activity", e);
        }
    }
}