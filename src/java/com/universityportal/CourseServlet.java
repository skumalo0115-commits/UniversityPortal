package com.universityportal;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family:Arial;'>");
        out.println("<h2>All Courses</h2>");
        out.println("<ul>");
        out.println("<li>CS101 - Introduction to Programming</li>");
        out.println("<li>CS102 - Database Systems</li>");
        out.println("<li>CS103 - Web Development</li>");
        out.println("</ul>");
        out.println("<a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}