package com.universityportal;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family:Arial;'>");
        out.println("<h2>Student Schedule</h2>");
        out.println("<form action='student' method='post'>");
        out.println("Enter Student ID: <input type='text' name='studentId'/><br><br>");
        out.println("<input type='submit' value='View Schedule'/>");
        out.println("</form>");
        out.println("<a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family:Arial;'>");
        out.println("<h2>Schedule for Student ID: " + studentId + "</h2>");
        out.println("<ul>");
        out.println("<li>CS101 - Introduction to Programming (Mon 9am)</li>");
        out.println("<li>CS102 - Database Systems (Wed 11am)</li>");
        out.println("</ul>");
        out.println("<a href='index.jsp'>Back to Home</a>");
        out.println("</body></html>");
    }
}
