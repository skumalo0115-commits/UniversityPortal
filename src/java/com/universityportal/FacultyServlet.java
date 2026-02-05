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

@WebServlet("/faculty")
public class FacultyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO courseDAO = new CourseDAO();
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isBlank()) {
            try {
                int courseId = Integer.parseInt(idParam);
                Course course = courseDAO.getCourseById(courseId);
                request.setAttribute("course", course);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/edit_course.jsp");
                dispatcher.forward(request, response);
                return;
            } catch (NumberFormatException ex) {
                request.setAttribute("error", "Invalid course ID supplied.");
            }
        }

        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("courses", courses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/faculty.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO courseDAO = new CourseDAO();
        String courseIdParam = request.getParameter("courseId");
        String instructor = request.getParameter("instructor");
        String schedule = request.getParameter("schedule");

        if (courseIdParam == null || courseIdParam.isBlank()) {
            request.setAttribute("error", "Course ID is required to update a course.");
        } else {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                Course course = courseDAO.getCourseById(courseId);
                if (course != null) {
                    course.setInstructor(instructor);
                    course.setSchedule(schedule);
                    courseDAO.updateCourse(course);
                    request.setAttribute("message", "Course details updated successfully.");
                } else {
                    request.setAttribute("error", "Course not found.");
                }
            } catch (NumberFormatException ex) {
                request.setAttribute("error", "Invalid course ID supplied.");
            }
        }

        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("courses", courses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/faculty.jsp");
        dispatcher.forward(request, response);
    }
}
