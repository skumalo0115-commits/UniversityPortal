<%@ page import="com.university.model.Course" %>
<%
    Course course = (Course) request.getAttribute("course");
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Edit Course</title></head>
<body>
<h2>Edit Course</h2>
<% if (course != null) { %>
<form action="faculty" method="post">
    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>" />
    <p>Course Code: <strong><%= course.getCourseCode() %></strong></p>
    <p>Course Name: <strong><%= course.getCourseName() %></strong></p>
    <p>Instructor: <input type="text" name="instructor" value="<%= course.getInstructor() %>" /></p>
    <p>Schedule: <input type="text" name="schedule" value="<%= course.getSchedule() %>" /></p>
    <input type="submit" value="Update Course" />
</form>
<% } else { %>
<p>Course not found.</p>
<% } %>
<p><a href="faculty">Back to course list</a></p>
</body>
</html>
