<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Subject" %>

<%
    List<Subject> subjects =
        (List<Subject>) request.getAttribute("subjects");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BCQuiz | Home</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        .hero-section {
            height: 90vh;
            background-image: url('https://images.pexels.com/photos/4778611/pexels-photo-4778611.jpeg');
            background-size: cover;
            background-position: center;
            position: relative;
            color: white;
        }

        .hero-section::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.6);
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .subject-card {
            border-radius: 16px;
            transition: 0.3s ease;
        }

        .subject-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.4);
        }

        footer {
            background: #111;
            color: white;
            padding: 20px;
            text-align: center;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand fw-bold"
       href="<%= request.getContextPath() %>/">
        BCQuiz
    </a>

    <div class="ms-auto d-flex gap-2">
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-success btn-sm">User Login</a>
        <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-outline-light btn-sm">Register</a>
        <a href="<%= request.getContextPath() %>/adminLogin.jsp" class="btn btn-primary btn-sm">Admin</a>
    </div>
</nav>

<!-- HERO -->
<div class="hero-section d-flex align-items-center justify-content-center text-center">
    <div class="hero-content">
        <h1 class="display-4 fw-bold">Welcome to BCQuiz</h1>
        <p class="lead">Test your knowledge. Challenge yourself. Improve every day.</p>
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-warning btn-lg mt-3">
            Start Learning
        </a>
    </div>
</div>

<!-- SUBJECTS -->
<div class="container py-5">

    <div class="row justify-content-center">

        <%
        if (subjects != null && !subjects.isEmpty()) {
            for (Subject s : subjects) {
        %>

        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
            <div class="card subject-card text-center h-100 shadow-lg">
                <div class="card-body d-flex flex-column justify-content-between">
                    <h5 class="card-title fw-bold">
                        <%= s.getSubjectName() %>
                    </h5>

                    <a href="<%= request.getContextPath() %>/topics?subjectId=<%= s.getSubjectId() %>"
                       class="btn btn-primary mt-3">
                        Start Quiz
                    </a>
                </div>
            </div>
        </div>

        <%
            }
        } else {
        %>

        <div class="text-center text-muted">
            No subjects available
        </div>

        <%
        }
        %>

    </div>
</div>

<!-- FOOTER -->
<footer>
    © 2026 BCQuiz Technologies | All Rights Reserved
</footer>

</body>
</html>