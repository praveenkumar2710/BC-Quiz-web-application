package com.controller;

import java.io.IOException;
import java.util.List;

import com.dao.QuizAttemptDAO;
import com.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/profile")
public class UserProfileServlet extends HttpServlet {

    private QuizAttemptDAO attemptDAO = new QuizAttemptDAO();

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            res.sendRedirect(
                req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<Object[]> attempts =
            attemptDAO.getUserAttempts(user.getUserId());

        req.setAttribute("attempts", attempts);

        req.getRequestDispatcher("/user/profile.jsp")
           .forward(req, res);
    }
}
