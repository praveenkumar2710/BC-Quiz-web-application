<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Subject" %>
<%@ page import="com.model.User" %>

<%
    List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
    User loggedUser = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>BCQuiz | Select Subject</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            background: #0f172a;
            font-family: 'Inter', sans-serif;
            color: #e5e7eb;
        }

        .navbar {
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            padding: 14px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .nav-left {
            font-size: 15px;
            font-weight: 500;
            color: #111827;
        }

        .nav-left span {
            color: #2563eb;
            font-weight: 600;
        }

        .nav-right a {
            margin-left: 20px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            color: #374151;
            padding: 6px 10px;
            border-radius: 6px;
        }

        .nav-right a:hover {
            background: #e5e7eb;
        }

        .logout {
            color: #dc2626 !important;
        }

        .search-box {
            max-width: 400px;
            margin: 0 auto 20px;
        }

        .search-box input {
            width: 100%;
            padding: 12px 16px;
            border-radius: 10px;
            border: 1px solid #1e293b;
            background: #020617;
            color: #e5e7eb;
            font-size: 14px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto 50px;
            padding: 30px;
            background: #020617;
            border-radius: 18px;
            border: 1px solid #1e293b;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .subjects {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }

        .subject-card {
            background: #020617;
            border: 1px solid #1e293b;
            border-radius: 14px;
            padding: 24px;
            text-align: center;
            transition: 0.3s;
        }

        .subject-card:hover {
            transform: translateY(-4px);
            border-color: #38bdf8;
        }

        .subject-name {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 18px;
        }

        .open-btn {
            display: inline-block;
            padding: 10px 22px;
            border-radius: 25px;
            background: #38bdf8;
            color: #020617;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
        }

        .open-btn:hover {
            background: #0ea5e9;
        }

        .empty {
            text-align: center;
            color: #9ca3af;
            padding: 40px 0;
        }
    </style>
</head>

<body>

<div class="navbar">
    <div class="nav-left">
        Welcome,
        <span>
            <%= (loggedUser != null) ? loggedUser.getName() : "User" %>
        </span>
    </div>

    <div class="nav-right">
        <a href="<%= request.getContextPath() %>/user/topics">Topics</a>
        <a href="<%= request.getContextPath() %>/profile.jsp">Profile</a>
        <a class="logout" href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>
</div>

<div class="search-box">
    <input type="text"
           id="subjectSearch"
           placeholder="Search subjects..."
           onkeyup="filterSubjects()">
</div>

<div class="container">
    <h2>Select Subject</h2>

    <div class="subjects">
        <%
            if (subjects != null && !subjects.isEmpty()) {
                for (Subject s : subjects) {
        %>
        <div class="subject-card">
            <div class="subject-name"><%= s.getSubjectName() %></div>
            <a class="open-btn"
               href="<%= request.getContextPath() %>/user/topics?subjectId=<%= s.getSubjectId() %>">
                View Topics →
            </a>
        </div>
        <%
                }
            } else {
        %>
        <div class="empty">No subjects available</div>
        <%
            }
        %>
    </div>
</div>

<script>
function filterSubjects() {
    let input = document.getElementById("subjectSearch");
    let filter = input.value.toLowerCase();
    let cards = document.getElementsByClassName("subject-card");

    for (let i = 0; i < cards.length; i++) {
        let name = cards[i]
            .getElementsByClassName("subject-name")[0]
            .innerText.toLowerCase();

        cards[i].style.display = name.includes(filter) ? "" : "none";
    }
}
</script>

</body>
</html>