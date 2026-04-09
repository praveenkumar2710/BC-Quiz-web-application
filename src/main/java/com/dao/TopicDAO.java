package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.Topic;
import com.util.DBConnection;

public class TopicDAO {

    // ADD
    public boolean addTopic(int subjectId, String topicName) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "INSERT INTO topics(subject_id, topic_name) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, subjectId);
            ps.setString(2, topicName);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // GET BY SUBJECT
    public List<Topic> getTopicsBySubject(int subjectId) {
        List<Topic> list = new ArrayList<>();
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT * FROM topics WHERE subject_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, subjectId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Topic t = new Topic();
                t.setTopicId(rs.getInt("topic_id"));
                t.setSubjectId(rs.getInt("subject_id"));
                t.setTopicName(rs.getString("topic_name"));
                list.add(t);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET BY ID
    public Topic getTopicById(int topicId) {
        Topic t = null;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT * FROM topics WHERE topic_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, topicId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                t = new Topic();
                t.setTopicId(rs.getInt("topic_id"));
                t.setSubjectId(rs.getInt("subject_id"));
                t.setTopicName(rs.getString("topic_name"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    // UPDATE
    public boolean updateTopic(int topicId, String topicName) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "UPDATE topics SET topic_name=? WHERE topic_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, topicName);
            ps.setInt(2, topicId);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // DELETE  ✅ THIS FIXES YOUR ERROR
    public boolean deleteTopic(int topicId) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "DELETE FROM topics WHERE topic_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, topicId);
            System.out.println("hii every one");

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
