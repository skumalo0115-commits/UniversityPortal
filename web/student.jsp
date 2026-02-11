<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.university.model.Course"%>
<%@page import="com.university.model.Student"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Student Schedule | University Portal</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <script defer src="<%= request.getContextPath() %>/js/app.js"></script>
</head>

<%
    /* ===== SAFE ACCESS CONTROL ===== */

    Boolean deniedObj = (Boolean) request.getAttribute("accessDenied");
    boolean accessDenied = deniedObj != null && deniedObj;

    String role = (String) session.getAttribute("role");
    boolean loggedIn = role != null;

    String message = (String) request.getAttribute("message");
    if (message == null) message = "";

    /* ===== STUDENT OBJECT ===== */

    Student student =
        (Student) request.getAttribute("student");

    if (student == null) {
        student = new Student();
    }

    /* ===== STUDENT COURSES ===== */

    List<Course> studentCourses =
        (List<Course>) request.getAttribute("studentCourses");

    if (studentCourses == null) {
        studentCourses = new java.util.ArrayList<Course>();
    }

    /* ===== UPDATED COURSES ===== */

    List<Course> updatedCourses =
        (List<Course>) session.getAttribute("updatedCourses");

    if (updatedCourses == null) {
        updatedCourses = new java.util.ArrayList<Course>();
    }
%>

<body class="theme-dark <%= loggedIn ? "logged-in" : "logged-out" %>">

<header class="page-header">
    <div>
        <h1>Student Schedule</h1>
        <p>Enter your student ID to view your personalized schedule.</p>
    </div>

    <div class="header-actions">
        <a class="btn ghost" href="index.jsp">Dashboard</a>

        <% if (loggedIn) { %>
            <a class="btn ghost logged-in-only" href="logout">Logout</a>
        <% } %>

        <button class="toggle" id="themeToggle" type="button">
            Toggle Dark Mode
        </button>
    </div>
</header>

<main class="container">

<!-- ===== SEARCH FORM ===== -->
<section class="glass-card spaced-card">

<form class="form" action="student" method="post">

<label for="studentId">Student ID</label>

<input
    type="number"
    id="studentId"
    name="studentId"
    placeholder="Enter student ID"
    required
    <%= accessDenied ? "disabled" : "" %>
>

<button
    class="btn primary"
    type="submit"
    <%= accessDenied ? "disabled" : "" %>>
    View Schedule
</button>

</form>

<% if (accessDenied) { %>
<div class="banner warning">
    Access restricted to student accounts.
</div>
<% } %>

<div class="status"><%= message %></div>

</section>

<!-- ===== STUDENT DETAILS ===== -->
<section class="glass-card spaced-card">

<h2>Student Details</h2>

<div class="details">

<div>
    <span class="label">Name</span>
    <p>
        <%= student.getFirstName() == null ? "" : student.getFirstName() %>
        <%= student.getLastName() == null ? "" : student.getLastName() %>
    </p>
</div>

<div>
    <span class="label">Email</span>
    <p>
        <%= student.getEmail() == null ? "" : student.getEmail() %>
    </p>
</div>

</div>
</section>

<!-- ===== UPDATED MODULES ===== -->
<section class="glass-card spaced-card">

<h2>Updated Modules</h2>

<p class="muted">
    These modules were recently updated by lecturers.
</p>

<ul class="status-list">

<%
    if (!updatedCourses.isEmpty()) {

        for (Course course : updatedCourses) {
%>

<li>
    <strong><%= course.getCourseCode() %></strong>
    - <%= course.getCourseName() %>
</li>

<%
        }

    } else {
%>

<li>No updates have been posted yet.</li>

<%
    }
%>

</ul>
</section>

<!-- ===== STUDENT SCHEDULE ===== -->
<section class="card-grid">

<%
    for (Course course : studentCourses) {
%>

<article class="glass-card course-card">

<div class="chip">
    <%= course.getCourseCode() %>
</div>

<h2><%= course.getCourseName() %></h2>

<p>
    <strong>Instructor:</strong>
    <%= course.getInstructor() == null ? "" : course.getInstructor() %>
</p>

<p>
    <strong>Schedule:</strong>
    <%= course.getSchedule() == null ? "" : course.getSchedule() %>
</p>

</article>

<%
    }
%>

</section>

</main>
</body>
</html>
