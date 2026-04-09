package com.controller;

import java.io.IOException;
import java.util.List;

import com.dao.QuestionDAO;
import com.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/questions")
public class QuestionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // DELETE QUESTION
        String deleteId = req.getParameter("deleteId");
        if (deleteId != null && !deleteId.isEmpty()) {
            questionDAO.deleteQuestion(Integer.parseInt(deleteId));
        }

        // LOAD QUESTIONS BY TOPIC
        String topicIdStr = req.getParameter("topicId");
        if (topicIdStr != null && !topicIdStr.isEmpty()) {
            int topicId = Integer.parseInt(topicIdStr);

            List<Question> questions =
                questionDAO.getQuestionsByTopic(topicId);

            req.setAttribute("questions", questions);
            req.setAttribute("selectedTopicId", topicId);
        }

        req.getRequestDispatcher("/questions.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String topicIdStr = req.getParameter("topicId");
        if (topicIdStr == null || topicIdStr.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/subjects");
            return;
        }

        int topicId = Integer.parseInt(topicIdStr);
        String bulkData = req.getParameter("bulkQuestions");

        // LIMIT: MAX 30 QUESTIONS PER TOPIC
        int existingCount =
            questionDAO.getQuestionsByTopic(topicId).size();

        int remaining = 30 - existingCount;

        if (remaining <= 0) {
            res.sendRedirect(req.getContextPath()
                + "/questions?topicId=" + topicId);
            return;
        }

        if (bulkData != null && !bulkData.trim().isEmpty()) {

            String[] lines = bulkData.split("\\r?\\n");

            for (String line : lines) {

                if (line.trim().isEmpty()) continue;
                if (remaining <= 0) break;

                String[] parts = line.split("\\|");

                // Expected format:
                // Question | A | B | C | D | CorrectOption(TEXT)
                if (parts.length != 6) continue;

                Question q = new Question();
                q.setTopicId(topicId);
                q.setQuestionText(parts[0].trim());
                q.setOptionA(parts[1].trim());
                q.setOptionB(parts[2].trim());
                q.setOptionC(parts[3].trim());
                q.setOptionD(parts[4].trim());

                // ✅ DO NOT change case
                q.setCorrectOption(parts[5].trim());

                // ADD ONLY IF NOT DUPLICATE
                if (!questionDAO.isQuestionExists(
                        topicId, q.getQuestionText())) {

                    questionDAO.addQuestion(q);
                    remaining--;
                }
            }
        }

        res.sendRedirect(req.getContextPath()
            + "/questions?topicId=" + topicId);
    }
}
