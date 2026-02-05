<%@ page import="com.university.model.Course" %>
<%
    Course course = (Course) request.getAttribute("course");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Course</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>
<div class="portal-shell">
    <header class="portal-header">
        <div class="portal-brand">
            <div class="portal-logo">UP</div>
            <div>
                <h1>Faculty Dashboard</h1>
                <p>Update course details</p>
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
            <h2>Edit Course</h2>
            <p>Adjust instructor and schedule information before publishing updates.</p>
        </section>

        <% if (course != null) { %>
            <form class="form-card" action="faculty" method="post">
                <input type="hidden" name="courseId" value="<%= course.getCourseId() %>" />
                <div class="form-group">
                    <label>Course Code</label>
                    <input type="text" value="<%= course.getCourseCode() %>" disabled />
                </div>
                <div class="form-group">
                    <label>Course Name</label>
                    <input type="text" value="<%= course.getCourseName() %>" disabled />
                </div>
                <div class="form-group">
                    <label for="instructor">Instructor</label>
                    <input id="instructor" type="text" name="instructor" value="<%= course.getInstructor() %>" />
                    <span class="helper-text">Use full faculty title and last name.</span>
                </div>
                <div class="form-group">
                    <label for="schedule">Schedule</label>
                    <input id="schedule" type="text" name="schedule" value="<%= course.getSchedule() %>" />
                    <span class="helper-text">Example: Mon/Wed 10:00–11:15 AM.</span>
                </div>
                <div class="form-actions">
                    <button class="primary-action" type="submit">Update Course</button>
                    <a class="secondary-action" href="faculty">Back to course list</a>
                </div>
            </form>
        <% } else { %>
            <div class="alert alert-danger">Course not found.</div>
        <% } %>
    </main>

    <footer class="portal-footer">
        <span>Changes are logged for audit.</span>
        <span><a href="../index.jsp">Return to dashboard</a></span>
    </footer>
</div>
</body>
</html>
