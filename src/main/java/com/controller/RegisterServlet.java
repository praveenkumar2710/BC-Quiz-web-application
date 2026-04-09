package com.controller;

import java.io.IOException;
import java.util.regex.Pattern;

import com.dao.UserDAO;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String firstName = req.getParameter("firstName").trim();
        String lastName = req.getParameter("lastName").trim();
        String email = req.getParameter("email").trim().toLowerCase();
        String phone = req.getParameter("phone").trim();
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // 🔥 Always preserve values
        req.setAttribute("firstName", firstName);
        req.setAttribute("lastName", lastName);
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);

        // Name validation
        if (!Pattern.matches("^[A-Za-z]+$", firstName) ||
            !Pattern.matches("^[A-Za-z]+$", lastName)) {

            req.setAttribute("error", "Invalid name. Only letters allowed.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // Phone validation
        if (!Pattern.matches("^[0-9]{10}$", phone)) {
            req.setAttribute("error", "Phone number must be 10 digits.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // Password validation
        String passwordRegex =
                "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$";

        if (!Pattern.matches(passwordRegex, password)) {
            req.setAttribute("error",
                    "Password must contain 8+ chars, upper, lower, number & special character.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // Check email existence
        if (userDAO.isEmailExists(email)) {
            req.setAttribute("error", "Email already exists.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        // Create user
        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setRole("USER");

        boolean status = userDAO.register(user);

        if (status) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            req.setAttribute("error", "Registration failed. Try again.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
        }
    }
}