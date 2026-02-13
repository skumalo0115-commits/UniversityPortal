<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | University Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="${pageContext.request.contextPath}/js/app.js"></script>
</head>
<body class="theme-dark ${empty sessionScope.role ? 'logged-out' : 'logged-in'}">
    <header class="page-header">
        <div>
            <h1>Secure Login</h1>
            <p>Select your role to access the right dashboard.</p>
        </div>
        <div class="header-actions">
            <a class="btn ghost" href="${pageContext.request.contextPath}/">Dashboard</a>
            <button class="toggle" id="themeToggle" type="button">Toggle Mode</button>
        </div>
    </header>

    <main class="container">
        <section class="glass-card">
            <form class="form" action="${pageContext.request.contextPath}/login" method="post">
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