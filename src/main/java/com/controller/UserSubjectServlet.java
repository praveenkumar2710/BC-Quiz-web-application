package com.controller;

import java.io.IOException;

import com.dao.SubjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/subjects")
public class UserSubjectServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // 🔐 USER LOGIN CHECK
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 📌 LOAD SUBJECTS
        req.setAttribute("subjects", subjectDAO.getAllSubjects());

        // ➡️ FORWARD TO USER SUBJECTS PAGE
        req.getRequestDispatcher("/user/subjects.jsp")
           .forward(req, res);
    }
}
