package com.controller;

import java.io.IOException;
import java.util.List;

import com.dao.SubjectDAO;
import com.dao.TopicDAO;
import com.model.Subject;
import com.model.Topic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/topics")
public class TopicServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private TopicDAO topicDAO = new TopicDAO();
    private SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Subject> subjects = subjectDAO.getAllSubjects();
        req.setAttribute("subjects", subjects);

        // DELETE
        String deleteId = req.getParameter("deleteId");
        if (deleteId != null) {
            topicDAO.deleteTopic(Integer.parseInt(deleteId));
        }

        // LOAD TOPICS
        String subjectIdStr = req.getParameter("subjectId");
        if (subjectIdStr != null) {
            int subjectId = Integer.parseInt(subjectIdStr);
            List<Topic> topics = topicDAO.getTopicsBySubject(subjectId);
            req.setAttribute("topics", topics);
            req.setAttribute("selectedSubjectId", subjectId);
        }

        // EDIT
        String editId = req.getParameter("editId");
        if (editId != null) {
            Topic editTopic = topicDAO.getTopicById(Integer.parseInt(editId));
            req.setAttribute("editTopic", editTopic);
        }

        req.getRequestDispatcher("/topics.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int subjectId = Integer.parseInt(req.getParameter("subjectId"));
        String topicName = req.getParameter("topicName");
        String topicIdStr = req.getParameter("topicId");

        if (topicIdStr == null || topicIdStr.isEmpty()) {
            topicDAO.addTopic(subjectId, topicName);
        } else {
            topicDAO.updateTopic(Integer.parseInt(topicIdStr), topicName);
        }

        res.sendRedirect(req.getContextPath() + "/topics?subjectId=" + subjectId);
    }
}
