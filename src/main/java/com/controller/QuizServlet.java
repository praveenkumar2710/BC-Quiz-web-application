package com.controller;

import java.io.IOException;
import java.util.*;

import com.dao.QuestionDAO;
import com.dao.QuizAttemptDAO;
import com.model.Question;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private QuestionDAO questionDAO = new QuestionDAO();
    private QuizAttemptDAO attemptDAO = new QuizAttemptDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        String topicIdStr = req.getParameter("topicId");
        if (topicIdStr == null) {
            res.sendRedirect(req.getContextPath() + "/user/subjects");
            return;
        }

        int topicId = Integer.parseInt(topicIdStr);

        if (attemptDAO.hasAttempted(userId, topicId)) {

            Integer prevScore =
                attemptDAO.getScore(userId, topicId);

            req.setAttribute("attempted", true);
            req.setAttribute("prevScore", prevScore);
            req.setAttribute("topicId", topicId);

            req.getRequestDispatcher("/quizResult.jsp")
               .forward(req, res);
            return;
        }


        List<Question> allQuestions =
                questionDAO.getQuestionsByTopic(topicId);

        Collections.shuffle(allQuestions);

        List<Question> quizQuestions =
                new ArrayList<>(allQuestions.subList(
                        0, Math.min(15, allQuestions.size())));

        for (Question q : quizQuestions) {
            List<String> options = new ArrayList<>();
            options.add(q.getOptionA());
            options.add(q.getOptionB());
            options.add(q.getOptionC());
            options.add(q.getOptionD());

            Collections.shuffle(options);

            q.setOptionA(options.get(0));
            q.setOptionB(options.get(1));
            q.setOptionC(options.get(2));
            q.setOptionD(options.get(3));
        }

        session.setAttribute("quizQuestions", quizQuestions);
        session.setAttribute("quizTopicId", topicId);

        req.setAttribute("questions", quizQuestions);
        req.getRequestDispatcher("/quiz.jsp").forward(req, res);
    }

    @Override
  
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        @SuppressWarnings("unchecked")
        List<Question> quizQuestions =
                (List<Question>) session.getAttribute("quizQuestions");

        Integer topicId =
                (Integer) session.getAttribute("quizTopicId");

        if (quizQuestions == null || topicId == null) {
            res.sendRedirect(req.getContextPath() + "/user/subjects");
            return;
        }

        int score = 0;

        for (Question q : quizQuestions) {
            String userAnswer =
                    req.getParameter("q_" + q.getQuestionId());

            if (userAnswer != null &&
                userAnswer.equals(q.getCorrectOption())) {
                score++;
            }
        }

        // ✅ Correct save method
        attemptDAO.saveAttempt(userId, topicId, score);

        session.removeAttribute("quizQuestions");
        session.removeAttribute("quizTopicId");

        req.setAttribute("score", score);
        req.setAttribute("total", quizQuestions.size());

        req.getRequestDispatcher("/quizResult.jsp")
           .forward(req, res);
    }

}
