<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | University Portal</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <script defer src="<%= request.getContextPath() %>/js/app.js"></script>
</head>
<body class="theme-dark ${empty sessionScope.role ? 'logged-out' : 'logged-in'}" data-context-path="<%= request.getContextPath() %>">
    <header class="page-header">
        <div>
            <h1>Secure Login</h1>
            <p>Select your role to access the right dashboard.</p>
        </div>
        <div class="header-actions">
            <a class="btn ghost" href="<%= request.getContextPath() %>/index.jsp">Dashboard</a>
            <button class="toggle" id="themeToggle" type="button">Toggle Mode</button>
        </div>
    </header>

    <main class="container">
        <section class="glass-card">
            <form class="form" action="<%= request.getContextPath() %>/login" method="post">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter username" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>

                <label for="role">Role</label>
                <select id="role" name="role" class="styled-select" required>
                    <option value="student">Student</option>
                    <option value="lecturer">Lecturer</option>
                </select>

                <button class="btn primary" type="submit">Login</button>
            </form>
            <div class="status">${message}</div>
        </section>
    </main>
</body>
</html>

