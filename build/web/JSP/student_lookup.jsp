<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Student Lookup</title></head>
<body>
<h2>Enter Student ID</h2>
<% String error = (String) request.getAttribute("error");
   if (error != null) { %>
   <p style="color:red;"><%= error %></p>
<% } %>
<form action="student" method="get">
    <label>Student ID: <input type="text" name="id" /></label>
    <input type="submit" value="View Schedule" />
</form>
<p>Sample IDs: 1, 2</p>
<p><a href="index.jsp">Back</a></p>
</body>
</html>
