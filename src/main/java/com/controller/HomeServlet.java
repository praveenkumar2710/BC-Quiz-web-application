package com.controller;
import java.io.IOException;
import java.util.List;

import com.dao.SubjectDAO;
import com.model.Subject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/")
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        SubjectDAO dao = new SubjectDAO();

        List<Subject> subjects = dao.getAllSubjects();

        request.setAttribute("subjects", subjects);

        request.getRequestDispatcher("index.jsp")
               .forward(request, response);
    }
}


