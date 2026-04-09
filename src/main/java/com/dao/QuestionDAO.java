package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.Question;
import com.util.DBConnection;

public class QuestionDAO {

    // ================= RANDOM QUESTIONS BY TOPIC =================
    public List<Question> getRandomQuestionsByTopic(int topicId, int limit) {

        List<Question> list = new ArrayList<>();

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql =
                "SELECT * FROM questions " +
                "WHERE topic_id=? " +
                "ORDER BY RAND() " +
                "LIMIT ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, topicId);
            ps.setInt(2, limit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setQuestionId(rs.getInt("question_id"));
                q.setTopicId(rs.getInt("topic_id"));
                q.setQuestionText(rs.getString("question"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                list.add(q);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= ALL QUESTIONS BY TOPIC =================
    public List<Question> getQuestionsByTopic(int topicId) {

        List<Question> list = new ArrayList<>();

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT * FROM questions WHERE topic_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, topicId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setQuestionId(rs.getInt("question_id"));
                q.setTopicId(rs.getInt("topic_id"));
                q.setQuestionText(rs.getString("question"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                list.add(q);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= DELETE QUESTION =================
    public boolean deleteQuestion(int questionId) {

        boolean status = false;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "DELETE FROM questions WHERE question_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, questionId);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
 // CHECK IF QUESTION ALREADY EXISTS FOR A TOPIC
    public boolean isQuestionExists(int topicId, String questionText) {

        boolean exists = false;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT question_id FROM questions WHERE topic_id=? AND question=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, topicId);
            ps.setString(2, questionText);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                exists = true;   // question already present
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }
 // ADD QUESTION
    public boolean addQuestion(Question q) {

        boolean status = false;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql =
                "INSERT INTO questions " +
                "(topic_id, question, option_a, option_b, option_c, option_d, correct_option) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, q.getTopicId());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectOption());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


}
