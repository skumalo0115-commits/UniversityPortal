package com.universityportal;

import com.university.dao.CourseDAO;
import com.university.model.Course;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("courses", courses);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/courses.jsp");
        dispatcher.forward(request, response);
    }
}
