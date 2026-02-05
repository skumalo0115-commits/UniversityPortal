package com.universityportal;

import com.university.dao.StudentDAO;
import com.university.model.Course;
import com.university.model.Student;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/student_lookup.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Integer studentId = parseStudentId(idParam);
        if (studentId == null) {
            request.setAttribute("error", "Please enter a valid numeric student ID.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/student_lookup.jsp");
            dispatcher.forward(request, response);
            return;
        }

        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentById(studentId);
        List<Course> courses = studentDAO.getCoursesForStudent(studentId);

        if (student == null) {
            request.setAttribute("error", "No student found for ID " + studentId + ".");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/student_lookup.jsp");
            dispatcher.forward(request, response);
            return;
        }

        request.setAttribute("student", student);
        request.setAttribute("courses", courses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/student.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            idParam = request.getParameter("studentId");
        }
        if (idParam != null) {
            response.sendRedirect(request.getContextPath() + "/student?id=" + idParam);
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/student_lookup.jsp");
        dispatcher.forward(request, response);
    }

    private Integer parseStudentId(String value) {
        try {
            return Integer.valueOf(value.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}
