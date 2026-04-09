package com.controller;

import java.io.IOException;

import com.dao.UserDAO;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userDAO.login(email, password);

       
        if (user != null && "ADMIN".equals(user.getRole())) {

            HttpSession session = req.getSession();
            session.setAttribute("admin", user);

            
            res.sendRedirect(req.getContextPath() + "/subjects");

        } else {
            req.setAttribute("error", "Invalid admin credentials");
            req.getRequestDispatcher("/adminLogin.jsp")
               .forward(req, res);
        }
    }
}
