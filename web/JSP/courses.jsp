<%@ page import="java.util.List, com.university.model.Course" %>
<%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Courses</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>
<div class="portal-shell">
    <header class="portal-header">
        <div class="portal-brand">
            <div class="portal-logo">UP</div>
            <div>
                <h1>University Portal</h1>
                <p>Course catalog and enrollment data</p>
            </div>
        </div>
        <nav class="portal-nav">
            <a href="../index.jsp">Home</a>
            <a href="../student">Student Center</a>
            <a href="../faculty">Faculty Dashboard</a>
        </nav>
    </header>

    <main class="portal-content">
        <section class="page-title">
            <h2>Available Courses</h2>
            <p>Review all courses currently offered across departments and programs.</p>
        </section>

        <section class="card section">
            <div class="meta-list">
                <span class="pill">Updated hourly</span>
                <span>Registrar • Academic Affairs</span>
                <span>Contact: registrar@university.edu</span>
            </div>
        </section>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Code</th>
                    <th>Course Name</th>
                    <th>Instructor</th>
                    <th>Schedule</th>
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
                </tr>
            <% } %>
            </tbody>
        </table>
    </main>

    <footer class="portal-footer">
        <span>Catalog data refreshed hourly.</span>
        <span><a href="../index.jsp">Return to dashboard</a></span>
    </footer>
</div>
</body>
</html>
