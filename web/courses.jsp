<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.university.model.Course"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Courses | University Portal</title>
    <link rel="stylesheet" href="css/style.css">
    <script defer src="js/app.js"></script>
</head>

<%
    /* ===== LOGIN STATE ===== */

    String role = (String) session.getAttribute("role");
    boolean loggedIn = role != null;

    /* ===== COURSE LIST ===== */

    List<Course> courses =
        (List<Course>) request.getAttribute("courses");

    if (courses == null) {
        courses = new java.util.ArrayList<Course>();
    }
%>

<body class="theme-dark <%= loggedIn ? "logged-in" : "logged-out" %>">

<header class="page-header">

<div>
    <h1>Course Catalog</h1>
    <p>Animated cards with live search and filters.</p>
</div>

<div class="header-actions">

<a class="btn ghost" href="index.jsp">
    Dashboard
</a>

<% if (loggedIn) { %>
<a class="btn ghost logged-in-only" href="logout">
    Logout
</a>
<% } %>

<button class="toggle" id="themeToggle" type="button">
    Toggle Mode
</button>

</div>
</header>

<main class="container">

<!-- ===== SEARCH ===== -->
<div class="search-bar">
<input
    type="search"
    id="courseSearch"
    placeholder="Search by code, name, instructor, or schedule..."
>
</div>

<!-- ===== COURSE CARDS ===== -->
<section class="card-grid" id="courseList">

<%
for (Course course : courses) {

    String code =
        course.getCourseCode() == null ? "" : course.getCourseCode();

    String name =
        course.getCourseName() == null ? "" : course.getCourseName();

    String instructor =
        course.getInstructor() == null ? "" : course.getInstructor();

    String schedule =
        course.getSchedule() == null ? "" : course.getSchedule();
%>

<article
class="glass-card course-card"
data-search="<%= code %> <%= name %> <%= instructor %> <%= schedule %>"
>

<div class="chip"><%= code %></div>

<h2><%= name %></h2>

<p>
<strong>Instructor:</strong>
<%= instructor %>
</p>

<p>
<strong>Schedule:</strong>
<%= schedule %>
</p>

</article>

<%
}
%>

</section>
</main>
</body>
</html>
