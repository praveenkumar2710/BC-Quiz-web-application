package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConnection;

public class QuizAttemptDAO {

    public List<Object[]> getUserAttempts(int userId) {

        List<Object[]> list = new ArrayList<>();

        try {
            Connection con = new DBConnection().getConnection();

            String sql =
                "SELECT t.topic_name, qa.score, qa.attempted_at " +
                "FROM quiz_attempts qa " +
                "JOIN topics t ON qa.topic_id = t.topic_id " +
                "WHERE qa.user_id=? " +
                "ORDER BY qa.attempted_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[3];
                row[0] = rs.getString("topic_name");
                row[1] = rs.getInt("score");
                row[2] = rs.getTimestamp("attempted_at");

                list.add(row);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean hasAttempted(int userId, int topicId) {

        boolean attempted = false;

        try {
            Connection con = new DBConnection().getConnection();

            String sql = "SELECT 1 FROM quiz_attempts WHERE user_id=? AND topic_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, topicId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                attempted = true;
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return attempted;
    }

    public int getScore(int userId, int topicId) {

        int score = 0;

        try {
            Connection con = new DBConnection().getConnection();

            String sql = "SELECT score FROM quiz_attempts WHERE user_id=? AND topic_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, topicId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                score = rs.getInt("score");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return score;
    }

    public void saveAttempt(int userId, int topicId, int score) {

        try {
            Connection con = new DBConnection().getConnection();

            String sql = "INSERT INTO quiz_attempts (user_id, topic_id, score, attempted_at) "
                       + "VALUES (?, ?, ?, NOW())";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, topicId);
            ps.setInt(3, score);

            ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

