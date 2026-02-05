<%@ page import="java.util.List, com.university.model.Course, com.university.model.Student" %>
<%
    Student s = (Student) request.getAttribute("student");
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title><%= s != null ? s.getFirstName()+"'s Schedule" : "Student" %></title></head>
<body>
<h2>Student Schedule</h2>
<% if (s != null) { %>
    <p><strong>Name:</strong> <%= s.getFirstName() + " " + s.getLastName() %></p>
    <p><strong>Email:</strong> <%= s.getEmail() %></p>
    <h3>Enrolled Courses</h3>
    <table border="1" cellpadding="6">
        <tr><th>Code</th><th>Name</th><th>Instructor</th><th>Schedule</th></tr>
        <% for (Course c : courses) { %>
            <tr>
                <td><%= c.getCourseCode() %></td>
                <td><%= c.getCourseName() %></td>
                <td><%= c.getInstructor() %></td>
                <td><%= c.getSchedule() %></td>
            </tr>
        <% } %>
    </table>
<% } else { %>
    <p>No student info to show.</p>
<% } %>
<p><a href="student">Lookup another student</a> | <a href="index.jsp">Home</a></p>
</body>
</html>
