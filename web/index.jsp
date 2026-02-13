
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<html lang="en">
 <head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>University Portal</title>


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script defer src="${pageContext.request.contextPath}/js/app.js"></script>
 </head>
<body class="theme-dark home-page">
    <header class="hero">
        <div class="hero-content" style="display:${empty sessionScope.role ? 'grid' : 'none'};">
            <p class="tag">University Portal</p>
            <h1>Modern Academic Hub</h1>
            <p class="subtitle">Manage courses, student schedules, and faculty updates with a premium experience.</p>
            <div class="hero-actions">
                <a class="btn primary" href="${pageContext.request.contextPath}/login">Login</a>
                <a class="btn ghost" href="${pageContext.request.contextPath}/courses">Browse Courses</a>
            </div>
        </div>
        <div class="hero-content" style="display:${empty sessionScope.role ? 'none' : 'grid'};">
            <p class="tag">Welcome back</p>
            <h1>${empty sessionScope.username ? 'Member' : sessionScope.username}</h1>
            <p class="subtitle">Your personalized academic workspace is ready. Continue where you left off.</p>
            <div class="hero-actions">
                <a class="btn primary" href="${pageContext.request.contextPath}/logout">Logout</a>
                <a class="btn ghost" href="${pageContext.request.contextPath}/courses">Browse Courses</a>
            </div>
       </div>
       <div class="hero-glow"></div>
    </header>

    <main class="container">
        <section class="card-grid" style="display:${empty sessionScope.role ? 'grid' : 'none'};">
            <article class="glass-card">
                <h2>Student Schedule</h2>
                <p>Search your registered courses and view a personalized schedule instantly.</p>
                <a class="link" href="${pageContext.request.contextPath}/student">View Schedule →</a>
            </article>
            <article class="glass-card">
                <h2>Faculty Updates</h2>
                <p>Update course instructors and schedules using secure forms and validation.</p>
                <a class="link" href="${pageContext.request.contextPath}/faculty">Manage Courses →</a>
            </article>
            <article class="glass-card">
                <h2>Course Catalog</h2>
                <p>Explore all available classes with live search and animated cards.</p>
                <a class="link" href="${pageContext.request.contextPath}/courses">Explore Catalog →</a>
            </article>
        </section>
        <section class="card-grid" style="display:${empty sessionScope.role ? 'none' : 'grid'};">
            <article class="glass-card">
                <h2>Continue Learning</h2>
                <p>Jump straight into your schedule or manage courses if you’re a lecturer.</p>
                <a class="link" href="${pageContext.request.contextPath}/student">Open Schedule →</a>
            </article>
            <article class="glass-card">
                <h2>Manage Courses</h2>
                <p>Update instructors, schedules, and course delivery details securely.</p>
                <a class="link" href="${pageContext.request.contextPath}/faculty">Open Faculty Console →</a>
            </article>
            <article class="glass-card">
                <h2>Explore Catalog</h2>
                <p>Review the course catalog with live search and refined filters.</p>
                <a class="link" href="${pageContext.request.contextPath}/courses">Open Catalog →</a>
            </article>
        </section>
 
        <section class="action-bar">
            <div>
                <h3>Quick Controls</h3>
                <p>Toggle dark mode for a comfortable viewing experience.</p>
            </div>
            <button class="toggle" id="themeToggle" type="button">Toggle Mode</button>
        </section>
    </main>
 </body>
</html>