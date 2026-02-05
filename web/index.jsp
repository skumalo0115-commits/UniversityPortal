<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>University Portal</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<div class="portal-shell">
    <header class="portal-header">
        <div class="portal-brand">
            <div class="portal-logo">UP</div>
            <div>
                <h1>University Portal</h1>
                <p>Academic services • Student records • Faculty tools</p>
            </div>
        </div>
        <nav class="portal-nav">
            <a href="courses">Courses</a>
            <a href="student">Student Center</a>
            <a href="faculty">Faculty Dashboard</a>
        </nav>
    </header>

    <main class="portal-content">
        <section class="page-title">
            <h2>Welcome back to campus services</h2>
            <p>Access schedules, manage course data, and review academic updates in one place.</p>
        </section>

        <section class="card-grid">
            <div class="card">
                <h3>Student Center</h3>
                <p>View your personalized schedule, instructor contacts, and upcoming class times.</p>
                <p><a class="primary-action" href="student">Open student schedule</a></p>
            </div>
            <div class="card">
                <h3>Course Catalog</h3>
                <p>Browse all available courses, including codes, instructors, and meeting times.</p>
                <p><a class="secondary-action" href="courses">View course catalog</a></p>
            </div>
            <div class="card">
                <h3>Faculty Services</h3>
                <p>Update instructor assignments and adjust course schedules for your department.</p>
                <p><a class="secondary-action" href="faculty">Manage courses</a></p>
            </div>
        </section>

        <section class="card">
            <h3>Today at a glance</h3>
            <div class="meta-list">
                <span>🏫 Term: Fall 2025</span>
                <span>⏱️ Registration window open</span>
                <span>📌 Advising week starts Oct 14</span>
                <span>🔔 System status: All services online</span>
            </div>
        </section>
    </main>

    <footer class="portal-footer">
        <span>&copy; 2025 University Portal</span>
        <span>Need help? Email helpdesk@university.edu</span>
    </footer>
</div>
</body>
</html>
