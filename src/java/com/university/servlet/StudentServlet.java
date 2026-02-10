package com.university.servlet;

import com.university.dao.CourseDAO;
import com.university.dao.StudentDAO;
import com.university.model.Course;
import com.university.model.Student;
import com.university.util.CourseUpdateStore;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(name = "StudentServlet", urlPatterns = {"/student"})
public class StudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = getRole(request);
        if (role == null || role.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("lecturer".equalsIgnoreCase(role)) {
            request.setAttribute("accessDenied", true);
            request.setAttribute("message", "Student schedules are only available to student accounts.");
            request.setAttribute("student", new Student());
            request.setAttribute("studentCourses", new ArrayList<Course>());
            request.getSession(true).setAttribute("updatedCourses", new ArrayList<Course>());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/student.jsp");
            dispatcher.forward(request, response);
            return;
        }

        request.setAttribute("student", new Student());
        request.setAttribute("studentCourses", new ArrayList<Course>());
        request.getSession(true).setAttribute("updatedCourses", new ArrayList<Course>());
        request.setAttribute("message", "");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/student.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = getRole(request);
        if (role == null || role.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("lecturer".equalsIgnoreCase(role)) {
            request.setAttribute("accessDenied", true);
            request.setAttribute("message", "Student schedules are only available to student accounts.");
            request.setAttribute("student", new Student());
            request.setAttribute("studentCourses", new ArrayList<Course>());
            request.getSession(true).setAttribute("updatedCourses", new ArrayList<Course>());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/student.jsp");
            dispatcher.forward(request, response);
            return;
        }

        String studentIdParam = request.getParameter("studentId");
        StudentDAO studentDAO = new StudentDAO();
        CourseDAO courseDAO = new CourseDAO();

        Student student = null;
        List<Course> studentCourses = new ArrayList<>();
        List<Course> updatedCourses = new ArrayList<>();
        String message;

        if (studentIdParam != null && !studentIdParam.trim().isEmpty()) {
            try {
                int studentId = Integer.parseInt(studentIdParam.trim());
                student = studentDAO.getStudentById(studentId);

                if (student != null) {
                    studentCourses = courseDAO.getStudentCourses(studentId);
                    updatedCourses = getRelevantRecentUpdates(studentCourses);
                    message = "Schedule loaded successfully.";
                } else {
                    student = new Student();
                    message = "Student not found. Please verify the ID.";
                }
            } catch (NumberFormatException ex) {
                student = new Student();
                message = "Student ID must be a number.";
            }
        } else {
            student = new Student();
            message = "Please enter a student ID.";
        }

        request.setAttribute("student", student);
        request.setAttribute("studentCourses", studentCourses);
        request.getSession(true).setAttribute("updatedCourses", updatedCourses);
        request.setAttribute("message", message);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/student.jsp");
        dispatcher.forward(request, response);
    }

    private List<Course> getRelevantRecentUpdates(List<Course> studentCourses) {
        Set<Integer> studentCourseIds = new HashSet<>();

        for (Course course : studentCourses) {
            studentCourseIds.add(course.getCourseId());
        }

        return CourseUpdateStore.getRecentCoursesForIds(studentCourseIds);
    }

    private String getRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object role = session.getAttribute("role");
        return role == null ? null : role.toString();
    }
}
