<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>University Portal</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #f1f8e9);
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #004d40;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 1px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        main {
            max-width: 600px;
            margin: 80px auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        h2 {
            text-align: center;
            color: #00695c;
            margin-bottom: 25px;
        }
        ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
        }
        li {
            margin: 15px 0;
        }
        a {
            text-decoration: none;
            color: white;
            background-color: #00796b;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #004d40;
        }
        footer {
            text-align: center;
            padding: 10px;
            background: #004d40;
            color: white;
            position: fixed;
            width: 100%;
            bottom: 0;
            font-size: 13px;
        }
    </style>
</head>
<body>
<header>
    University Portal
</header>

<main>
    <h2>Welcome! Please choose an option below:</h2>
    <ul>
        <li><a href="courses">📚 View All Courses</a></li>
        <li><a href="student">🎓 Student Schedule</a></li>
        <li><a href="faculty">👨‍🏫 Faculty: Update Courses</a></li>
    </ul>
</main>

<footer>
    &copy; 2025 University Portal | Designed by You 🚀
</footer>
</body>
</html>