package com.university.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("message", "");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String message;

        boolean valid = username != null && password != null
                && !username.trim().isEmpty() && !password.trim().isEmpty();

        if (!valid) {
            message = "Username and password are required.";
            request.setAttribute("message", message);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("role", role);
        session.setAttribute("username", username.trim());

        if ("lecturer".equalsIgnoreCase(role) || "faculty".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/faculty");
        } else {
            response.sendRedirect(request.getContextPath() + "/student");
        }
    }
}
