<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Question" %>
<%@ page import="com.model.User" %>

<%
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    User loggedUser = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>BCQuiz | Quiz</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    background: #f2f4f7;
    font-family: 'Inter', sans-serif;
    color: #1f2937;
    padding: 40px 0;
    display: flex;
    justify-content: center;
}

.quiz-container {
    width: 820px;
    background: #ffffff;
    border-radius: 14px;
    padding: 32px 56px 48px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.08);
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #f8fafc;
    padding: 14px 22px;
    border-radius: 12px;
    margin-bottom: 28px;
    border: 1px solid #e5e7eb;
}

.nav-left { font-size: 15px; font-weight: 500; }
.nav-left span { color: #2563eb; font-weight: 600; }

.nav-right { display: flex; gap: 18px; }

.nav-link {
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    color: #374151;
    padding: 6px 10px;
    border-radius: 6px;
}

.nav-link:hover { background: #e5e7eb; }

.logout { color: #dc2626; }

h2 {
    text-align: center;
    font-size: 26px;
    margin-bottom: 18px;
}

#timer {
    text-align: right;
    font-weight: 600;
    margin-bottom: 28px;
    color: #2563eb;
}

.question-card {
    margin-bottom: 36px;
    padding-bottom: 28px;
    border-bottom: 1px solid #e5e7eb;
}

.question-text {
    font-size: 16px;
    margin-bottom: 20px;
}

.option {
    display: block;
    padding: 14px 18px;
    margin-bottom: 12px;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    cursor: pointer;
}

.option:hover { background: #f9fafb; }

.option input { display: none; }

.option input:checked + span {
    color: #2563eb;
    font-weight: 600;
}

.submit-btn {
    display: block;
    margin: 50px auto 0;
    padding: 14px 48px;
    border-radius: 10px;
    border: none;
    background: #2563eb;
    color: #ffffff;
    cursor: pointer;
}
</style>
</head>

<body>

<div class="quiz-container">

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

    <h2>Quiz Assessment</h2>

    <div id="timer">
        Time Left: <span id="time">10:00</span>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/quiz">

        <%
        if (questions != null && !questions.isEmpty()) {
            for (Question q : questions) {
        %>

        <div class="question-card">
            <div class="question-text"><%= q.getQuestionText() %></div>

            <label class="option">
                <input type="radio" name="q_<%= q.getQuestionId() %>"
                       value="<%= q.getOptionA() %>" required>
                <span><%= q.getOptionA() %></span>
            </label>

            <label class="option">
                <input type="radio" name="q_<%= q.getQuestionId() %>"
                       value="<%= q.getOptionB() %>">
                <span><%= q.getOptionB() %></span>
            </label>

            <label class="option">
                <input type="radio" name="q_<%= q.getQuestionId() %>"
                       value="<%= q.getOptionC() %>">
                <span><%= q.getOptionC() %></span>
            </label>

            <label class="option">
                <input type="radio" name="q_<%= q.getQuestionId() %>"
                       value="<%= q.getOptionD() %>">
                <span><%= q.getOptionD() %></span>
            </label>
        </div>

        <%
            }
        } else {
        %>
        <h3 style="text-align:center;">No questions available</h3>
        <%
        }
        %>

        <button type="submit" class="submit-btn">Submit Quiz</button>
    </form>
</div>

<script>
let totalSeconds = 10 * 60;
const timerDisplay = document.getElementById("time");
const quizForm = document.querySelector("form");

function updateTimer() {
    let m = Math.floor(totalSeconds / 60);
    let s = totalSeconds % 60;

    timerDisplay.textContent =
        String(m).padStart(2, '0') + ":" + String(s).padStart(2, '0');

    if (totalSeconds <= 0) {
        alert("Time is up! Submitting quiz.");
        quizForm.submit();
        return;
    }
    totalSeconds--;
}
setInterval(updateTimer, 1000);
</script>

</body>
</html>