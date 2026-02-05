<%@ page import="java.util.List, com.university.model.Course" %>
<%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>All Courses</title></head>
<body>
<h2>Available Courses</h2>
<table border="1" cellpadding="6">
<tr><th>ID</th><th>Code</th><th>Name</th><th>Instructor</th><th>Schedule</th></tr>
<% for (Course c : courses) { %>
<tr>
<td><%= c.getCourseId() %></td>
<td><%= c.getCourseCode() %></td>
<td><%= c.getCourseName() %></td>
<td><%= c.getInstructor() %></td>
<td><%= c.getSchedule() %></td>
</tr>
<% } %>
</table>
<p><a href="index.jsp">Back</a></p>
</body>
</html>
