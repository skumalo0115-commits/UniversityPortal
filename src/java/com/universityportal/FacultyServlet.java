package com.universityportal;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/faculty")
public class FacultyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family:Arial;'>");
        out.println("<h2>Faculty - Update Courses</h2>");
        out.println("<form action='faculty' method='post'>");
        out.println("Course Code: <input type='text' name='code'/><br><br>");
        out.println("New Instructor: <input type='text' name='instructor'/><br><br>");
        out.println("<input type='submit' value='Update'/>");
        out.println("</form>");
        out.println("<a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String instructor = request.getParameter("instructor");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family:Arial;'>");
        out.println("<h2>Course Updated!</h2>");
        out.println("<p>Course Code: " + code + "</p>");
        out.println("<p>New Instructor: " + instructor + "</p>");
        out.println("<a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}
