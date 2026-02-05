<%@ page import="java.util.List, com.university.model.Course" %>
<%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = java.util.Collections.emptyList();
    String msg = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Faculty - Manage Courses</title></head>
<body>
<h2>Faculty: Manage Courses</h2>
<% if (msg != null) { %><p style="color:green;"><%= msg %></p><% } %>
<% if (error != null) { %><p style="color:red;"><%= error %></p><% } %>
<table border="1" cellpadding="6">
<tr><th>ID</th><th>Code</th><th>Name</th><th>Instructor</th><th>Schedule</th><th>Action</th></tr>
<% for (Course c : courses) { %>
<tr>
<td><%= c.getCourseId() %></td>
<td><%= c.getCourseCode() %></td>
<td><%= c.getCourseName() %></td>
<td><%= c.getInstructor() %></td>
<td><%= c.getSchedule() %></td>
<td><a href="faculty?id=<%= c.getCourseId() %>">Edit</a></td>
</tr>
<% } %>
</table>
<p><a href="index.jsp">Home</a></p>
</body>
</html>
