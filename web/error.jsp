<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Something Went Wrong</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="theme-dark">
    <main class="container">
        <section class="glass-card">
            <h1>Oops!</h1>
            <p>We couldn’t find the page you requested or an error occurred.</p>
            <a class="btn primary" href="${pageContext.request.contextPath}/">Return to Dashboard</a>
        </section>
    </main>
</body>
</html>