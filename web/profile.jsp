<%-- 
    Document   : profile
    Created on : 11 Apr 2025, 16:14:19
    Author     : Hong Jie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String name = (String) session.getAttribute("name");
    String phone = (String) session.getAttribute("phone");
    String email = (String) session.getAttribute("email");
    String position = (String) session.getAttribute("position");
%>

<h2>Edit Profile</h2>

<form action="UpdateServlet" method="post" onsubmit="return confirmChanges()">
    Name: <input type="text" name="name" value="<%= name %>" readonly><br>
    Phone: <input type="text" name="phone" value="<%= phone %>"><br>
    Email: <input type="email" name="email" value="<%= email %>"><br>
    Position: <input type="text" name="position" value="<%= position %>" readonly><br>
    <button type="submit">Make Changes</button>
</form>

<script>
    function confirmChanges() {
        return confirm("Are you sure you want to make these changes?");
    }
</script>
