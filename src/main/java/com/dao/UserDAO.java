package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.model.User;
import com.util.DBConnection;

public class UserDAO {

	public boolean register(User u) {

	    String sql = "INSERT INTO users(first_name, last_name, email, phone, password, role) VALUES (?, ?, ?, ?, ?, ?)";

	    try (Connection con = new DBConnection().getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, u.getFirstName());
	        ps.setString(2, u.getLastName());
	        ps.setString(3, u.getEmail());
	        ps.setString(4, u.getPhone());
	        ps.setString(5, u.getPassword());
	        ps.setString(6, u.getRole());

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();  // Now you will see real error if any
	        return false;
	    }
	}

    // LOGIN (Better version)
    public User login(String email, String password) {

        String sql = "SELECT * FROM users WHERE email=?";

        try (Connection con = new DBConnection().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.toLowerCase());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String storedPassword = rs.getString("password");

                if (storedPassword.equals(password)) {

                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastname"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getString("role"));

                    return user;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // CHECK EMAIL
    public boolean isEmailExists(String email) {

        String sql = "SELECT user_id FROM users WHERE LOWER(email)=?";

        try (Connection con = new DBConnection().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.toLowerCase());
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}