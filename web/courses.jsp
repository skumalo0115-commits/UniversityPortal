<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.university.model.Course"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Courses | University Portal</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <script defer src="<%= request.getContextPath() %>/js/app.js"></script>
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

<body class="theme-dark <%= loggedIn ? "logged-in" : "logged-out" %>" data-context-path="<%= request.getContextPath() %>">

<header class="page-header">

<div>
    <h1>Course Catalog</h1>
    <p>Animated cards with live search and filters.</p>
</div>

<div class="header-actions">

<a class="btn ghost" href="<%= request.getContextPath() %>/index.jsp">
    Dashboard
</a>

<% if (loggedIn) { %>
<a class="btn ghost logged-in-only" href="<%= request.getContextPath() %>/logout">
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
