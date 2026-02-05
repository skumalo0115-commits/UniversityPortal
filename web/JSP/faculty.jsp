<%@ page import="java.util.List, com.university.model.Course" %>
<%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = java.util.Collections.emptyList();
    String msg = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty - Manage Courses</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>
<div class="portal-shell">
    <header class="portal-header">
        <div class="portal-brand">
            <div class="portal-logo">UP</div>
            <div>
                <h1>Faculty Dashboard</h1>
                <p>Course updates and instructor assignments</p>
            </div>
        </div>
        <nav class="portal-nav">
            <a href="../index.jsp">Home</a>
            <a href="../courses">Course Catalog</a>
            <a href="../student">Student Center</a>
        </nav>
    </header>

    <main class="portal-content">
        <section class="page-title">
            <h2>Manage Courses</h2>
            <p>Edit instructor details and schedules for active course sections.</p>
        </section>

        <% if (msg != null) { %>
            <div class="alert alert-success"><%= msg %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Code</th>
                    <th>Course Name</th>
                    <th>Instructor</th>
                    <th>Schedule</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <% for (Course c : courses) { %>
                <tr>
                    <td><%= c.getCourseId() %></td>
                    <td><%= c.getCourseCode() %></td>
                    <td><%= c.getCourseName() %></td>
                    <td><%= c.getInstructor() %></td>
                    <td><%= c.getSchedule() %></td>
                    <td><a class="secondary-action" href="faculty?id=<%= c.getCourseId() %>">Edit</a></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </main>

    <footer class="portal-footer">
        <span>Updates are applied immediately.</span>
        <span><a href="../index.jsp">Return to dashboard</a></span>
    </footer>
</div>
</body>
</html>
