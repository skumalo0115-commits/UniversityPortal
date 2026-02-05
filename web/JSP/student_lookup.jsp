<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Lookup</title>
    <link rel="stylesheet" href="../assets/styles.css">
</head>
<body>
<div class="portal-shell">
    <header class="portal-header">
        <div class="portal-brand">
            <div class="portal-logo">UP</div>
            <div>
                <h1>Student Center</h1>
                <p>Personalized schedules and enrollment details</p>
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
            <h2>Find a student schedule</h2>
            <p>Enter the student ID to view course enrollments and meeting times.</p>
        </section>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form class="form-card" action="student" method="get">
            <div class="form-group">
                <label for="studentId">Student ID</label>
                <input id="studentId" type="text" name="id" placeholder="e.g. 1 or 2" />
                <span class="helper-text">Your student ID appears on your campus ID card.</span>
            </div>
            <div class="form-actions">
                <button class="primary-action" type="submit">View Schedule</button>
                <a class="secondary-action" href="../index.jsp">Back to dashboard</a>
            </div>
        </form>

        <p class="page-title" style="margin-top: 24px;">
            <span class="badge">Sample IDs: 1, 2</span>
        </p>
    </main>

    <footer class="portal-footer">
        <span>Need assistance? Visit the registrar's office.</span>
        <span><a href="../index.jsp">Return to dashboard</a></span>
    </footer>
</div>
</body>
</html>
