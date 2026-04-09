package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.Subject;
import com.util.DBConnection;

public class SubjectDAO {

    // ADD
    public boolean addSubject(Subject s) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "INSERT INTO subjects(subject_name) VALUES(?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, s.getSubjectName());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // GET ALL
    public List<Subject> getAllSubjects() {
        List<Subject> list = new ArrayList<>();
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT * FROM subjects";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectId(rs.getInt("subject_id"));
                s.setSubjectName(rs.getString("subject_name"));
                list.add(s);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET BY ID (FOR EDIT)
    public Subject getSubjectById(int subjectId) {
        Subject s = null;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "SELECT * FROM subjects WHERE subject_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, subjectId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new Subject();
                s.setSubjectId(rs.getInt("subject_id"));
                s.setSubjectName(rs.getString("subject_name"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    // UPDATE
    public boolean updateSubject(int subjectId, String subjectName) {
        boolean status = false;
        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            String sql = "UPDATE subjects SET subject_name=? WHERE subject_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, subjectName);
            ps.setInt(2, subjectId);

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // DELETE
    public boolean deleteSubject(int subjectId) {

        boolean status = false;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConnection();

            // 1️⃣ Delete topics under this subject
            String sql1 = "DELETE FROM topics WHERE subject_id=?";
            PreparedStatement ps1 = con.prepareStatement(sql1);
            ps1.setInt(1, subjectId);
            ps1.executeUpdate();

            // 2️⃣ Delete the subject
            String sql2 = "DELETE FROM subjects WHERE subject_id=?";
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setInt(1, subjectId);
            status = ps2.executeUpdate() > 0;

            ps1.close();
            ps2.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

}
