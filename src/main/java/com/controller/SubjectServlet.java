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

@WebServlet("/subjects")
public class SubjectServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // DELETE
        String deleteId = req.getParameter("deleteId");
        if (deleteId != null) {
            subjectDAO.deleteSubject(Integer.parseInt(deleteId));
        }

        // EDIT
        String editId = req.getParameter("editId");
        if (editId != null) {
            Subject editSubject =
                subjectDAO.getSubjectById(Integer.parseInt(editId));
            req.setAttribute("editSubject", editSubject);
        }

        List<Subject> list = subjectDAO.getAllSubjects();
        req.setAttribute("subjectList", list);

        req.getRequestDispatcher("/subjects.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String subjectName = req.getParameter("subjectName");
        String subjectIdStr = req.getParameter("subjectId");

        if (subjectIdStr == null || subjectIdStr.isEmpty()) {
            // ADD
            Subject s = new Subject();
            s.setSubjectName(subjectName);
            subjectDAO.addSubject(s);
        } else {
            // UPDATE
            subjectDAO.updateSubject(
                Integer.parseInt(subjectIdStr),
                subjectName
            );
        }

        List<Subject> list = subjectDAO.getAllSubjects();
        req.setAttribute("subjectList", list);
        req.getRequestDispatcher("/subjects.jsp").forward(req, res);
    }
    
}
