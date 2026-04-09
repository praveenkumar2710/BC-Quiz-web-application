package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.TopicDAO;

@WebServlet("/user/topics")
public class UserTopicServlet extends HttpServlet {

    private TopicDAO topicDAO = new TopicDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // 🔐 Session Check
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int subjectId;

        try {
            String subjectParam = req.getParameter("subjectId");

            if (subjectParam == null || subjectParam.isEmpty()) {
                res.sendRedirect(req.getContextPath() + "/user/subjects");
                return;
            }

            subjectId = Integer.parseInt(subjectParam);

        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/user/subjects");
            return;
        }

        // 📚 Load Topics
        req.setAttribute("topics",
                topicDAO.getTopicsBySubject(subjectId));

        req.getRequestDispatcher("/user/topics.jsp")
           .forward(req, res);
    }
}
