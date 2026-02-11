<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.university.model.Course"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Faculty Console | University Portal</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <script defer src="<%= request.getContextPath() %>/js/app.js"></script>
</head>
<%
    String role = (String) session.getAttribute("role");
    boolean loggedIn = role != null && !role.trim().isEmpty();
    boolean isStudent = "student".equalsIgnoreCase(role);

    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = new ArrayList<Course>();

    List<Course> updatedCourses = (List<Course>) session.getAttribute("updatedCourses");
    if (updatedCourses == null) updatedCourses = new ArrayList<Course>();

    String message = (String) request.getAttribute("message");
    if (message == null) message = "";
%>
<body class="theme-dark <%= loggedIn ? "logged-in" : "logged-out" %>" data-context-path="<%= request.getContextPath() %>">
    <header class="page-header">
        <div>
            <h1>Faculty Console</h1>
            <p>Update instructors and schedules with secure validation.</p>
        </div>
        <div class="header-actions">
            <a class="btn ghost" href="<%= request.getContextPath() %>/index.jsp">Dashboard</a>
            <% if (loggedIn) { %>
                <a class="btn ghost logged-in-only" href="<%= request.getContextPath() %>/logout">Logout</a>
            <% } %>
            <button class="toggle" id="themeToggle" type="button">Toggle Dark Mode</button>
        </div>
    </header>

    <main class="container">
        <section class="glass-card">
            <form class="form" id="facultyForm" action="<%= request.getContextPath() %>/faculty" method="post" data-ajax="true">
                <label for="courseId">Course</label>
                <select id="courseId" name="courseId" class="styled-select" required <%= isStudent ? "disabled" : "" %>>
                    <option value="">Select a course</option>
                    <% for (Course course : courses) { %>
                        <option value="<%= course.getCourseId() %>"><%= course.getCourseCode() %> - <%= course.getCourseName() %></option>
                    <% } %>
                </select>

                <label for="instructor">Instructor</label>
                <input type="text" id="instructor" name="instructor" placeholder="e.g., Dr. Morgan" required <%= isStudent ? "disabled" : "" %>>

                <label for="schedule">Schedule</label>
                <input type="text" id="schedule" name="schedule" placeholder="e.g., Mon/Wed 10:00 - 11:30" required <%= isStudent ? "disabled" : "" %>>

                <button class="btn primary" type="submit" <%= isStudent ? "disabled" : "" %>>Update Course</button>
            </form>

            <% if (isStudent) { %>
                <div class="banner warning">Access restricted to lecturer accounts.</div>
            <% } %>

            <div class="status"><%= message %></div>
        </section>

        <section class="glass-card">
            <h2>Recently Updated Courses</h2>
            <p class="muted">Only updated courses will appear here until you reload.</p>
            <div id="updatedCoursesList" class="card-grid compact-grid">
                <% if (updatedCourses.isEmpty()) { %>
                    <p id="updatedCoursesEmpty" class="muted">No courses updated yet.</p>
                <% } else { %>
                    <% for (Course course : updatedCourses) { %>
                        <article class="glass-card course-card">
                            <div class="chip"><%= course.getCourseCode() %></div>
                            <h2><%= course.getCourseName() %></h2>
                            <p><strong>Instructor:</strong> <%= course.getInstructor() %></p>
                            <p><strong>Schedule:</strong> <%= course.getSchedule() %></p>
                        </article>
                    <% } %>
                <% } %>
            </div>
        </section>

        <section class="card-grid">
            <% for (Course course : courses) { %>
                <article class="glass-card course-card">
                    <div class="chip"><%= course.getCourseCode() %></div>
                    <h2><%= course.getCourseName() %></h2>
                    <p><strong>Instructor:</strong> <%= course.getInstructor() %></p>
                    <p><strong>Schedule:</strong> <%= course.getSchedule() %></p>
                </article>
            <% } %>
        </section>
    </main>
</body>
</html>

