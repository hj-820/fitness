<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    if (session.getAttribute("staffId") == null) {
        response.sendRedirect("staffLogin.jsp");
        return;
    }

    int staffId = (Integer) session.getAttribute("staffId");
    String fullName = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    
    // Format last login
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, yyyy 'at' hh:mm a");
    String lastLogin = "Never";
    
    // Database connection to get staff details
    java.sql.Connection conn = null;
    java.sql.Prepared