<%@ page import="java.util.List, com.university.model.Course, com.university.model.Student" %>
<%
    Student s = (Student) request.getAttribute("student");
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) courses = java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= s != null ? s.getFirstName()+"'s Schedule" : "Student" %></title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>
<div class="portal-shell">
    <header class="portal-header">
        <div class="portal-brand">
            <div class="portal-logo">UP</div>
            <div>
                <h1>Student Center</h1>
                <p>Course schedules and enrollment details</p>
            </div>
        </div>
        <nav class="portal-nav">
            <a href="../index.jsp">Home</a>
            <a href="../courses">Course Catalog</a>
            <a href="../faculty">Faculty Dashboard</a>
        </nav>
    </header>

    <main class="portal-content">
        <section class="page-title">
            <h2>Student Schedule</h2>
            <p>Review registered courses, instructors, and weekly meeting times.</p>
        </section>

        <% if (s != null) { %>
            <section class="card section">
                <h3><%= s.getFirstName() + " " + s.getLastName() %></h3>
                <div class="meta-list">
                    <span><strong>Student ID:</strong> <%= s.getStudentId() %></span>
                    <span><strong>Email:</strong> <%= s.getEmail() %></span>
                    <span><strong>Status:</strong> Full-time</span>
                </div>
            </section>

            <section class="card section">
                <div class="meta-list">
                    <span class="pill">Term: Fall 2025</span>
                    <span>Enrollment verified</span>
                    <span>Adviser: Dr. M. Alvarez</span>
                </div>
            </section>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Course Name</th>
                        <th>Instructor</th>
                        <th>Schedule</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Course c : courses) { %>
                    <tr>
                        <td><%= c.getCourseCode() %></td>
                        <td><%= c.getCourseName() %></td>
                        <td><%= c.getInstructor() %></td>
                        <td><%= c.getSchedule() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="alert alert-danger">No student information is available for this request.</div>
        <% } %>
    </main>

    <footer class="portal-footer">
        <span><a href="../student">Lookup another student</a></span>
        <span><a href="../index.jsp">Return to dashboard</a></span>
    </footer>
</div>
</body>
</html>
