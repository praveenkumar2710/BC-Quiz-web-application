<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.model.User" %>

<%
    Boolean attempted = (Boolean) request.getAttribute("attempted");

    Integer scoreObj;
    Integer totalObj;

    if (attempted != null && attempted) {
        scoreObj = (Integer) request.getAttribute("prevScore");
        totalObj = 15;
    } else {
        scoreObj = (Integer) request.getAttribute("score");
        totalObj = (Integer) request.getAttribute("total");
    }

    int score = (scoreObj != null) ? scoreObj : 0;
    int total = (totalObj != null && totalObj > 0) ? totalObj : 15;

    int percent = (int)((score * 100.0) / total);

    String scoreColor =
            percent >= 70 ? "#22c55e" :
            percent >= 40 ? "#facc15" :
            "#ef4444";

    User loggedUser = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>BCQuiz | Result</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    min-height: 100vh;
    background: #f2f4f7;
    font-family: 'Inter', sans-serif;
    color: #1f2937;
    display: flex;
    flex-direction: column;
}

.navbar {
    background: #ffffff;
    border-bottom: 1px solid #e5e7eb;
    padding: 14px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-left {
    font-size: 15px;
    font-weight: 500;
}

.nav-left span {
    color: #2563eb;
    font-weight: 600;
}

.nav-right {
    display: flex;
    gap: 20px;
}

.nav-link {
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    color: #374151;
    padding: 6px 10px;
    border-radius: 6px;
}

.nav-link:hover {
    background: #e5e7eb;
}

.logout {
    color: #dc2626;
}

.logout:hover {
    background: #fee2e2;
}

.main {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

.result-card {
    width: 420px;
    background: #ffffff;
    border-radius: 16px;
    padding: 36px;
    text-align: center;
    box-shadow: 0 20px 50px rgba(0,0,0,0.08);
}

.result-card h2 {
    font-size: 26px;
    margin-bottom: 22px;
}

.score-circle {
    width: 140px;
    height: 140px;
    border-radius: 50%;
    margin: 0 auto 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    font-weight: 600;
    color: #111;
    background: <%= scoreColor %>;
}

.percent {
    font-size: 17px;
    margin-bottom: 14px;
}

.message {
    font-size: 15px;
    color: #4b5563;
}
</style>
</head>

<body>

<div class="navbar">
    <div class="nav-left">
        Welcome,
        <span><%= loggedUser != null ? loggedUser.getName() : "User" %></span>
    </div>

    <div class="nav-right">
        <a class="nav-link"
           href="<%= request.getContextPath() %>/user/subjects">
            Subjects
        </a>

        <a class="nav-link logout"
           href="<%= request.getContextPath() %>/LogoutServlet">
            Logout
        </a>
    </div>
</div>

<div class="main">
    <div class="result-card">

        <h2>
            <%= (attempted != null && attempted)
                    ? "Previously Attempted Quiz"
                    : "Quiz Result" %>
        </h2>

        <div class="score-circle">
            <%= score %>/<%= total %>
        </div>

        <div class="percent">
            <%= percent %>% Score
        </div>

        <div class="message">
            <%= percent >= 70 ? "Excellent performance 🎉" :
                percent >= 40 ? "Good effort 👍" :
                "Keep practicing 💪" %>
        </div>

    </div>
</div>

</body>
</html>