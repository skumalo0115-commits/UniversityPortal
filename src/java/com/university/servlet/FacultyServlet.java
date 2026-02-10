package com.university.servlet;

import com.university.dao.CourseDAO;
import com.university.model.Course;
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
import java.util.List;

@WebServlet(name = "FacultyServlet", urlPatterns = {"/faculty"})
public class FacultyServlet extends HttpServlet {

    private static final String FLASH_MESSAGE_KEY = "facultyMessage";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = getRole(request);
        if (role == null || role.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        HttpSession session = request.getSession(false);
        String flashMessage = consumeFlashMessage(session);

        CourseDAO courseDAO = new CourseDAO();
        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("courses", courses);

        String lecturerKey = getUsername(request);
        List<Course> updatedCourses;

        if (isStudentRole(role)) {
            updatedCourses = new ArrayList<>();
            request.setAttribute("accessDenied", true);
            request.setAttribute("message", "Course management is available to lecturer accounts only.");
        } else {
            updatedCourses = CourseUpdateStore.getLecturerRecentCourses(lecturerKey);
            request.setAttribute("message", flashMessage == null ? "" : flashMessage);
        }

        if (session != null) {
            session.setAttribute("updatedCourses", updatedCourses);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/faculty.jsp");
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

        CourseDAO courseDAO = new CourseDAO();
        String courseIdParam = firstNonBlank(request.getParameterValues("courseId"));
        String instructor = request.getParameter("instructor");
        String schedule = request.getParameter("schedule");

        String message;
        boolean updated = false;
        Course updatedCourse = null;

        if (isStudentRole(role)) {
            message = "Course management is available to lecturer accounts only.";
        } else if (courseIdParam == null) {
            message = "Please select a course.";
        } else if (instructor == null || instructor.trim().isEmpty()) {
            message = "Instructor name is required.";
        } else if (schedule == null || schedule.trim().isEmpty()) {
            message = "Schedule is required.";
        } else {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                Course course = new Course();
                course.setCourseId(courseId);
                course.setInstructor(instructor.trim());
                course.setSchedule(schedule.trim());

                updated = courseDAO.updateCourse(course);
                message = updated ? "Course updated successfully." : "Update failed. Please try again.";

                if (updated) {
                    updatedCourse = courseDAO.getAllCourses().stream()
                            .filter(item -> item.getCourseId() == courseId)
                            .findFirst()
                            .orElse(null);

                    if (updatedCourse != null) {
                        CourseUpdateStore.recordUpdate(getUsername(request), updatedCourse);
                    }
                }
            } catch (NumberFormatException ex) {
                message = "Course ID must be numeric.";
            }
        }

        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            response.setContentType("application/json");
            response.getWriter().write(buildJsonResponse(updated, message, updatedCourse));
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute(FLASH_MESSAGE_KEY, message);
        response.sendRedirect(request.getContextPath() + "/faculty");
    }

    private String consumeFlashMessage(HttpSession session) {
        if (session == null) {
            return null;
        }
        Object flash = session.getAttribute(FLASH_MESSAGE_KEY);
        if (flash == null) {
            return null;
        }
        session.removeAttribute(FLASH_MESSAGE_KEY);
        return flash.toString();
    }

    private String getRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object role = session.getAttribute("role");
        return role == null ? null : role.toString();
    }

    private String getUsername(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return "";
        }
        Object username = session.getAttribute("username");
        if (username == null) {
            return "";
        }
        return username.toString().trim().toLowerCase();
    }

    private boolean isStudentRole(String role) {
        return "student".equalsIgnoreCase(role);
    }

    private String firstNonBlank(String[] values) {
        if (values == null) {
            return null;
        }
        for (String value : values) {
            if (value != null && !value.trim().isEmpty()) {
                return value.trim();
            }
        }
        return null;
    }

    private String buildJsonResponse(boolean updated, String message, Course course) {
        StringBuilder builder = new StringBuilder();
        builder.append("{\"updated\":").append(updated).append(",\"message\":\"")
                .append(escapeJson(message)).append("\"");

        if (course != null) {
            builder.append(",\"course\":{")
                    .append("\"code\":\"").append(escapeJson(course.getCourseCode())).append("\",")
                    .append("\"name\":\"").append(escapeJson(course.getCourseName())).append("\",")
                    .append("\"instructor\":\"").append(escapeJson(course.getInstructor())).append("\",")
                    .append("\"schedule\":\"").append(escapeJson(course.getSchedule())).append("\"")
                    .append("}");
        }

        builder.append("}");
        return builder.toString();
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
